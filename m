Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: James <theholyettlz@gmail.com>, Al Cho <acho@suse.com>
Subject: Re: Bluetooth dongle (13d3:3304) not responding after reboot until suspend/resume
Date: Fri, 22 Jun 2012 08:26:36 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <1340312488.2203.16.camel@iseult>
In-Reply-To: <1340312488.2203.16.camel@iseult>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201206220826.36147.oneukum@suse.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Donnerstag, 21. Juni 2012, 23:01:28 schrieb James:
> Hi,
> 
> I'm seeing a strange issue with a USB-attached internal Bluetooth dongle
> (I believe it's on a dual mini PCI-Express/USB card).
> 
> Normally, if I start the machine from cold straight into Linux,
> everything works fine. The dongle at first shows up as an "IMC Networks"
> dongle (13d3:3304) until ath3k loads, then it re-identifies itself as an
> "Atheros Communications, Inc." device (0cf3:3005) and works.
> 
> However, if I cold-start to Windows 7 first, then reboot into Linux,
> frequently the device will get stuck as 13d3:3304 and stop responding.
> Attempting to reload ath3k results in a short pause before a message like
> 
> [  131.835217] Bluetooth: Can't change to loading configuration err
> [  131.835315] ath3k: probe of 1-1.2:1.0 failed with error -110

static int ath3k_load_fwfile(struct usb_device *udev,
                const struct firmware *firmware)
{
        u8 *send_buf;
        int err, pipe, len, size, count, sent = 0;
        int ret;

        count = firmware->size;

        send_buf = kmalloc(BULK_SIZE, GFP_KERNEL);
        if (!send_buf) {
                BT_ERR("Can't allocate memory chunk for firmware");
                return -ENOMEM;
        }

        size = min_t(uint, count, FW_HDR_SIZE);
        memcpy(send_buf, firmware->data, size);

        pipe = usb_sndctrlpipe(udev, 0);
        ret = usb_control_msg(udev, pipe, ATH3K_DNLOAD,
                        USB_TYPE_VENDOR, 0, 0, send_buf,
                        size, USB_CTRL_SET_TIMEOUT);
        if (ret < 0) {
                BT_ERR("Can't change to loading configuration err");
                kfree(send_buf);
                return ret;
        }

ath3k has determined that your device needs additional firmware but cannot
switch to firmware download mode.

> If I then suspend/resume the notebook, and then reload ath3k, generally
> it works. The dongle flips its USB ID, and normal service ensues.

This cuts power to the module and it reverts to its default state like after
a cold boot.
 
> Any ideas what's going on here? 

Basically the device is semi-reset and ath3k cannot deal with a device
in that state. But that doesn't tell us what can be done. Please post "lsusb -v"
of your device _before_ ath3k is loaded (you should disable ath3k and btusb
for that test) in both states, after cold boot and warm reboot from Windows.

	Regards
		Oliver
