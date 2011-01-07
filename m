Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4765B7BC10CB4C488A56C73E15D6FBA31DA376A45B@EXDCVYMBSTM005.EQ1STM.local>
References: <4765B7BC10CB4C488A56C73E15D6FBA31DA376A45B@EXDCVYMBSTM005.EQ1STM.local>
Date: Fri, 7 Jan 2011 14:05:07 -0300
Message-ID: <AANLkTimZk4FrRBGSp=W1LciZnrwjAqmm3k71tLA4AEYV@mail.gmail.com>
Subject: Re: [PATCH] HCI Commands for LE White List
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Sumit Kumar BAJPAI <sumitkumar.bajpai@stericsson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sumit,

Could you please split this patch into minor functional patches?

On Thu, Jan 6, 2011 at 12:52 AM, Sumit Kumar BAJPAI
<sumitkumar.bajpai@stericsson.com> wrote:
> Added HCI commands for LE White List support.
> These LE White List Commands can be tested from
> hcitool.
>
>
> ---
>  lib/hci.c       |  107 +++++++++++++++++++++++++++++++
>  lib/hci_lib.h   |    4 +
>  tools/hcitool.c |  186 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 297 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 lib/hci.c
>  mode change 100644 => 100755 lib/hci_lib.h
>
> diff --git a/lib/hci.c b/lib/hci.c
> old mode 100644
> new mode 100755
> index 048fda4..5a0275c
> --- a/lib/hci.c
> +++ b/lib/hci.c
> @@ -1291,6 +1291,113 @@ int hci_disconnect(int dd, uint16_t handle, uint8_t reason, int to)
>        return 0;
>  }
>
> +int hci_le_add_to_white_list(int dd, bdaddr_t addr, uint8_t type)
Use pointer for bdaddr_t
address types have defined values in the BT spec, declare an enum in hci.h

