Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4400EF65.40704@cs.bgu.ac.il>
From: Niv <nivv@cs.bgu.ac.il>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] A2DP alsa no sound
References: <43FDE154.7050803@cs.bgu.ac.il> <43FDFC4E.8040104@xmission.com>
In-Reply-To: <43FDFC4E.8040104@xmission.com>
Content-Type: text/plain; charset=UTF-8
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
Date: Sun, 26 Feb 2006 01:59:33 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

here we go:
diff mpg123.piped2headphones.dump.txt pcm.headphones.dump.txt


11c11
<     L2CAP(s): Connect req: psm 1 scid 0x0040
- ---
>     L2CAP(s): Connect req: psm 25 scid 0x0040
25,108c25
<     L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0040 result 1 status 2
<       Connection pending - Authorization pending
< > ACL data: handle 41 flags 0x02 dlen 16
<     L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0040 result 0 status 0
<       Connection successful
< < ACL data: handle 41 flags 0x02 dlen 12
<     L2CAP(s): Config req: dcid 0x0049 flags 0x00 clen 0
< > HCI Event: Number of Completed Packets (0x13) plen 5
<     handle 41 packets 1
< > ACL data: handle 41 flags 0x02 dlen 14
<     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
<       Success
< > ACL data: handle 41 flags 0x02 dlen 16
<     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
<       MTU 48
< < ACL data: handle 41 flags 0x02 dlen 14
<     L2CAP(s): Config rsp: scid 0x0049 flags 0x00 result 0 clen 0
<       Success
< < ACL data: handle 41 flags 0x02 dlen 24
<     L2CAP(d): cid 0x0049 len 20 [psm 1]
<         SDP SSA Req: tid 0x0 len 0xf
<           pat uuid-16 0x110d (AdvAudio)
<           max 65535
<           aid(s) 0x0000 - 0xffff
<           cont 00
< > HCI Event: Number of Completed Packets (0x13) plen 5
<     handle 41 packets 1
< > HCI Event: Number of Completed Packets (0x13) plen 5
<     handle 41 packets 1
< > ACL data: handle 41 flags 0x02 dlen 52
<     L2CAP(d): cid 0x0040 len 48 [psm 1]
<         SDP SSA Rsp: tid 0x0 len 0x2b
<           count 38
<           cont 02 00 18
< < ACL data: handle 41 flags 0x02 dlen 26
<     L2CAP(d): cid 0x0049 len 22 [psm 1]
<         SDP SSA Req: tid 0x1 len 0x11
<           pat uuid-16 0x110d (AdvAudio)
<           max 65535
<           aid(s) 0x0000 - 0xffff
<           cont 02 00 18
< > HCI Event: Number of Completed Packets (0x13) plen 5
<     handle 41 packets 1
< > ACL data: handle 41 flags 0x02 dlen 36
<     L2CAP(d): cid 0x0040 len 32 [psm 1]
<         SDP SSA Rsp: tid 0x1 len 0x1b
<           count 24

