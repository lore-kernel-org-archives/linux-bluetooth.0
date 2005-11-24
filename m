Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Everything seems normal yet...
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43835FAE.4080505@csr.com>
References: <200511211803.35723.arthur.breitman@gmail.com>
	 <200511221106.42566.arthur.breitman@gmail.com>
	 <1132675914.20713.18.camel@blade>  <43835FAE.4080505@csr.com>
Content-Type: text/plain
Message-Id: <1132806616.5982.30.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 24 Nov 2005 05:30:16 +0100

Hi Steven,

> >> > HCI Event: Vendor (0xff) plen 7
> >>   0000: cd 03 00 04 00 00 00                              .......
> > 
> > since this is a CSR chip, use "-m 10" as additional parameter to hcidump
> > to enable the decoding of CSR vendor events.
> 
> That won't really help in this case. All it'll tell you is that it's the
> 1 byte message 00 on subchannel 4 coming from a VM application running
> on the chip.
> 
> Subchannels below 0x0080 are free for use by the VM application. So,
> without visibility of the VM application, it's difficult to know
> exactly what this message signifies.
> 
> VM applications on dongles in HCI mode are fairly limited. They can
> detect Bluetooth activity, process messages from and send messages to
> the host, enable and disable the radio, reboot in another mode and a
> few other bits and pieces.
> 
> So, it may simply be an indication from the dongle to the host that
> there's been some Bluetooth activity. The host might use this to flash
> a light or similar.

this is unusual. I never saw any dongle transmitting continuously vendor
events. There must be something wrong with this device.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
