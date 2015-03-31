Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427829865-24711-1-git-send-email-armansito@chromium.org>
References: <1427829865-24711-1-git-send-email-armansito@chromium.org>
Date: Tue, 31 Mar 2015 12:48:45 -0700
Message-ID: <CAHrH25QNi7otX36-38Bbz_jzyoxwU6eFfGPm-+NBJw8JfymyVw@mail.gmail.com>
Subject: Re: [PATCH] tools/btgatt-server: Add option for src addr type
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> On Tue, Mar 31, 2015 at 12:24 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch adds the --type option to btgatt-server which allows
> the source bdaddr type to be specified. If the option is not
> provided, the source type defaults to BDADDR_LE_PUBLIC.
>
> This also fixes a bug in that manifests itself in later kernels
> that prevents an LE connection to be accepted when '0' is given for
> the source address type, where '0' corresponds to BDADDR_BREDR.
> ---
>  tools/btgatt-server.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
> index b4fbe60..b30a958 100644
> --- a/tools/btgatt-server.c
> +++ b/tools/btgatt-server.c
> @@ -630,6 +630,7 @@ static void usage(void)
>                 "\t-m, --mtu <mtu>\t\t\tThe ATT MTU to use\n"
>                 "\t-s, --security-level <sec>\tSet security level (low|"
>                                                                 "medium|high)\n"
> +               "\t-t, --type [random|public] \t The source address type\n"
>                 "\t-v, --verbose\t\t\tEnable extra logging\n"
>                 "\t-r, --heart-rate\t\tEnable Heart Rate service\n"
>                 "\t-h, --help\t\t\tDisplay help\n");
> @@ -639,13 +640,15 @@ static struct option main_options[] = {
>         { "index",              1, 0, 'i' },
>         { "mtu",                1, 0, 'm' },
>         { "security-level",     1, 0, 's' },
> +       { "type",               1, 0, 't' },
>         { "verbose",            0, 0, 'v' },
>         { "heart-rate",         0, 0, 'r' },
>         { "help",               0, 0, 'h' },
>         { }
>  };
>
> -static int l2cap_le_att_listen_and_accept(bdaddr_t *src, int sec)
> +static int l2cap_le_att_listen_and_accept(bdaddr_t *src, int sec,
> +                                                       uint8_t src_type)
>  {
>         int sk, nsk;
>         struct sockaddr_l2 srcaddr, addr;
> @@ -663,7 +666,7 @@ static int l2cap_le_att_listen_and_accept(bdaddr_t *src, int sec)
>         memset(&srcaddr, 0, sizeof(srcaddr));
>         srcaddr.l2_family = AF_BLUETOOTH;
>         srcaddr.l2_cid = htobs(ATT_CID);
> -       srcaddr.l2_bdaddr_type = 0;
> +       srcaddr.l2_bdaddr_type = src_type;
>         bacpy(&srcaddr.l2_bdaddr, src);
>
>         if (bind(sk, (struct sockaddr *) &srcaddr, sizeof(srcaddr)) < 0) {
> @@ -1131,12 +1134,13 @@ int main(int argc, char *argv[])
>         int dev_id = -1;
>         int fd;
>         int sec = BT_SECURITY_LOW;
> +       uint8_t src_type = BDADDR_LE_PUBLIC;
>         uint16_t mtu = 0;
>         sigset_t mask;
>         bool hr_visible = false;
>         struct server *server;
>
> -       while ((opt = getopt_long(argc, argv, "+hvrs:m:i:",
> +       while ((opt = getopt_long(argc, argv, "+hvrs:t:m:i:",
>                                                 main_options, NULL)) != -1) {
>                 switch (opt) {
>                 case 'h':
> @@ -1160,6 +1164,17 @@ int main(int argc, char *argv[])
>                                 return EXIT_FAILURE;
>                         }
>                         break;
> +               case 't':
> +                       if (strcmp(optarg, "random") == 0)
> +                               src_type = BDADDR_LE_RANDOM;
> +                       else if (strcmp(optarg, "public") == 0)
> +                               src_type = BDADDR_LE_PUBLIC;
> +                       else {
> +                               fprintf(stderr,
> +                                       "Allowed types: random, public\n");
> +                               return EXIT_FAILURE;
> +                       }
> +                       break;
>                 case 'm': {
>                         int arg;
>
> @@ -1207,7 +1222,7 @@ int main(int argc, char *argv[])
>                 return EXIT_FAILURE;
>         }
>
> -       fd = l2cap_le_att_listen_and_accept(&src_addr, sec);
> +       fd = l2cap_le_att_listen_and_accept(&src_addr, sec, src_type);
>         if (fd < 0) {
>                 fprintf(stderr, "Failed to accept L2CAP ATT connection\n");
>                 return EXIT_FAILURE;
> --
> 2.2.0.rc0.207.ga3a616c
>

Pushed.

Thanks,
Arman
