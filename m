Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <418E4E9C.8070100@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP socket?
References: <418DB442.2050801@uen.org> <1099830449.6896.14.camel@pegasus>
In-Reply-To: <1099830449.6896.14.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sun, 07 Nov 2004 09:34:36 -0700

Marcel,

What I wanted to do was start by using the reference SBC codec or just 
one of the reference streams (cleverly hidden in the *zipfile* 
A2DP_TS.pdf at bluetooth.org) and then experiment with sending it to the 
headset.

I'm looking at the diagram on p. 17 of the A2DP spec... it looks like 
the AVDTP layer takes the encoded stream, breaks it up and puts the 
media packet headers on it. Is that right?

I am a little confused about this though... does this show the A2DP sink 
as using the rfcomm protocol?

$ sdptool search --bdaddr 00:08:F4:30:05:BB 0x1101
Class 0x1101
Searching for 0x1101 on 00:08:F4:30:05:BB ...
Service Name: Audio Sink
Service RecHandle: 0x10005
Service Class ID List:
   "Serial Port" (0x1101)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 1

Brad

Marcel Holtmann wrote:
> Hi Brad,
> 
> 
>>Is AVDTP complete enough to pass data around? When I try to create a socket
>>
>>socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_AVDTP)
>>
>>perror gave me "Protocol not supported." Is this the right way to get an 
>>AVDTP socket?
> 
> 
> there is no AVDTP in the kernel. The only thing I did, was to reserve a
> protocol number for it when it was clear to me that this code should run
> inside the kernel.
> 
> However what we really need first is an open source implementation of
> the SBC codec. I am not an audio expert and so I am a little bit lost
> here.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
