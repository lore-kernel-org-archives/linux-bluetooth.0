Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414596229-23184-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1414596229-23184-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<1414596229-23184-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Wed, 29 Oct 2014 16:46:07 +0100
Message-ID: <CAMv5GbdJSsUFrybrw-cynJFZ1+dOpAE5g18CAvswCrfkxps3dQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/mcaptest: Add no exit after MCL disconnect to mcaptool
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 29 October 2014 16:23, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@tieto.com> wrote:
> This is needed while reconnecting MCL or some PTS test cases:
> TC_MCAP_CM_REC_BV_x_C - test cases branch
> ---
>  tools/mcaptest.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/mcaptest.c b/tools/mcaptest.c
> index 6d50544..1bccb21 100644
> --- a/tools/mcaptest.c
> +++ b/tools/mcaptest.c
> @@ -67,6 +67,8 @@ static int mdl_disconnect_timeout = -1;
>
>  static struct mcap_mcl *mcl = NULL;
>
> +static gboolean no_close_after_mcl_disc = FALSE;
> +
>  #define REQ_CLOCK_ACC 0x1400
>
>  static void mdl_connected_cb(struct mcap_mdl *mdl, void *data)
> @@ -152,6 +154,9 @@ static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
>         /* TODO */
>         printf("MCL disconnected\n");
>
> +       if (no_close_after_mcl_disc)
> +               return;
> +
>         g_main_loop_quit(mloop);
>  }
>
> @@ -288,6 +293,7 @@ static void usage(void)
>                 "\t-f <timeout> disconnect MDL after it's connected\n"
>                 "\t-u send \'Unavailable\' on first MDL connection request\n");
>         printf("Options:\n"
> +               "\t-n don't exit after mcl disconnect \n"
>                 "\t-i <hcidev>        HCI device\n"
>                 "\t-C <control_ch>    Control channel PSM\n"
>                 "\t-D <data_ch>       Data channel PSM\n");
> @@ -302,6 +308,7 @@ static struct option main_options[] = {
>         { "connect_dl",         0, 0, 'd' },
>         { "disconnect_dl",      1, 0, 'f' },
>         { "unavailable_dl",     0, 0, 'u' },
> +       { "no exit mcl disc",   0, 0, 'n' },
>         { "control_ch",         1, 0, 'C' },
>         { "data_ch",            1, 0, 'D' },
>         { 0, 0, 0, 0 }
> @@ -323,7 +330,7 @@ int main(int argc, char *argv[])
>                 exit(1);
>         }
>
> -       while ((opt = getopt_long(argc, argv, "+i:c:C:D:e:f:dghu",
> +       while ((opt = getopt_long(argc, argv, "+i:c:C:D:e:f:dghun",
>                                                 main_options, NULL)) != EOF) {
>                 switch (opt) {
>                 case 'i':
> @@ -367,6 +374,11 @@ int main(int argc, char *argv[])
>
>                         break;
>
> +               case 'n':
> +                       no_close_after_mcl_disc = TRUE;
> +
> +                       break;
> +
>                 case 'C':
>                         ccpsm = atoi(optarg);
>
> --
> 1.9.3
>

I forgot to add checks for other exits (e.g. in case of MDL error).
Please don't apply I'll send v2

BR,
Grzegorz
