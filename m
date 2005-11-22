Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Authentication failure
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <7.0.0.10.0.20051121130729.0122d150@impulsesoft.com>
References: <7.0.0.10.0.20051121130729.0122d150@impulsesoft.com>
Content-Type: text/plain
Message-Id: <1132657624.28644.5.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 22 Nov 2005 12:07:04 +0100

Hi Pragya,

> I have enabled authentication on BlueZ and I try to issue connection 
> from another bluetooth device. I am seeing random behaviour with 
> respect to authentication. Sometimes the authentication procedure 
> goes through and a file "link_key" is created in /etc/bluetooth/.
> 
> But most of the times, I see a link key request and no response from BlueZ.
> I am attaching the hcid.conf being used by me and also some logs (see 
> below) collected using hcidump.

when using hcidump then use it with -X -V and as root. Nobody wants to
decode the HCI commands and events by themself.

If the link key requests are not answered, I suspect that hcid is not
running. If it runs make sure only one instance is running.

At some point we moved the link key storage to /var/lib/bluetooth and it
is also a text file now.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
