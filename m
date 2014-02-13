Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2014 16:29:00 -0800
Message-ID: <CAGXr9JGYwGREq0_090L3DT1D7OsWXNRCRXU8KTz30t-_my5Phw@mail.gmail.com>
Subject: Re: [PATCHv3] hog: Use HoG device name as uHID input device name
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Any comments on this patch?

In uHID kernel driver, uhid_dev_create() does:
  ...
  strncpy(hid->name, ev->u.create.name, 127);
  hid->name[127] = 0;
  strncpy(hid->phys, ev->u.create.phys, 63);
  hid->phys[63] = 0;
  strncpy(hid->uniq, ev->u.create.uniq, 63);
  hid->uniq[63] = 0;

Also, BlueZ already does this with HID input devices.
input_device_new() copies Bluetooth device name into idev->name. And
then, hidp_add_connection() copies idev->name to req->name and passes
it to kernel. In kernel, hidp_setup_hid() populates hid->name,
hid->phys, and hid->uniq.

On Wed, Jan 29, 2014 at 7:55 PM, Petri Gynther <pgynther@google.com> wrote:
> If HoG BLE device name is known, use it when creating uHID input device.
> Pass adapter and device addresses to uHID as well.
> ---
>  profiles/input/hog.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index ded6303..030dc91 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -392,7 +392,15 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>         /* create uHID device */
>         memset(&ev, 0, sizeof(ev));
>         ev.type = UHID_CREATE;
> -       strcpy((char *) ev.u.create.name, "bluez-hog-device");
> +       if (device_name_known(hogdev->device)) {
> +               device_get_name(hogdev->device, (char *) ev.u.create.name,
> +                               sizeof(ev.u.create.name) - 1);
> +       } else {
> +               strcpy((char *) ev.u.create.name, "bluez-hog-device");
> +       }
> +       ba2str(btd_adapter_get_address(device_get_adapter(hogdev->device)),
> +               (char *) ev.u.create.phys);
> +       ba2str(device_get_address(hogdev->device), (char *) ev.u.create.uniq);
>         ev.u.create.vendor = vendor;
>         ev.u.create.product = product;
>         ev.u.create.version = version;
> --
> 1.8.5.3
>
