Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332887487-13601-9-git-send-email-jprvita@openbossa.org>
References: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
	<1332887487-13601-9-git-send-email-jprvita@openbossa.org>
Date: Wed, 28 Mar 2012 10:41:22 +0200
Message-ID: <CANq1E4S4bftzTH3u+NR0k2CUVnayPTz0zo0zHG7gCVkKx=fQ7A@mail.gmail.com>
Subject: Re: [RFC 8/8] HoG: HID I/O driver
From: David Herrmann <dh.herrmann@googlemail.com>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, chen.ganir@ti.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao

On Wed, Mar 28, 2012 at 12:31 AM, João Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> UHID is HID I/O driver that makes possible to implement HID I/O drivers in
> user-space. It works similar to the uinput but it is initialized with a HID
> descriptor and deals with raw HID reports.
>
> This commit uses UHID to create a HID device for the remote HoG device and
> to tranfers HID reports to HID subsystem.
> ---
>  input/hog_device.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 51 insertions(+), 0 deletions(-)
>
> diff --git a/input/hog_device.c b/input/hog_device.c
> index 7a757f4..183da22 100644
> --- a/input/hog_device.c
> +++ b/input/hog_device.c
> @@ -29,6 +29,10 @@
>  #include <stdlib.h>
>  #include <errno.h>
>  #include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <linux/uhid.h>
>
>  #include <bluetooth/bluetooth.h>
>  #include <bluetooth/uuid.h>
> @@ -48,6 +52,7 @@
>  #include "gatt.h"
>
>  #define HOG_REPORT_UUID                0x2A4D
> +#define UHID_DEVICE_FILE       "/dev/uhid"
>
>  struct hog_device {
>        char                    *path;
> @@ -56,13 +61,17 @@ struct hog_device {
>        guint                   attioid;
>        struct gatt_primary     *hog_primary;
>        struct gatt_char        *report;
> +       int                     uhid_fd;
>  };
>
>  static GSList *devices = NULL;
>
>  static void report_value_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
>  {
> +       struct hog_device *hogdev = user_data;
> +       struct uhid_event ev;
>        uint16_t handle;
> +       uint16_t report_size = len - 2;
>
>        if (len < 3) {
>                error("Malformed ATT notification");
> @@ -74,6 +83,14 @@ static void report_value_cb(const uint8_t *pdu, uint16_t len, gpointer user_data
>        DBG("Report(0x%04x): 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x "
>                                "0x%02x", handle, pdu[2], pdu[3], pdu[4],
>                                pdu[5], pdu[6], pdu[7], pdu[8], pdu[9]);
> +
> +       memset(&ev, 0, sizeof(ev));
> +       ev.type = UHID_INPUT;
> +       ev.u.input.size = report_size;
> +       memcpy(ev.u.input.data, &pdu[2], report_size);

Please use min(report_size, UHID_DATA_MAX) here.

> +
> +       if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
> +               error("UHID write failed: %s", strerror(errno));
>  }
>
>  static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
> @@ -96,6 +113,8 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
>  static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>                                                        gpointer user_data)
>  {
> +       struct hog_device *hogdev = user_data;
> +       struct uhid_event ev;
>        uint8_t value[ATT_MAX_MTU];
>        int vlen, i;
>
> @@ -116,6 +135,22 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>                else
>                        DBG("\t %02x %02x", value[i], value[i + 1]);
>        }
> +
> +       /* create UHID device */
> +       memset(&ev, 0, sizeof(ev));
> +       ev.type = UHID_CREATE;
> +       /* TODO: get info from DIS */
> +       strcpy((char*)ev.u.create.name, "bluez-hog-device");
> +       ev.u.create.vendor = 0xBEBA;
> +       ev.u.create.product = 0xCAFE;
> +       ev.u.create.version = 0;
> +       ev.u.create.country = 0;
> +       ev.u.create.bus = BUS_USB; /* BUS_BLUETOOTH doesn't work here */

I've seen the other mail. I will have a look at this. It's probably
because generic-bluetooth doesn't get loaded for uhid devices but only
generic-usb.

> +       ev.u.create.rd_data = value;
> +       ev.u.create.rd_size = vlen;
> +
> +       if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
> +               error("Failed to create UHID device: %s", strerror(errno));
>  }
>
>  static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
> @@ -162,11 +197,27 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
>
>        gatt_discover_char(hogdev->attrib, prim->range.start, prim->range.end,
>                                        NULL, char_discovered_cb, hogdev);
> +
> +       if (hogdev->uhid_fd > 0)
> +               return;
> +
> +       hogdev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR, 0666);

You probably want O_RDWR | O_CLOEXEC here. And please remove the third
parameter 0666. It doesn't make sense if you do not use O_CREATE.

> +       if (hogdev->uhid_fd < 0)
> +               error("Failed to open UHID device: %s", strerror(errno));

I don't know what side-effects the "error()" call has, but I think we
need better cleanup at all the error() calls in this file. But I
haven't checked it thoroughly, yet.

Also this is a good place to add uhid_fd to the event-loop and wait
for READABLE events. The callback should then simply read from uhid_fd
and write the raw data prefix with the att header. There is no need to
validate the data you read from uhid_fd.

>  }
>
>  static void attio_disconnected_cb(gpointer user_data)
>  {
>        struct hog_device *hogdev = user_data;
> +       struct uhid_event ev;
> +
> +       memset(&ev, 0, sizeof(ev));
> +       ev.type = UHID_DESTROY;
> +       if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
> +               error("Failed to destroy UHID device: %s", strerror(errno));
> +
> +       close(hogdev->uhid_fd);
> +       hogdev->uhid_fd = -1;
>
>        g_attrib_unref(hogdev->attrib);
>        hogdev->attrib = NULL;
> --
> 1.7.7.6
>

Looks good overall, regards
David
