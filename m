Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4362369C.2050608@felton.felton.ca.us>
From: Robert Lewis <rll@felton.felton.ca.us>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BT-alsa with HT820(MOTO)
References: <4CA6E08AA4616B4FB0BAC7A889A3E9F0045EE90C@pdsmsx404>
In-Reply-To: <4CA6E08AA4616B4FB0BAC7A889A3E9F0045EE90C@pdsmsx404>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 28 Oct 2005 07:33:00 -0700

Dion,

Here is someone at Intel working on Bluetooth and having problems.
This looks like an audio headset issue.

Cheers,
Bob

Wu, Jieke wrote:

> Hi: all
>
>        I have enabled the link with HT820 on my 2.6.9 kernel (PC), 
> also I can send the data with ACL to MOTO headset, below is something 
> hcidump catched. But still no any audio output can be listened on 
> headset part. Any one can deliver some hint? Thanks.
>
>  
>
>  
>
>> ACL data: handle 47 flags 0x02 dlen 8
>
>     L2CAP(d): cid 0x0041 len 4 [psm 25]
>
>       AVDTP(s): Discover rsp: transaction 0
>
>         ACP SEID 1 - Audio Sink
>
> < ACL data: handle 47 flags 0x02 dlen 7
>
>     L2CAP(d): cid 0x0051 len 3 [psm 25]
>
>       AVDTP(s): Capabilities cmd: transaction 1
>
>         ACP SEID 1
>
>> HCI Event: Number of Completed Packets (0x13) plen 5
>
>> ACL data: handle 47 flags 0x02 dlen 16
>
>     L2CAP(d): cid 0x0041 len 12 [psm 25]
>
>       AVDTP(s): Capabilities rsp: transaction 1
>
>         Media Transport
>
>         Media Codec - SBC
>
>           16kHz 32kHz 44.1kHz 48kHz
>
>           Mono DualChannel Stereo JointStereo
>
>           4 8 12 16 Blocks
>
>           4 8 Subbands
>
>           SNR Loudness
>
>           Bitpool Range 2-250
>
> < ACL data: handle 47 flags 0x02 dlen 18
>
>     L2CAP(d): cid 0x0051 len 14 [psm 25]
>
>       AVDTP(s): Set config cmd: transaction 2
>
>         ACP SEID 1 - INT SEID 1
>
>         Media Transport
>
>         Media Codec - SBC
>
>           44.1kHz
>
>           Stereo
>
>           16 Blocks
>
>           8 Subbands
>
>           SNR
>
>           Bitpool Range 2-250
>
> < ACL data: handle 47 flags 0x02 dlen 192
>
> < ACL data: handle 47 flags 0x01 dlen 192
>
> < ACL data: handle 47 flags 0x01 dlen 192
>
> < ACL data: handle 47 flags 0x01 dlen 49
>
>     L2CAP(d): cid 0x0052 len 621 [psm 25]
>
>       AVDTP(m): ver 2 cc 0 pt 1 seqn 2 time 128 ssrc 1
>
>> HCI Event: Number of Completed Packets (0x13) plen 5
>
> < ACL data: handle 47 flags 0x02 dlen 192
>
>> HCI Event: Number of Completed Packets (0x13) plen 5
>
> < ACL data: handle 47 flags 0x01 dlen 192
>
> < ACL data: handle 47 flags 0x01 dlen 192
>
> < ACL data: handle 47 flags 0x01 dlen 49
>
>     L2CAP(d): cid 0x0052 len 621 [psm 25]
>
>       AVDTP(m): ver 2 cc 0 pt 1 seqn 3 time 256 ssrc 1
>
>> HCI Event: Number of Completed Packets
>


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
