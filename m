Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4191AB4B.8060701@xmission.com>
References: <418DB442.2050801@uen.org> <1099830449.6896.14.camel@pegasus>
	 <418E4E9C.8070100@xmission.com> <1099846462.6896.26.camel@pegasus>
	 <418E6FBF.3090409@xmission.com> <1099863224.6896.57.camel@pegasus>
	 <4191AB4B.8060701@xmission.com>
Content-Type: text/plain
Message-Id: <1100076431.25879.49.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 10 Nov 2004 09:47:10 +0100

Hi Brad,

> > I think you should start with a simple test implementation in user space
> > that fulfils your purpose. I haven't understand the AVDTP enough to move
> > any part of it into the kernel at the moment.
> 
> The avdtp document is almost 150 pages long and very terse! It looks to 
> me like I start with sdp to find the avdtp psm, open it with raw l2cap, 
> then do stream endpoint discovery and get capabilities, set stream 
> config, open the l2cap stream psm and send the stream. I am planning to 
> write an app that sends one of the reference sbc streams.

no need to search for the PSM via a SDP request. It is always PSM 25, so
you can simply skip this like we do for RFCOMM. Open it with a raw L2CAP
socket is wrong, because this gives you only access to the L2CAP signal
channel. Simply open it with SOCK_SEQPACKET and send the AVDTP commands
on it. Before you start streaming you must open another L2CAP channel on
PSM 25. There are no different PSMs like for HID or HCRP. It took me
some time to understand this and actually at that time I never realized
that this is even possible, but we already support it ;)

> What should the sdp search look like? The more promising sdptool options 
> I found didn't work flawlessly... I'm assuming 0x110d is A2DP and 0x19 
> is AVDTP (http://www.bluetooth.org/assigned-numbers.htm redirects to 
> http://www.bluetoothsig.org/assigned-numbers/ which won't resolve). What 
> is the uint16 under AVDTP trying to tell us?

The CVS version of sdptool should be able to decode everything A2DP and
AVDTP related. I think the uint16 for AVDTP shouldn't be there. It is a
bug as far as I know. However you don't need this, because it is always
PSM 25 and my sender device simply only looks if a A2DP sink is present
or not.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
