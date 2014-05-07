Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCH BlueZ 1/5] plugins/sixaxis: simplify get_js_numbers()
Date: Wed, 07 May 2014 21:57:49 +0200
Message-ID: <1503255.GchojqlcyW@athlon>
In-Reply-To: <1399370776-5027-2-git-send-email-ao2@ao2.it>
References: <1399370776-5027-1-git-send-email-ao2@ao2.it> <1399370776-5027-2-git-send-email-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Tuesday 06 May 2014 12:06:12 Antonio Ospite wrote:

Just a nitpick :) we usually start commit summary with capital letter eg.
"plugins/sixaxis: Simplify get_js_numbers function"

Same goes to rest of commits in this series.

> Use udev_enumerate_add_match_parent() to simplify get_js_number() a lot,
> with this mechanism the old JOIN-like operation to find joystick nodes
> is no longer necessary.
> 
> Also require libudev >= 172, this is where
> udev_enumerate_add_match_parent() has been first introduced.

This should be fine, any distro shipping BlueZ 5 is most likely already 
providing newer version of udev anyway.

> 
> NOTE: using udev_enumerate_add_match_parent() results in a memory leak
> when enumerating child devices, this has been fixed in udev 207; the
> commit which fixes the issue is this one:
> http://cgit.freedesktop.org/systemd/systemd/commit/?id=51cc07576e119dea6e654
> 78eeba9472979fd0936 ---
>  configure.ac      |  4 +--
>  plugins/sixaxis.c | 92
> +++++++++++++++++++++++++++---------------------------- 2 files changed, 47
> insertions(+), 49 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 54a387f..4208ad8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -125,8 +125,8 @@ AM_CONDITIONAL(MONITOR, test "${enable_monitor}" !=
> "no") AC_ARG_ENABLE(udev, AC_HELP_STRING([--disable-udev],
>  		[disable udev device support]), [enable_udev=${enableval}])
>  if (test "${enable_tools}" != "no" && test "${enable_udev}" != "no"); then
> -	PKG_CHECK_MODULES(UDEV, libudev >= 143, dummy=yes,
> -				AC_MSG_ERROR(libudev >= 143 is required))
> +	PKG_CHECK_MODULES(UDEV, libudev >= 172, dummy=yes,
> +				AC_MSG_ERROR(libudev >= 172 is required))
>  	AC_SUBST(UDEV_CFLAGS)
>  	AC_SUBST(UDEV_LIBS)
>  	AC_CHECK_LIB(udev, udev_hwdb_new,
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index 8045448..9db14ec 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -235,62 +235,60 @@ static bool setup_device(int fd, int index, struct
> btd_adapter *adapter)
> 
>  static int get_js_number(struct udev_device *udevice)
>  {
> -	struct udev_list_entry *devices, *dev_list_entry;
> +	struct udev_list_entry *dev_list_entry;
>  	struct udev_enumerate *enumerate;
>  	struct udev_device *hid_parent;
> -	const char *hidraw_node;
> -	const char *hid_phys;
> +	struct udev_device *transport_parent;
> +	struct udev_device *js_dev;
> +	const char *js_devname;
>  	int number = 0;
> 
> -	hid_parent = udev_device_get_parent_with_subsystem_devtype(udevice,
> -								"hid", NULL);
> -
> -	hid_phys = udev_device_get_property_value(hid_parent, "HID_PHYS");
> -	hidraw_node = udev_device_get_devnode(udevice);
> -	if (!hid_phys || !hidraw_node)
> -		return 0;
> +	/*
> +	 * Go up by two levels from the hidraw device in order to support
> +	 * older kernels, where the hierachy of HID devices is different than
> +	 * newer kernels:
> +	 *
> +	 *   - on kernels < 3.14 the input device is child of the transport
> +	 *     device (usbhid, hidp):
> +	 *
> +	 *       USB/BT
> +	 *       |- hid
> +	 *       |  `- hidraw *
> +	 *       `- input
> +	 *          `- js
> +	 *
> +	 *   - on kernels >= 3.14 the input device is child of the hid device
> +	 *     itself, as it should be:
> +	 *
> +	 *       USB/BT
> +	 *       `- hid
> +	 *          |- hidraw *
> +	 *          `- input
> +	 *             `- js
> +	 */
> +	hid_parent = udev_device_get_parent(udevice);
> +	transport_parent = udev_device_get_parent(hid_parent);
> 
>  	enumerate = udev_enumerate_new(udev_device_get_udev(udevice));
> +	udev_enumerate_add_match_parent(enumerate, transport_parent);
>  	udev_enumerate_add_match_sysname(enumerate, "js*");
>  	udev_enumerate_scan_devices(enumerate);
> -	devices = udev_enumerate_get_list_entry(enumerate);
> -
> -	udev_list_entry_foreach(dev_list_entry, devices) {
> -		struct udev_device *input_parent;
> -		struct udev_device *js_dev;
> -		const char *input_phys;
> -		const char *devname;
> -
> -		devname = udev_list_entry_get_name(dev_list_entry);
> -		js_dev = udev_device_new_from_syspath(
> -						udev_device_get_udev(udevice),
> -						devname);
> -
> -		input_parent = udev_device_get_parent_with_subsystem_devtype(
> -							js_dev, "input", NULL);
> -		if (!input_parent)
> -			goto next;
> -
> -		/* check if this is the joystick relative to the hidraw device
> -		 * above */
> -		input_phys = udev_device_get_sysattr_value(input_parent,
> -									"phys");
> -		if (!input_phys)
> -			goto next;
> -
> -		if (!strcmp(input_phys, hid_phys)) {
> -			number = atoi(udev_device_get_sysnum(js_dev));
> -
> -			/* joystick numbers start from 0, leds from 1 */
> -			number++;
> -
> -			udev_device_unref(js_dev);
> -			break;
> -		}
> -next:
> -		udev_device_unref(js_dev);
> -	}
> 
> +	/* get the first js* device, there should be only one anyway */
> +	dev_list_entry = udev_enumerate_get_list_entry(enumerate);
> +
> +	if (dev_list_entry == NULL)

if (!dev_list_entry) ...

> +		return number;
> +
> +	js_devname = udev_list_entry_get_name(dev_list_entry);
> +	js_dev = udev_device_new_from_syspath(
> +					udev_device_get_udev(udevice),
> +					js_devname);

Indentation issue here.

> +
> +	/* joystick numbers start from 0, leds from 1 */
> +	number = atoi(udev_device_get_sysnum(js_dev)) + 1;
> +
> +	udev_device_unref(js_dev);
>  	udev_enumerate_unref(enumerate);
> 
>  	return number;

-- 
Szymon K. Janc
szymon.janc@gmail.com
