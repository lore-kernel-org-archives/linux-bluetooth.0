Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Dec 2013 10:18:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/tester: Add Socket test close and listen
Message-ID: <20131219081848.GC31549@x220.p-661hnu-f1>
References: <1387379717-1457-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387379717-1457-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Dec 18, 2013, Andrei Emeltchenko wrote:
> This test the situation when Android close file descriptor we passed to
> it and try to listen() again.
> ---
>  android/android-tester.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index 8a2861e..cb8fb4e 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -1141,6 +1141,57 @@ clean:
>  		close(sock_fd);
>  }
>  
> +static void test_listen_close(const void *test_data)
> +{
> +	struct test_data *data = tester_get_data();
> +	const struct socket_data *test = data->test_data;
> +	bt_status_t status;
> +	int sock_fd = -1;
> +
> +	status = data->if_sock->listen(test->sock_type,
> +					test->service_name, test->service_uuid,
> +					test->channel, &sock_fd, test->flags);
> +	if (status != test->expected_status) {
> +		tester_test_failed();
> +		goto clean;
> +	}
> +
> +	/* Check that file descriptor is valid */
> +	if (status == BT_STATUS_SUCCESS && fcntl(sock_fd, F_GETFD) == -1) {

We usually check for failures like this with < 0 instead of == -1.

> +	status = data->if_sock->listen(test->sock_type,
> +					test->service_name, test->service_uuid,
> +					test->channel, &sock_fd, test->flags);
> +	if (status != test->expected_status) {
> +		tester_test_failed();
> +		goto clean;
> +	}

You've got many different conditions that can trigger
tester_test_failed but no tester_warn() logs for each one to make
debugging easy if these new tests start failing. Please add those.
Otherwise once there's a regression it's going to be a real pain for you
to track down exactly what's broken.

Johan
