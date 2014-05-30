Return-Path: <cyrus@holtmann.org>
Message-ID: <5388B252.8070709@gmail.com>
Date: Fri, 30 May 2014 12:31:14 -0400
From: Frank Praznik <frank.praznik@gmail.com>
MIME-Version: 1.0
To: Antonio Ospite <ao2@ao2.it>, linux-bluetooth@vger.kernel.org
CC: Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCH BlueZ] plugins/sixaxis: Fix get_js_number() for devices
 connected via BT
References: <1401270620-27080-1-git-send-email-ao2@ao2.it>
In-Reply-To: <1401270620-27080-1-git-send-email-ao2@ao2.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 5/28/2014 05:50, Antonio Ospite wrote:
> Match hid devices and input devices using HID_UNIQ and UNIQ when these
> are available, this is the correct way to get matching devices when the
> controllers are connected via BT (UNIQ refers to the device bdaddr, PHYS
> is the adapter bdaddr, so matching against PHYS will result in all
> devices with the same LED number).
>
> Fall back to HID_PHYS and PHYS when needed, hid devices do not define
> HID_UNIQ when connected via USB.
> ---
>
> Hi,
>
> this is a possible fix for assigning the correct LED numbers via BT.
>
> Frank, can you take a look?
>
> I thought about using the information about the bus explicitly but it was
> slightly more work; considering that I still intend to look into simplifying
> get_js_number() and solving the race we have the first time the joydev module
> is loaded the changes proposed in this patch seemed a viable temporary fix.
>
> Successfully tested on kernel 3.13 and 3.15-rc4: the js number is retrieved
> correctly for the second controller (even though hidraw over BT was broken in
> 3.13 so setting the actual LED failed there).
>
> Thanks,
>     Antonio
>
>   plugins/sixaxis.c | 33 +++++++++++++++++++++++++--------
>   1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index de878d1..b802a9c 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -302,15 +302,24 @@ static int get_js_number(struct udev_device *udevice)
>   	struct udev_enumerate *enumerate;
>   	struct udev_device *hid_parent;
>   	const char *hidraw_node;
> -	const char *hid_phys;
> +	const char *hid_id;
>   	int number = 0;
>   
>   	hid_parent = udev_device_get_parent_with_subsystem_devtype(udevice,
>   								"hid", NULL);
>   
> -	hid_phys = udev_device_get_property_value(hid_parent, "HID_PHYS");
> +	/*
> +	 * Look for HID_UNIQ first for the correct behavior via BT, if
> +	 * HID_UNIQ is not available it means the USB bus is being used and we
> +	 * can rely on HID_PHYS.
> +	 */
> +	hid_id = udev_device_get_property_value(hid_parent, "HID_UNIQ");
> +	if (!hid_id)
> +		hid_id = udev_device_get_property_value(hid_parent,
> +							"HID_PHYS");
> +
>   	hidraw_node = udev_device_get_devnode(udevice);
> -	if (!hid_phys || !hidraw_node)
> +	if (!hid_id || !hidraw_node)
>   		return 0;
>   
>   	enumerate = udev_enumerate_new(udev_device_get_udev(udevice));
> @@ -321,7 +330,7 @@ static int get_js_number(struct udev_device *udevice)
>   	udev_list_entry_foreach(dev_list_entry, devices) {
>   		struct udev_device *input_parent;
>   		struct udev_device *js_dev;
> -		const char *input_phys;
> +		const char *input_id;
>   		const char *devname;
>   
>   		devname = udev_list_entry_get_name(dev_list_entry);
> @@ -336,12 +345,20 @@ static int get_js_number(struct udev_device *udevice)
>   
>   		/* check if this is the joystick relative to the hidraw device
>   		 * above */
> -		input_phys = udev_device_get_sysattr_value(input_parent,
> -									"phys");
> -		if (!input_phys)
> +		input_id = udev_device_get_sysattr_value(input_parent, "uniq");
> +
> +		/*
> +		 * A strlen() check is needed because input device over USB
> +		 * have the UNIQ attribute defined but with an empty value.
> +		 */
> +		if (!input_id || strlen(input_id) == 0)
> +			input_id = udev_device_get_sysattr_value(input_parent,
> +								 "phys");
> +
> +		if (!input_id)
>   			goto next;
>   
> -		if (!strcmp(input_phys, hid_phys)) {
> +		if (!strcmp(input_id, hid_id)) {
>   			number = atoi(udev_device_get_sysnum(js_dev));
>   
>   			/* joystick numbers start from 0, leds from 1 */

I tested this against the latest hid-sony module code (queued for 3.16) 
with a mix of USB and Bluetooth controllers and it seemed to work just fine.

Tested-by: Frank Praznik <frank.praznik@oh.rr.com>

