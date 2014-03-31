Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1396093026-28414-2-git-send-email-kernel@gkr.i24.cc>
References: <20140328194907.GA24300@t440s.P-661HNU-F1>
	<1396093026-28414-1-git-send-email-kernel@gkr.i24.cc>
	<1396093026-28414-2-git-send-email-kernel@gkr.i24.cc>
Date: Mon, 31 Mar 2014 08:17:06 -0400
Message-ID: <CAJdJm_OWizW0sgvCFAbHBJ=moTggS5d2S5PnKU4Zc3qGPM6nrQ@mail.gmail.com>
Subject: Re: [PATCH] hid2hci add CSR 8510 A10 support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Gordon <kernel@gkr.i24.cc>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gordon,

A few more coding style suggestions below.

On Sat, Mar 29, 2014 at 7:37 AM, Gordon <kernel@gkr.i24.cc> wrote:
> diff --git a/tools/hid2hci.c b/tools/hid2hci.c
> index 2dbfca7..1f64b41 100644
> --- a/tools/hid2hci.c
> +++ b/tools/hid2hci.c
> @@ -119,6 +119,49 @@ static int usb_switch_csr(int fd, enum mode mode)
>         return err;
>  }
>
> +static int usb_switch_csr2(int fd, enum mode mode)
> +{
> +       int err;
> +       struct usbfs_disconnect disconnect;
> +       uint8_t report[] = {
> +               0x01, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +       };

Add an empty line here to separate variable declarations.

> +       switch (mode) {
> +       case HCI:
> +               /* send report as is */
> +               disconnect.interface = 0;
> +               disconnect.flags = USBFS_DISCONNECT_EXCEPT_DRIVER;
> +               strcpy(disconnect.driver, "usbfs");
> +
> +               if (ioctl(fd, USBFS_IOCTL_DISCONNECT, &disconnect) < 0) {
> +                       fprintf(stderr, "Can't claim interface: %s (%d)\n",
> +                               strerror(errno), errno);
> +                       return -1;
> +               }

Add an empty line here.

> +               /* Set_report request with
> +                * report id: 0x01, report type: feature (0x03)
> +                * on interface 0
> +                */
> +               err = control_message(fd,
> +                                     USB_ENDPOINT_OUT | USB_TYPE_CLASS |
> +                                     USB_RECIP_INTERFACE,
> +                                     USB_REQ_SET_CONFIGURATION,
> +                                     0x01 | (0x03 << 8),
> +                                     0, report, sizeof(report), 5000);
> +               /* unable to detect whether the previous state
> +                * already was HCI (EALREADY)
> +                */
> +               break;
> +       case HID:
> +               /* currently unknown how to switch to HID */
> +               fprintf(stderr,
> +                       "csr2: Switching to hid mode is not implemented\n");
> +               return -1;
> +               break;

Instead of "return -1; break;"  you can do:

err = -1;
break;

> +       }

Add an empty line here to separate the "return err" from the rest of the code.

> +       return err;
> +}
> +
>  static int hid_logitech_send_report(int fd, const char *buf, size_t size)
>  {
>         struct hiddev_report_info rinfo;

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
