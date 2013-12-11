Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Dec 2013 13:10:38 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 3/7] android/tester: Start emulator in new process
Message-ID: <20131211111036.GC18372@aemeltch-MOBL1>
References: <1386758797-1809-1-git-send-email-marcin.kraglak@tieto.com>
 <1386758797-1809-3-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386758797-1809-3-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Dec 11, 2013 at 11:46:33AM +0100, Marcin Kraglak wrote:
> This is needed because bluetooth->init call is blocking,
> and we have to emulate normal behaviour of android environment.
> That process will exit if it won't receive any message in 2 sec
> or when bluetoothd will exit. Main tester thread will wait for
> this process in teardown method.
> ---
>  android/android-tester.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 131 insertions(+), 1 deletion(-)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index 498da22..ad7aa39 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -15,9 +15,15 @@
>   *
>   */
>  
> +#include <stdlib.h>
>  #include <unistd.h>
>  
>  #include <glib.h>
> +#include <sys/socket.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/un.h>
> +#include <libgen.h>
>  
>  #include "lib/bluetooth.h"
>  #include "lib/mgmt.h"
> @@ -29,14 +35,20 @@
>  struct generic_data {
>  };
>  
> +#define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
> +#define EMULATOR_SIGNAL "emulator_started"
> +
>  struct test_data {
>  	struct mgmt *mgmt;
>  	uint16_t mgmt_index;
>  	struct hciemu *hciemu;
>  	enum hciemu_type hciemu_type;
>  	const struct generic_data *test_data;
> +	pid_t bluetoothd_pid;
>  };
>  
> +static char exec_dir[PATH_MAX + 1];
> +
>  static void read_info_callback(uint8_t status, uint16_t length,
>  					const void *param, void *user_data)
>  {
> @@ -165,13 +177,129 @@ static void test_post_teardown(const void *test_data)
>  	data->hciemu = NULL;
>  }
>  
> +static void bluetoothd_start(int hci_index)
> +{
> +	char prg_name[PATH_MAX + 1];
> +	char index[8];
> +	char *prg_argv[4];
> +
> +	snprintf(prg_name, sizeof(prg_name), "%s/%s", exec_dir, "bluetoothd");
> +	snprintf(index, sizeof(index), "%d", hci_index);
> +
> +	prg_argv[0] = prg_name;
> +	prg_argv[1] = "-i";
> +	prg_argv[2] = index;
> +	prg_argv[3] = NULL;
> +
> +	if (!tester_use_debug())
> +		fclose(stderr);
> +
> +	execve(prg_argv[0], prg_argv, NULL);
> +}
> +
> +static void emulator(int pipe, int hci_index)
> +{
> +	static const char SYSTEM_SOCKET_PATH[] = "\0android_system";
> +	char buf[1024];
> +	struct sockaddr_un addr;
> +	struct timeval tv;
> +	int fd;
> +	ssize_t len;
> +
> +	fd = socket(PF_LOCAL, SOCK_DGRAM | SOCK_CLOEXEC, 0);
> +	if (fd < 0)
> +		goto failed;

return? otherwise you close invalid fd, or check fd in failed 

> +
> +	tv.tv_sec = WAIT_FOR_SIGNAL_TIME;
> +	tv.tv_usec = 0;
> +	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (char *)&tv, sizeof(tv));
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.sun_family = AF_UNIX;
> +	memcpy(addr.sun_path, SYSTEM_SOCKET_PATH, sizeof(SYSTEM_SOCKET_PATH));
> +
> +	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> +		perror("Failed to bind system socket");
> +		goto failed;
> +	}
> +
> +	len = write(pipe, EMULATOR_SIGNAL, sizeof(EMULATOR_SIGNAL));
> +

we do not need here empty space

Best regards 
Andrei Emeltchenko 
> +	if (len != sizeof(EMULATOR_SIGNAL))
> +		goto failed;
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	len = read(fd, buf, sizeof(buf));
> +	if (len <= 0 || (strcmp(buf, "ctl.start=bluetoothd")))
> +		goto failed;
> +
> +	close(pipe);
> +	close(fd);
> +	bluetoothd_start(hci_index);
> +
> +failed:
> +	close(pipe);
> +	close(fd);
> +}
> +
> +static void setup(struct test_data *data)
> +{
> +	int signal_fd[2];
> +	char buf[1024];
> +	pid_t pid;
> +	int len;
> +
> +	if (pipe(signal_fd)) {
> +		tester_setup_failed();
> +		return;
> +	}
> +
> +	pid = fork();
> +
> +	if (pid < 0) {
> +		close(signal_fd[0]);
> +		close(signal_fd[1]);
> +		tester_setup_failed();
> +		return;
> +	}
> +
> +	if (pid == 0) {
> +		if (!tester_use_debug())
> +			fclose(stderr);
> +
> +		close(signal_fd[0]);
> +		emulator(signal_fd[1], data->mgmt_index);
> +		exit(0);
> +	}
> +
> +	close(signal_fd[1]);
> +	data->bluetoothd_pid = pid;
> +
> +	len = read(signal_fd[0], buf, sizeof(buf));
> +	if (len <= 0 || (strcmp(buf, EMULATOR_SIGNAL))) {
> +		close(signal_fd[0]);
> +		tester_setup_failed();
> +		return;
> +	}
> +}
> +
>  static void setup_base(const void *test_data)
>  {
> -	tester_setup_failed();
> +	struct test_data *data = tester_get_data();
> +
> +	setup(data);
> +
> +	tester_setup_complete();
>  }
>  
>  static void teardown(const void *test_data)
>  {
> +	struct test_data *data = tester_get_data();
> +
> +	if (data->bluetoothd_pid)
> +		waitpid(data->bluetoothd_pid, NULL, 0);
> +
>  	tester_teardown_complete();
>  }
>  
> @@ -194,6 +322,8 @@ static void controller_setup(const void *test_data)
>  
>  int main(int argc, char *argv[])
>  {
> +	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
> +
>  	tester_init(&argc, &argv);
>  
>  	test_bredrle("Test Init", NULL, setup_base, controller_setup, teardown);
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
