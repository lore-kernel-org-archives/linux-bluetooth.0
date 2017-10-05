Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <caa787c0-e9f7-a917-fec9-0edb4e8fa1ec@jp.fujitsu.com>
References: <caa787c0-e9f7-a917-fec9-0edb4e8fa1ec@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 5 Oct 2017 16:41:58 +0300
Message-ID: <CABBYNZ+ZgiPcNNnDjm2ApjonageM7iKjHhcpwC4tjuJp1jyu3Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/2] monitor: Fix buffer overflow with unix socket
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Wed, Oct 4, 2017 at 9:23 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> If btmon uses a unix socket, which has a long pathname, then the
> buffer overflow occurs as below:
>
>  *** strcpy_chk: buffer overflow detected ***: program terminated
>     at 0x4C3085C: ??? (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>     by 0x4C34E46: __strcpy_chk (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>     by 0x4084FE: strcpy (string3.h:110)
>     by 0x4084FE: control_server (control.c:1148)
>     by 0x4029E9: main (main.c:144)
>
> This patch also gives an error and stops running when parsing command-line
> arguments if the unix socket pathname is too long. And this patch adds the
> redundant check in control_server() to prevent the regression when reusing
> in the future.
> ---
> Changes in v2:
>  - split v1 patch into this patch for btmon and another patch for btproxy.
>  - move the check of pathname length before unlink()
>  - fail in control_server() if pathname length is too long.
>  - fix error message.
>
>  monitor/control.c | 9 ++++++++-
>  monitor/main.c    | 6 ++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/control.c b/monitor/control.c
> index 9bbdc37..1cd79ca 100644
> --- a/monitor/control.c
> +++ b/monitor/control.c
> @@ -1130,11 +1130,18 @@ static int server_fd = -1;
>  void control_server(const char *path)
>  {
>         struct sockaddr_un addr;
> +       size_t len;
>         int fd;
>
>         if (server_fd >= 0)
>                 return;
>
> +       len = strlen(path);
> +       if (len > sizeof(addr.sun_path) - 1) {
> +               fprintf(stderr, "Socket name too long\n");
> +               return;
> +       }
> +
>         unlink(path);
>
>         fd = socket(PF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
> @@ -1145,7 +1152,7 @@ void control_server(const char *path)
>
>         memset(&addr, 0, sizeof(addr));
>         addr.sun_family = AF_UNIX;
> -       strcpy(addr.sun_path, path);
> +       strncpy(addr.sun_path, path, len);
>
>         if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
>                 perror("Failed to bind server socket");
> diff --git a/monitor/main.c b/monitor/main.c
> index b4e9a6a..3e61a46 100644
> --- a/monitor/main.c
> +++ b/monitor/main.c
> @@ -31,6 +31,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <getopt.h>
> +#include <sys/un.h>
>
>  #include "src/shared/mainloop.h"
>  #include "src/shared/tty.h"
> @@ -114,6 +115,7 @@ int main(int argc, char *argv[])
>
>         for (;;) {
>                 int opt;
> +               struct sockaddr_un addr;
>
>                 opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tTSAE:vh",
>                                                 main_options, NULL);
> @@ -141,6 +143,10 @@ int main(int argc, char *argv[])
>                         analyze_path = optarg;
>                         break;
>                 case 's':
> +                       if (strlen(optarg) > sizeof(addr.sun_path) - 1) {
> +                               fprintf(stderr, "Socket name too long\n");
> +                               return EXIT_FAILURE;
> +                       }
>                         control_server(optarg);
>                         break;
>                 case 'p':
> --
> 2.7.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
