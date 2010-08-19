Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1282232587-14551-1-git-send-email-anderson.briglia@openbossa.org>
References: <1282232587-14551-1-git-send-email-anderson.briglia@openbossa.org>
Date: Thu, 19 Aug 2010 13:36:37 -0300
Message-ID: <AANLkTinVA+hkzmnTGFEp-veWaEkjywq-Z9OLmqpihA=E@mail.gmail.com>
Subject: Re: [PATCH] hciconfig: add LE_SET_ADVERTISE_ENABLE cmd
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Briglia,

On Thu, Aug 19, 2010 at 12:43 PM, Anderson Briglia
<anderson.briglia@openbossa.org> wrote:
> This patch implements two new hciconfig commands: leadv and noleadv.
> These new hciconfig flags are responsible to LE_SET_ADVERTISE_ENABLE
> command implementation.
> ---
>  lib/hci.c         |    1 +
>  lib/hci.h         |    1 +
>  tools/hciconfig.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 0 deletions(-)
>
> diff --git a/lib/hci.c b/lib/hci.c
> index 3304daa..64ac5f2 100644
> --- a/lib/hci.c
> +++ b/lib/hci.c
> @@ -188,6 +188,7 @@ static hci_map dev_flags_map[] = {
>        { "INQUIRY", HCI_INQUIRY },
>        { "AUTH",    HCI_AUTH    },
>        { "ENCRYPT", HCI_ENCRYPT },
> +       { "LEADV",   HCI_LE_ADV  },
>        { NULL }
>  };
>
> diff --git a/lib/hci.h b/lib/hci.h
> index 512dab9..8b9d33f 100644
> --- a/lib/hci.h
> +++ b/lib/hci.h
> @@ -73,6 +73,7 @@ enum {
>        HCI_INQUIRY,
>
>        HCI_RAW,
> +       HCI_LE_ADV,
>  };
I prefer this small change in another commit, it needs your previous
kernel patch to work/test properly.

>
>  /* HCI ioctl defines */
> diff --git a/tools/hciconfig.c b/tools/hciconfig.c
> index 87dd127..ba12a8a 100644
> --- a/tools/hciconfig.c
> +++ b/tools/hciconfig.c
> @@ -149,6 +149,50 @@ static void cmd_scan(int ctl, int hdev, char *opt)
>        }
>  }
>
> +static void cmd_le_adv(int ctl, int hdev, char *opt)
> +{
> +
No empty line here!

> +       struct hci_request rq;
> +       le_set_advertise_enable_cp advertise_cp;
> +       uint8_t status;
> +       uint8_t enable;
"enable" can be declared in the same line of "status"

> +       int dd, ret;
> +
> +       if (hdev < 0)
> +               hdev = hci_get_route(NULL);
> +
> +       dd = hci_open_dev(hdev);
> +       if (dd < 0) {
> +               perror("Could not open device");
> +               exit(1);
> +       }
> +
> +       enable = 0x01;
> +       if (!strcmp(opt, "noleadv"))
> +               enable = 0x00;
> +
> +       memset(&advertise_cp, 0, sizeof(advertise_cp));
> +       advertise_cp.enable = enable;
> +
> +       memset(&rq, 0, sizeof(rq));
> +       rq.ogf = OGF_LE_CTL;
> +       rq.ocf = OCF_LE_SET_ADVERTISE_ENABLE;
> +       rq.cparam = &advertise_cp;
> +       rq.clen = LE_SET_ADVERTISE_ENABLE_CP_SIZE;
> +       rq.rparam = &status;
> +       rq.rlen = 1;
> +
> +       ret = hci_send_req(dd, &rq, 100);
> +
No empty line here.
> +       if (status || ret < 0) {
> +               errno = EIO;
No need to set errno. hci_send_req sets errno when needed.

Claudio

> +               fprintf(stderr, "Can't set advertise mode on hci%d: %s (%d)\n",
> +                                               hdev, strerror(errno), errno);
> +       }
> +
> +       hci_close_dev(dd);
> +}
> +
>  static void cmd_iac(int ctl, int hdev, char *opt)
>  {
>        int s = hci_open_dev(hdev);
> @@ -1728,6 +1772,8 @@ static struct {
>        { "revision",   cmd_revision,   0,              "Display revision information" },
>        { "block",      cmd_block,      "<bdaddr>",     "Add a device to the blacklist" },
>        { "unblock",    cmd_unblock,    "<bdaddr>",     "Remove a device from the blacklist" },
> +       { "leadv",      cmd_le_adv,     0,              "Enable LE advertising" },
> +       { "noleadv",    cmd_le_adv,     0,              "Disable LE advertising" },
>        { NULL, NULL, 0 }
>  };
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