> +{
> +       struct hci_request rq;
> +       le_add_device_to_white_list_cp param_cp;
It seems that you copied this declaration from set scan parameters
function. Use only "cp", it is short for command parameters.

> +       uint8_t status;
> +
> +       memset(&param_cp, 0, sizeof(param_cp));
> +       param_cp.bdaddr_type = type;
> +       param_cp.bdaddr= addr;
> +
> +       memset(&rq, 0, sizeof(rq));
> +       rq.ogf = OGF_LE_CTL;
> +       rq.ocf = OCF_LE_ADD_DEVICE_TO_WHITE_LIST;
> +       rq.cparam = &param_cp;
> +       rq.clen = LE_ADD_DEVICE_TO_WHITE_LIST_CP_SIZE;
> +       rq.rparam = &status;
> +       rq.rlen = 1;
> +
> +       if (hci_send_req(dd, &rq, 100) < 0)
> +               return -1;
Use 1000, we are noticing timeout on some LE hardwares.

> +
> +       if (status) {
> +               errno = EIO;
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +int hci_le_remove_from_white_list(int dd, bdaddr_t addr, uint8_t type)
> +{
Same comment about address type and bdaddr_t pointer

> +       struct hci_request rq;
> +       le_remove_device_from_white_list_cp param_cp;
Same comment about param_cp: s/param_cp/cp

> +       uint8_t status;
> +
> +       memset(&param_cp, 0, sizeof(param_cp));
> +       param_cp.bdaddr_type = type;
> +       param_cp.bdaddr= addr;
> +
> +       memset(&rq, 0, sizeof(rq));
> +       rq.ogf = OGF_LE_CTL;
> +       rq.ocf = OCF_LE_REMOVE_DEVICE_FROM_WHITE_LIST;
> +       rq.cparam = &param_cp;
> +       rq.clen = LE_REMOVE_DEVICE_FROM_WHITE_LIST_CP_SIZE;
> +       rq.rparam = &status;
> +       rq.rlen = 1;
> +
> +       if (hci_send_req(dd, &rq, 100) < 0)
> +               return -1;
Use 1000

> +
> +       if (status) {
> +               errno = EIO;
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +int hci_le_read_white_list_size(int dd)
> +{
> +       struct hci_request rq;
> +       le_read_white_list_size_rp param_cp;
Rename param_cp to rp

> +
> +       memset(&param_cp, 0, sizeof(param_cp));
> +       param_cp.size=0;
> +
> +       memset(&rq, 0, sizeof(rq));
> +       rq.ogf = OGF_LE_CTL;
> +       rq.ocf = OCF_LE_READ_WHITE_LIST_SIZE;
> +       rq.rparam = &param_cp;
> +       rq.rlen = LE_READ_WHITE_LIST_SIZE_RP_SIZE;
> +
> +       if (hci_send_req(dd, &rq, 100) < 0)
> +               return -1;
> +
> +       if (param_cp.status) {
> +               errno = EIO;
> +               return -1;
> +       }
> +
> +       printf("LE White list size= %d\n", param_cp.size);
printf? the size should be returned to the caller.
Suggestion: add a pointer in the function parameters
if (size)
    *size = param_cp.size;

> +
> +       return 0;
> +}
> +
> +int hci_le_clear_white_list(int dd)
> +{
> +       struct hci_request rq;
> +       uint8_t status;
> +
> +       memset(&rq, 0, sizeof(rq));
> +       rq.ogf = OGF_LE_CTL;
> +       rq.ocf = OCF_LE_CLEAR_WHITE_LIST;
> +       rq.rparam = &status;
> +       rq.rlen = 1;
> +
> +       if (hci_send_req(dd, &rq, 100) < 0)
Use 1000

> +               return -1;
> +
> +       if (status) {
> +               errno = EIO;
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
>  int hci_read_local_name(int dd, int len, char *name, int to)
>  {
>        read_local_name_rp rp;
> diff --git a/lib/hci_lib.h b/lib/hci_lib.h
> old mode 100644
> new mode 100755
> index b63a2a4..ed74dfc
> --- a/lib/hci_lib.h
> +++ b/lib/hci_lib.h
> @@ -127,6 +127,10 @@ int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
>                uint16_t latency, uint16_t supervision_timeout,
>                uint16_t min_ce_length, uint16_t max_ce_length,
>                uint16_t *handle, int to);
> +int hci_le_add_to_white_list(int dd, bdaddr_t addr, uint8_t type);
> +int hci_le_remove_from_white_list(int dd, bdaddr_t addr, uint8_t type);
> +int hci_le_read_white_list_size(int dd);
> +int hci_le_clear_white_list(int dd);
>
>  int hci_for_each_dev(int flag, int(*func)(int dd, int dev_id, long arg), long arg);
>  int hci_get_route(bdaddr_t *bdaddr);
> diff --git a/tools/hcitool.c b/tools/hcitool.c
> index d50adaf..387c47c 100644
> --- a/tools/hcitool.c
> +++ b/tools/hcitool.c
> @@ -2471,6 +2471,188 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
>        hci_close_dev(dd);
>  }
>
> +static struct option leaddwl_options[] = {
> +       { "help",       0, 0, 'h' },
> +       { 0, 0, 0, 0 }
> +};
> +
> +static const char *leaddwl_help =
> +       "Usage:\n"
> +       "\tleaddwl <bdaddr>\n";
> +
> +static void cmd_leaddwl(int dev_id, int argc,char **argv)
> +{
> +       int err, opt, dd;
> +       bdaddr_t bdaddr;
> +       uint8_t bdaddr_type;
> +
> +       for_each_opt(opt, leaddwl_options, NULL) {
> +               switch (opt) {
> +               default:
> +                       printf("%s", leaddwl_help);
> +                       return;
> +               }
> +       }
> +       helper_arg(1, 1, &argc, &argv, leaddwl_help);
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
> +       str2ba(argv[1], &bdaddr);
> +       bdaddr_type = 0x00;
Use enum

> +
> +       err = hci_le_add_to_white_list(dd, bdaddr ,bdaddr_type);
Missing space before bdaddr_type

> +       if (err < 0) {
> +               perror("Cant add to white list");
> +               exit(1);
> +       }
wrong coding style

> +       else {
> +               printf("Device added to white list");
> +       }
"{" not necessary

> +
> +       hci_close_dev(dd);
Move this line after "hci_le_add_to_white_list()" call, otherwise dd
will not be closed if the cmd fails

> +
remove empty line
> +}
> +
> +static struct option lermwl_options[] = {
> +       { "help",       0, 0, 'h' },
> +       { 0, 0, 0, 0 }
> +};
> +
> +static const char *lermwl_help =
> +       "Usage:\n"
> +       "\tlermwl <bdaddr>\n";
> +
> +static void cmd_lermwl(int dev_id, int argc,char **argv)
> +{
> +       int err, opt, dd;
> +       bdaddr_t bdaddr;
> +       uint8_t bdaddr_type;
> +
> +       for_each_opt(opt, lermwl_options, NULL) {
> +               switch (opt) {
> +               default:
> +                       printf("%s", lermwl_help);
> +                       return;
> +               }
> +       }
> +       helper_arg(1, 1, &argc, &argv, lermwl_help);
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
> +       str2ba(argv[1], &bdaddr);
> +       bdaddr_type = 0x00;
> +
> +       err = hci_le_remove_from_white_list(dd, bdaddr ,bdaddr_type);
> +       if (err < 0) {
> +               perror("Cant remove from white list");
> +               exit(1);
> +       }
> +        else {
> +               printf("Device removed from white list");
> +       }
> +
> +       hci_close_dev(dd);
Same coding style issue and close "dd"

> +
> +}
> +
> +static struct option lerdwlsz_options[] = {
> +       { "help",       0, 0, 'h' },
> +       { 0, 0, 0, 0 }
> +};
> +
> +static const char *lerdwlsz_help =
> +       "Usage:\n"
> +       "\tlerdwlsz\n";
> +
> +static void cmd_lerdwlsz(int dev_id, int argc,char **argv)
> +{
> +       int err,dd, opt;
> +
> +       for_each_opt(opt, lerdwlsz_options, NULL) {
> +               switch (opt) {
> +               default:
> +                       printf("%s", lerdwlsz_help);
> +                       return;
> +               }
> +       }
Add empty line here
> +       helper_arg(0, 0, &argc, &argv, lermwl_help);
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
> +       err = hci_le_read_white_list_size(dd);
> +       if (err < 0) {
> +               perror("Cant read white list size");
> +               exit(1);
> +       }
> +
> +       hci_close_dev(dd);
Missing close dd if the cmd fails
Remove empty line here
> +
> +}
> +
> +
Remove empty line here
> +static struct option leclrwl_options[] = {
> +       { "help",       0, 0, 'h' },
> +       { 0, 0, 0, 0 }
> +};
> +
> +static const char *leclrwl_help =
> +       "Usage:\n"
> +       "\tleclrwl\n";
> +
> +static void cmd_leclrwl(int dev_id, int argc,char **argv)
> +{
> +       int err,dd, opt;
> +
> +       for_each_opt(opt, leclrwl_options, NULL) {
> +               switch (opt) {
> +               default:
> +                       printf("%s", leclrwl_help);
> +                       return;
> +               }
> +       }
> +       helper_arg(0, 0, &argc, &argv, leclrwl_help);
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
> +       err = hci_le_clear_white_list(dd);
> +       if (err < 0) {
> +               perror("Cant clear white list");
> +               exit(1);
> +       }
> +
> +       hci_close_dev(dd);
Missing close dd when the cmd fails
Remove empty line here

Claudio
> +
> +}
> +
> +
Remove empty line here
>  static struct option ledc_options[] = {
>        { "help",       0, 0, 'h' },
>        { 0, 0, 0, 0 }
> @@ -2547,6 +2729,10 @@ static struct {
>        { "clkoff", cmd_clkoff, "Read clock offset"                    },
>        { "clock",  cmd_clock,  "Read local or remote clock"           },
>        { "lescan", cmd_lescan, "Start LE scan"                        },
> +       { "leaddwl", cmd_leaddwl, "Add this device to white list"          },
> +       { "lermwl", cmd_lermwl, "Remove this device from white list"   },
> +       { "lerdwlsz",  cmd_lerdwlsz,  "Read white list size"               },
> +       { "leclrwl",   cmd_leclrwl,   "Clear white list"                   },
>        { "lecc",   cmd_lecc,   "Create a LE Connection",              },
>        { "ledc",   cmd_ledc,   "Disconnect a LE Connection",          },
>        { NULL, NULL, 0 }
> --
> 1.6.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
