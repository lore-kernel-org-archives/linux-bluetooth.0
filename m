Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4765B7BC10CB4C488A56C73E15D6FBA31DA570022B@EXDCVYMBSTM005.EQ1STM.local>
References: <Acu7rVNvOBedYcdARMSYulxGD8ZxFg==>
	<4765B7BC10CB4C488A56C73E15D6FBA31DA570022B@EXDCVYMBSTM005.EQ1STM.local>
Date: Mon, 24 Jan 2011 07:52:18 -0400
Message-ID: <AANLkTinuSJTq+QSXChjROqC19_+dZdP5TWqgkMj-MkwZ@mail.gmail.com>
Subject: Re: [PATCH 3/4] HCI command to read size of LE White List
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Sumit Kumar BAJPAI <sumitkumar.bajpai@stericsson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 24, 2011 at 5:59 AM, Sumit Kumar BAJPAI
<sumitkumar.bajpai@stericsson.com> wrote:
> diff --git a/tools/hcitool.c b/tools/hcitool.c
> index 038d05e..e80c7a3 100755
> --- a/tools/hcitool.c
> +++ b/tools/hcitool.c
> @@ -2563,6 +2563,46 @@ static void cmd_lermwl(int dev_id, int argc, char **argv)
>        }
>  }
>
> +static struct option lerdwlsz_options[] = {
> +       { "help",       0, 0, 'h' },
> +       { 0, 0, 0, 0 }
> +};
> +
> +static const char *lerdwlsz_help =
> +       "Usage:\n"
> +       "\tlerdwlsz\n";
> +
> +static void cmd_lerdwlsz(int dev_id, int argc, char **argv)
> +{
> +       int err, dd, opt, size;
> +
> +       for_each_opt(opt, lerdwlsz_options, NULL) {
> +               switch (opt) {
> +               default:
> +                       printf("%s", lerdwlsz_help);
> +                       return;
> +               }
> +       }
> +       helper_arg(0, 0, &argc, &argv, lermwl_help);

You are using the wrong *_help variable above.

> +
> +       if (dev_id < 0)
> +               dev_id = hci_get_route(NULL);
> +
> +       dd = hci_open_dev(dev_id);
> +       if (dd < 0) {
> +               perror("Could not open device");
> +               exit(1);
> +       }
> +
> +       err = hci_le_read_white_list_size(dd, &size);
> +       hci_close_dev(dd);
> +
> +       if (err < 0) {
> +               perror("Cant read white list size");
> +               exit(1);
> +       }
> +}
> +
>  static struct option ledc_options[] = {
>        { "help",       0, 0, 'h' },
>        { 0, 0, 0, 0 }
> @@ -2641,6 +2681,7 @@ static struct {
>        { "lescan", cmd_lescan, "Start LE scan"                        },
>        { "leaddwl", cmd_leaddwl, "Add this device to white list"          },
>        { "lermwl", cmd_lermwl, "Remove this device from white list"   },
> +       { "lerdwlsz",  cmd_lerdwlsz,  "Read white list size"               },
>        { "lecc",   cmd_lecc,   "Create a LE Connection",              },
>        { "ledc",   cmd_ledc,   "Disconnect a LE Connection",          },
>        { NULL, NULL, 0 }
> --
> 1.6.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
