Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1407921074-19966-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1407921074-19966-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 13 Aug 2014 11:41:35 +0200
Message-ID: <CAMudyAvCUJjg2BJ-rZCJ6BwWZHWpzVONe-LVhOF2h_Vjn84f4g@mail.gmail.com>
Subject: Re: [PATCH] tools/l2test: And listen and not receive mode option
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 13 August 2014 11:11, Lukasz Rymanowski <lukasz.rymanowski@tieto.com> wrote:
> This patch adds -l option which allows to create listening l2cap socket
> without any send or receive action after connection is done.
>
> This is useful to trigger LOCAL BUSY mode in PTS ERTM testing.
> ---
>  tools/l2test.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/tools/l2test.c b/tools/l2test.c
> index 67ca70a..9fd3c46 100644
> --- a/tools/l2test.c
> +++ b/tools/l2test.c
> @@ -70,6 +70,7 @@ enum {
>         CSENDRECV,
>         INFOREQ,
>         PAIRING,
> +       LNRCV,
>  };
>
>  static unsigned char *buf;
> @@ -1036,6 +1037,12 @@ static void send_and_recv_mode(int sk)
>         return;
>  }
>
> +static void not_receive_mode(int sk) {
> +
> +       syslog(LOG_INFO, "Connected and not receiving !");
> +       while (1) {};
> +}
> +
>  static void reconnect_mode(char *svr)
>  {
>         while (1) {
> @@ -1290,6 +1297,7 @@ static void usage(void)
>                 "\t-d listen and dump incoming data\n"
>                 "\t-x listen, then send, then dump incoming data\n"
>                 "\t-t listen, then send and receive at the same time\n"
> +               "\t-l listen, then do nothing (don't receive, don't send)\n"
>                 "\t-q connect, then send and receive at the same time\n"
>                 "\t-s connect and send\n"
>                 "\t-u connect and receive\n"
> @@ -1335,7 +1343,7 @@ int main(int argc, char *argv[])
>
>         bacpy(&bdaddr, BDADDR_ANY);
>
> -       while ((opt = getopt(argc, argv, "rdscuwmntqxyzpb:a:"
> +       while ((opt = getopt(argc, argv, "rdlscuwmntqxyzpb:a:"
>                 "i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:H:K:V:RUGAESMT")) != EOF) {
>                 switch (opt) {
>                 case 'r':
> @@ -1360,6 +1368,10 @@ int main(int argc, char *argv[])
>                         mode = DUMP;
>                         break;
>
> +               case 'l':
> +                       mode = LNRCV;
> +                       break;
> +
>                 case 'c':
>                         mode = RECONNECT;
>                         need_addr = 1;
> @@ -1646,6 +1658,10 @@ int main(int argc, char *argv[])
>                 case PAIRING:
>                         do_pairing(argv[optind]);
>                         exit(0);
> +
> +               case LNRCV:
> +                       do_listen(not_receive_mode);
> +                       break;
>         }
>
>         syslog(LOG_INFO, "Exit");
> --
> 1.8.4
>

You can ignore this patch. Just find out that using optiion -r with a
delay (-K) and small receive buffer (-H) I can pass PTS test.

BR
Lukasz
