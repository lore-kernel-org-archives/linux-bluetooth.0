Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] modify RFCOMM_DISC_TIMEOUT
From: Marcel Holtmann <marcel@holtmann.org>
To: Carlos AM <Carlos@naxus.biz>
Cc: lista bluez <bluez-devel@lists.sourceforge.net>
In-Reply-To: <004501c4749c$9958f280$5000005a@naxus>
References: <004501c4749c$9958f280$5000005a@naxus>
Content-Type: text/plain
Message-Id: <1091017360.3673.26.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 28 Jul 2004 14:22:40 +0200

Hi Carlos,

> I think that i've finally found the origin of the errors. The kernel
> log
> shows:
> 
> (...)
> <4> Unknown HCI packet type 01
> (...)
> 
> 
> This message is dropped every five minutes (aproximately) and the
> packet
> type is not always 01. It seems that the serial communication (UART)
> with
> the bluetooth module (EYMF2CAMM from TAIYO YUDEN) isn't very
> confiable. Do
> you agree?

out of sync H4 streams are really a big problem. This can happen if you
can't enable automatic flow control. To avoid this you have to use BCSP
if it is a CSR based chip.

> Then I configured the kernel with BCSP support and tried to attach the
> device using:
> /bluez/bluezmain hciattach -n /dev/tts/2 bcsp 115200
> /bluez/bluezmain hciattach -n /dev/tts/2 swave 115200
> 
> but none of them work at all. The error message is [hcid] Can't init
> device
> hci0. Connection timed out(110)

The swave will only work if your chip is Silicon Wave based and the BCSP
method only works if you switch from H4 to BCSP first with the correct
PS key settings. Contact your module manufacturer.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
