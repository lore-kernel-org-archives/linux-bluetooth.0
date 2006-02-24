Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43FE9633.5090704@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] DUN fails to do fast data
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
Date: Thu, 23 Feb 2006 22:14:27 -0700

Hi

I have been using dialup networking over bluetooth for some time. The
carrier was providing cdma/1xrtt which runs at about 130kbps. When they
upgraded to ev-do (should deliver at least 200kbps), I found that the
link would drop if I was trying to max out the connection.

Now I've had a chance to test this on two different phones on two
different carriers (samsung i730 on verizon and xv6700 on sprint) and
both show this problem with maxing the connection. Actually, the i730
will drop the connection but the xv6700 is more likely to lock up the
phone. Is something getting out of sync?

/etc/ppp/providers/default:

noauth
connect "/usr/sbin/chat -v -f /etc/chatscripts/verizon"
/dev/rfcomm5
460800
defaultroute
noipdefault
user "801......."
ipparam verizon
usepeerdns
crtscts

Here's a part of the dump when doing a large download. In this case, the
xf6700 locked up solid at the end of the dump.

Any ideas?

    L2CAP(d): cid 0x0040 len 672 [psm 0]
      0000: 21 ef 36 05 8b 24 59 9f  84 38 4c 0c 0e 04 e7 8d
!.6..$Y..8L.....
      0010: 10 b2 0f e1 e7 3c 84 8b  8a 3f 1d 47 68 11 c4 5a
.....<...?.Gh..Z
      0020: 3e 99 10 05 29 b4 91 fd  57 05 cd 65 d1 2a 83 a7
>...)...W..e.*..
      0030: 65 c3 2e ce 85 43 17 23  e8 89 07 93 e4 d1 ca f9
e....C.#........
      0040: 4d 3b ec 34 af 98 98 c6  17 79 7c 59 06 53 f4 92
M;.4.....y|Y.S..
      0050: 25 6d fa ad d7 7c c4 b1  0b e1 dc c3 79 8e fe 13
%m...|......y...
      0060: 05 40 77 cb bf 54 f8 36  13 7b fd b9 17 0e 92 35
.@w..T.6.{.....5
      0070: 32 21 64 44 7c ba 8d 17  bc 43 74 92 e1 5c a9 85
2!dD|....Ct..\..
      0080: 95 35 f9 35 8d d6 5f 34  40 cd 31 cd e7 35 6a 73
.5.5.._4@.1..5js
      0090: 5c f0 88 a3 4f d7 9b d3  9e 67 49 fe b5 18 96 85
\...O....gI.....
      00a0: b3 1a 8f 1b 56 f0 98 5d  21 0d 95 54 d4 ac ed c3
....V..]!..T....
      00b0: 9d fa 5b 48 a2 4c ac c4  22 2c 37 b3 11 1b c4 74
..[H.L..",7....t
      00c0: 8d b5 55 8c 50 bd a0 05  b4 ae fb ef ac 12 94 45
..U.P..........E
      00d0: da 74 18 6d 9a 01 4a 47  49 0d 30 d5 00 14 75 a3
.t.m..JGI.0...u.
      00e0: 9d bb 04 69 d2 f1 96 f2  97 96 27 97 bd fe 52 07
...i......'...R.
      00f0: 11 3a 52 a6 7d 5e 3b 3f  52 f1 f0 f4 f8 ff 7e 7e
.:R.}^;?R.....~~
      0100: 21 45 00 05 dc 27 20 40  00 3a 06 a1 c0 98 02 d2  !E...'
@.:......
      0110: 41 44 1b c3 dc 00 50 11  6f 96 f9 d0 17 b4 73 47
AD....P.o.....sG
      0120: f9 80 10 82 18 0d 33 00  00 01 01 08 0a 24 fb fc
......3......$..
      0130: 9b 25 d1 26 f4 2c 28 8a  97 ad 54 48 13 b6 3b da
.%.&.,(...TH..;.
      0140: 8a 6f 31 d8 94 a2 96 32  9b 2e 34 e6 35 f7 f8 6b
.o1....2..4.5..k
      0150: 59 e0 b6 20 14 70 0c 8d  23 b8 95 10 cf 5d 68 3a  Y..
.p..#....]h:
      0160: 09 78 02 7b 59 c7 22 47  25 ed e6 a0 8c 44 2a b9
.x.{Y."G%....D*.
      0170: ec 7a aa 82 a6 0c eb eb  6f c8 b3 cd e9 35 eb 0a
.z......o....5..
      0180: a1 a0 88 cb 44 dc ca 57  2e 00 93 c7 0c 0f f6 4b
....D..W.......K
      0190: 09 0b 0e 6f 75 43 d3 50  c7 3c 1b 16 1b 3f a4 a6
...ouC.P.<...?..
      01a0: 78 a4 15 94 47 35 ee 7a  24 cd 2d 73 6b 96 7d 5e
x...G5.z$.-sk.}^
      01b0: 5c f8 32 09 9b a5 d6 82  52 7d 5d 89 3e ba 10 0e
\.2.....R}].>...
      01c0: 6a 69 da 00 e0 fe 37 3a  d4 ed 1e 82 27 2f b4 eb
ji....7:....'/..
      01d0: 90 a5 9b e6 f2 cf 91 78  3f 01 35 ea 61 b5 0c 38
.......x?.5.a..8
      01e0: d4 eb 21 c6 2d 45 4f 5a  e6 df 0f 90 5c 19 a1 75
..!.-EOZ....\..u
      01f0: b6 11 63 b5 23 f6 6b 38  97 b6 fa ce 85 8d cb c4
..c.#.k8........
      0200: 52 65 1e 8c d9 96 19 1e  78 f0 b9 d2 61 a6 28 be
Re......x...a.(.
      0210: 2d 9d 26 06 92 f1 c9 e4  c2 fa 2f b8 0f c4 87 bf
-.&......./.....
      0220: ae d3 55 7b 3c 5f 7d 5e  4d 60 78 7c db d4 27 22
..U{<_}^M`x|..'"
      0230: e2 c3 ad ad e1 87 41 10  1c 04 62 20 68 7b e6 6f
......A...b h{.o
      0240: 9e 22 53 a6 f3 0a b3 e9  a9 0c f5 1a 9e 6d 99 88
."S..........m..
      0250: 6d cd 4f 42 af 34 e2 6e  48 e0 13 a1 ae a8 5e ce
m.OB.4.nH.....^.
      0260: b6 09 92 0b a7 ec fa 8c  6d 0f bf c9 ed f9 04 86
........m.......
      0270: d6 cf 50 51 32 51 07 0e  ac c0 ce c5 a5 a6 61 d7
..PQ2Q........a.
      0280: d8 39 d2 32 87 ad 39 50  f3 f5 e1 b2 ea ec ed 9b
.9.2..9P........
      0290: 66 16 cf b6 0d 42 f4 a1  ec 88 89 ab 8b 16 62 80
f....B........b.
< ACL data: handle 42 flags 0x02 dlen 64
    L2CAP(d): cid 0x0042 len 60 [psm 0]
      0000: 23 ef 71 21 45 00 00 34  2e bf 40 00 40 06 99 c9
#.q!E..4..@.@...
      0010: 44 1b c3 dc 98 02 d2 41  11 6f 00 50 b4 73 47 f9
D......A.o.P.sG.
      0020: 96 f9 d0 17 80 10 54 50  c3 fc 00 00 01 01 08 0a
......TP........
      0030: 25 d1 2f 97 24 fb fc 93  69 ac 7e 5a              %./.$...i.~Z
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1

Brad


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
