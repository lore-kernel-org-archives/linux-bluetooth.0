Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Link Quality between 2 Bluetooth USB Dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <94e407f00510242335r6312f167w909fdbff18069ef8@mail.gmail.com>
References: <94e407f00510240734x12c64714qc791a991ddcd1426@mail.gmail.com>
	 <1130164983.19317.54.camel@blade>
	 <94e407f00510240944k24a3f4f1re75377a1bffb8a7@mail.gmail.com>
	 <1130174344.7840.2.camel@blade>
	 <94e407f00510242335r6312f167w909fdbff18069ef8@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130230152.7840.42.camel@blade>
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
Date: Tue, 25 Oct 2005 10:49:12 +0200

Hi Arpit,

> these chips are Broadcom based. So you must ask them how they
> implemented the link quality value.
> 
> How is the implementation vendor specific?Does it mean that some
> vendors don't support Link Quality?Or does it mean that there are
> other ways of getting the LQ value?

the link quality value is vendor specific. Every manufacturer can
implement it as they like. Read the specification for details.
 
> Check "hciconfig hci0 features" if they support "Inquiry with RSSI".
> [root@175-214 ~]# hciconfig hci0 features
> hci0:   Type: USB
>         BD Address: 00:10:60:B3:2C:F7 ACL MTU: 377:10 SCO MTU: 16:0 
>         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot
> offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff
> mode> 
>                 <RSSI> <channel quality> <SCO link> <HV2 packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <power
> control>
>                 <transparent SCO> <enhanced iscan> <interlaced iscan> 
>                 <interlaced pscan> <AFH cap. slave> <AFH cap. master>
>  
> Well looks like it does support RSSI...but RSSI values change
> abruptly..for the same distance the RSSI might be -9 and the after ten
> seconds its -2 so I can't use RSSI.

But they don't support "Inquiry with RSSI" which might be more usable.
However ask Broadcom why this is so?

> Do you suggest I try the LQ value with some other bluetooth
> adaptors?Any idea as to which model would support the link quality
> feature?

The link quality is supported by every Bluetooth chip, but what this
value means is up to the manufacturer. Read the specification to
understand what this means.

Get yourself two CSR based dongles and try again.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