<           record #0
<               aid 0x0000 (SrvRecHndl)
<                  uint 0x10000
<               aid 0x0001 (SrvClassIDList)
<                  < uuid-16 0x110b (AudioSink) >
<               aid 0x0004 (ProtocolDescList)
<                  < < uuid-16 0x0100 (L2CAP) uint 0x19 > <
<                  uuid-16 0x0019 (AVDTP) uint 0x100 > >
<               aid 0x0009 (BTProfileDescList)
<                  < < uuid-16 0x110d (AdvAudio) uint 0x100 > >
<               aid 0x0311 (unknown)
<                  uint 0x1
<           cont 00
< < ACL data: handle 41 flags 0x02 dlen 24
<     L2CAP(d): cid 0x0049 len 20 [psm 1]
<         SDP SSA Req: tid 0x2 len 0xf
<           pat uuid-16 0x1200 (PNPInfo)
<           max 65535
<           aid(s) 0x0000 - 0xffff
<           cont 00
< > HCI Event: Number of Completed Packets (0x13) plen 5
<     handle 41 packets 1
< > ACL data: handle 41 flags 0x02 dlen 14
<     L2CAP(d): cid 0x0040 len 10 [psm 1]
<         SDP SSA Rsp: tid 0x2 len 0x5
<           count 2
<           cont 00
< < ACL data: handle 41 flags 0x02 dlen 12
<     L2CAP(s): Disconn req: dcid 0x0049 scid 0x0040
< < ACL data: handle 41 flags 0x02 dlen 12
<     L2CAP(s): Connect req: psm 25 scid 0x0041
< > HCI Event: Number of Completed Packets (0x13) plen 5
<     handle 41 packets 1
< > HCI Event: Number of Completed Packets (0x13) plen 5
<     handle 41 packets 1
< > ACL data: handle 41 flags 0x02 dlen 16
<     L2CAP(s): Connect rsp: dcid 0x004a scid 0x0041 result 1 status 2
- ---
>     L2CAP(s): Connect rsp: dcid 0x004d scid 0x0040 result 1 status 2
110,111d26
< > ACL data: handle 41 flags 0x02 dlen 12
<     L2CAP(s): Disconn rsp: dcid 0x0049 scid 0x0040
120c35
<     L2CAP(s): Connect rsp: dcid 0x004a scid 0x0041 result 0 status 0
- ---
>     L2CAP(s): Connect rsp: dcid 0x004d scid 0x0040 result 0 status 0
123c38
<     L2CAP(s): Config req: dcid 0x004a flags 0x00 clen 0
- ---
>     L2CAP(s): Config req: dcid 0x004d flags 0x00 clen 0
125c40
<     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
- ---
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
128c43
<     L2CAP(s): Config rsp: scid 0x004a flags 0x00 result 0 clen 0
- ---
>     L2CAP(s): Config rsp: scid 0x004d flags 0x00 result 0 clen 0
135c50
<     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
- ---
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
137,138c52,53
< < ACL data: handle 41 flags 0x02 dlen 6
<     L2CAP(d): cid 0x004a len 2 [psm 25]
- ---
> < ACL data: handle 41 flags 0x02 dlen 7
>     L2CAP(d): cid 0x004d len 3 [psm 25]
139a55
>       0000: 00                                                .
143c59
<     L2CAP(d): cid 0x0041 len 4 [psm 25]
- ---
>     L2CAP(d): cid 0x0040 len 4 [psm 25]
147c63
<     L2CAP(d): cid 0x004a len 3 [psm 25]
- ---
>     L2CAP(d): cid 0x004d len 3 [psm 25]
153c69
<     L2CAP(d): cid 0x0041 len 12 [psm 25]
- ---
>     L2CAP(d): cid 0x0040 len 12 [psm 25]
164c80
<     L2CAP(d): cid 0x004a len 14 [psm 25]
- ---
>     L2CAP(d): cid 0x004d len 14 [psm 25]
178c94
<     L2CAP(d): cid 0x0041 len 2 [psm 25]
- ---
>     L2CAP(d): cid 0x0040 len 2 [psm 25]
181c97
<     L2CAP(d): cid 0x004a len 3 [psm 25]
- ---
>     L2CAP(d): cid 0x004d len 3 [psm 25]
187c103
<     L2CAP(d): cid 0x0041 len 2 [psm 25]
- ---
>     L2CAP(d): cid 0x0040 len 2 [psm 25]
190c106
<     L2CAP(s): Connect req: psm 25 scid 0x0040
- ---
>     L2CAP(s): Connect req: psm 25 scid 0x0041
194c110
<     L2CAP(s): Connect rsp: dcid 0x004b scid 0x0040 result 1 status 2
- ---
>     L2CAP(s): Connect rsp: dcid 0x004e scid 0x0041 result 1 status 2
197c113
<     L2CAP(s): Connect rsp: dcid 0x004b scid 0x0040 result 0 status 0
- ---
>     L2CAP(s): Connect rsp: dcid 0x004e scid 0x0041 result 0 status 0
200c116
<     L2CAP(s): Config req: dcid 0x004b flags 0x00 clen 0
- ---
>     L2CAP(s): Config req: dcid 0x004e flags 0x00 clen 0
202c118
<     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
- ---
>     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
205c121
<     L2CAP(s): Config rsp: scid 0x004b flags 0x00 result 0 clen 0
- ---
>     L2CAP(s): Config rsp: scid 0x004e flags 0x00 result 0 clen 0
212c128
<     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
- ---
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
215c131
<     L2CAP(d): cid 0x004a len 3 [psm 25]
- ---
>     L2CAP(d): cid 0x004d len 3 [psm 25]
221c137
<     L2CAP(d): cid 0x0041 len 2 [psm 25]
- ---
>     L2CAP(d): cid 0x0040 len 2 [psm 25]
223,417d138
< < ACL data: handle 41 flags 0x02 dlen 192
< < ACL data: handle 41 flags 0x01 dlen 192
< < ACL data: handle 41 flags 0x01 dlen 192
< < ACL data: handle 41 flags 0x01 dlen 192
< < ACL data: handle 41 flags 0x01 dlen 85
<     L2CAP(d): cid 0x004b len 849 [psm 25]
<       AVDTP(m): ver 2 cc 0 pt 1 seqn 1 time 0 ssrc 1

Brad Midgley wrote:
> Niv
> 
>> I am SO glad you made a alsa plugin for the headphones.
>> I  tried it , I hear that the headphones do pick it up , but no sound
>> goes throu
> 
> The plugin is a work in progress. I got stuck in getting it to do the
> right thing.
> 
> Can you see from the hcidump where the plugin differs from a successful
> stream via a2play?
> 
> Brad
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEAO9kkwazfG0MmCYRAkaFAKCRBRtS/8GKhrApN3oPF553pwIg6gCfWlHg
W8JTcghmy/4ZeppyNj+0KKs=
=w3LV
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
