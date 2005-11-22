Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43835FAE.4080505@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Everything seems normal yet...
References: <200511211803.35723.arthur.breitman@gmail.com>	 <200511221106.42566.arthur.breitman@gmail.com> <1132675914.20713.18.camel@blade>
In-Reply-To: <1132675914.20713.18.camel@blade>
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 22 Nov 2005 18:13:02 +0000

Marcel Holtmann wrote:
> Arthur Breitman wrote:
>> > HCI Event: Vendor (0xff) plen 7
>>   0000: cd 03 00 04 00 00 00                              .......
> 
> since this is a CSR chip, use "-m 10" as additional parameter to hcidump
> to enable the decoding of CSR vendor events.

That won't really help in this case. All it'll tell you is that it's the
1 byte message 00 on subchannel 4 coming from a VM application running
on the chip.

Subchannels below 0x0080 are free for use by the VM application. So,
without visibility of the VM application, it's difficult to know
exactly what this message signifies.

VM applications on dongles in HCI mode are fairly limited. They can
detect Bluetooth activity, process messages from and send messages to
the host, enable and disable the radio, reboot in another mode and a
few other bits and pieces.

So, it may simply be an indication from the dongle to the host that
there's been some Bluetooth activity. The host might use this to flash
a light or similar.

	- Steven
-- 


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
