Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Thu, 8 May 2003 11:33:10 -0700
Message-ID: <000901c31590$472273e0$5796fea9@baked>
MIME-Version: 1.0
In-Reply-To: <1052401433.2669.93.camel@pegasus.local>
Content-Type: text/plain; CHARSET=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

> >         4.) TP/COS/RCO/BI-01, BI-02: These tests verify=20
> that the IUT=20
> > performs a consistency check on the data. Both tests send=20
> two packets=20
> > to the IUT. In each test, the first packet has a mistake.=20
> In BI-01 the=20
> > first packet is too short by one byte, and in BI-02 the=20
> first packet=20
> > is too long by one byte. In both cases the stack must correctly=20
> > receive the second packet, but not the first. The data should be=20
> > discarded in the case of the inconsistencies, and an error=20
> reported to=20
> > the application.
>=20
> It seems that we can't handle this case complete correctly,=20
> if the data was put only in one fragment. But in the basics=20
> this should work and the malformed packets should be dropped.=20
> Did you have a detailed log of this test which shows us byte=20
> by byte which request was sent?

It appears that things got a bit confused in the BV-01 case. In the BV-02
case, the stack tossed the extra byte and reported the error to stderror bu=
t
not to the application. To pass the test the application must be told that
there was an error reading the data (my interpretation of the test case is
that the stack can still send the application the data, but it must be
flagged as a failure). In both cases, the second packet should be correctly
received. It's not clear to me from the test case that receiving the second
packet correctly is mandatory, but it might be. It shouldn't be a problem t=
o
receive it correctly.

Below are the two scenarios:

BV-01 case:

3451624.786137 < 01 05 04 0D 71 83 1F 96 A0 00 18 CC 00 00 00 00 01=20
 3451624.790905 > 04 0F 04 00 07 05 04=20
 3451628.318245 > 04 03 0B 00 01 00 71 83 1F 96 A0 00 01 00=20
 3451628.318729 > 04 0F 04 00 08 00 00=20
 3451628.318786 < 02 01 20 0C 00 08 00 01 00 02 01 04 00 01 00 40 00=20
 3451628.318851 < 01 0D 08 04 01 00 0E 00=20
 3451628.352279 > 04 0E 06 08 0D 08 00 01 00=20
 3451628.354970 > 04 1B 03 01 00 05=20
 3451628.412420 > 04 13 05 01 01 00 01 00=20
 3451629.731541 > 02 01 20 10 00 0C 00 01 00 03 01 08 00 40 00 40 00 00 00
00=20
  00=20
 3451629.732281 < 02 01 20 0C 00 08 00 01 00 04 02 04 00 40 00 00 00=20
 3451629.772684 > 04 13 05 01 01 00 01 00=20
 3451630.704342 > 02 01 20 16 00 12 00 01 00 05 02 0E 00 40 00 00 00 00 00
01=20
  02 FF 00 02 02 FF FF=20
 3451631.824537 > 02 01 20 14 00 10 00 01 00 04 01 0C 00 40 00 00 00 01 02
FF=20
  00 02 02 FF FF=20
 3451631.824697 < 02 01 20 0E 00 0A 00 01 00 05 01 06 00 40 00 00 00 00 00=20
 3451631.843088 > 04 13 05 01 01 00 01 00=20
 3451635.601252 > 02 01 20 33 00 30 00 40 00 31 32 33 34 35 36 37 38 39 30
3A=20
  3B 3C 3D 3E 3F 31 32 33 34 35 36 37 38 39 30 3A 3B 3C 3D 3E=20
  3F 31 32 33 34 35 36 37 38 39 30 3A 3B 3C 3D 3E=20
 3451635.601809 > 04 FF 1B 06 19 45 72 72 6F 72 20 69 6E 20 6C 6D 5F 64 61
74=20
  61 2E 63 28 31 37 31 34 29 0A=20
 3451635.630626 > 02 01 20 34 00 30 00 40 00 31 32 33 34 35 36 37 38 39 30
3A=20
  3B 3C 3D 3E 3F 31 32 33 34 35 36 37 38 39 30 3A 3B 3C 3D 3E=20
  3F 31 32 33 34 35 36 37 38 39 30 3A 3B 3C 3D 3E 3F=20

root@jack-00000000:~>./l2test1 -u -P 1 00:a0:96:1f:83:71
l 2test[568]: Conl2cap_recv_acldata: Unexpected start frame (len 52)
l2test[568]: seq missmatch: 0 -> 875770417
l2test[568]: size missmatch: 48 -> 13877
l2test[568]: Read failed. Function not implemented(38)
DV: recv error: Function not implemented(38)
l2test[568]: Exit

Note: the line above that starts with "DV:" was just a printf I added just
to check something. You can ignore it.

BV-02 case:

3451212.377519 > 04 05 04 00 01 00 1F=20
 3451217.001182 > 04 04 0A 71 83 1F 96 A0 00 00 00 00 01=20
 3451217.001882 < 01 09 04 07 71 83 1F 96 A0 00 01=20
 3451217.005163 > 04 0F 04 00 08 09 04=20
 3451217.022390 > 04 03 0B 00 01 00 71 83 1F 96 A0 00 01 00=20
 3451217.023089 < 01 0D 08 04 01 00 0E 00=20
 3451217.038752 > 04 0E 06 08 0D 08 00 01 00=20
 3451217.039391 < 01 0F 04 04 01 00 18 CC=20
 3451217.042422 > 04 0F 04 00 07 0F 04=20
 3451217.053451 > 04 1D 05 00 01 00 18 CC=20
 3451217.053881 > 04 0F 04 00 08 00 00=20
 3451217.054253 > 04 1B 03 01 00 05=20
 3451221.347537 > 02 01 20 0C 00 08 00 01 00 02 01 04 00 01 00 40 00=20
 3451221.348308 < 02 01 20 10 00 0C 00 01 00 03 01 08 00 40 00 40 00 00 00
00=20
  00=20
 3451221.379927 > 04 13 05 01 01 00 01 00=20
 3451222.532855 > 02 01 20 14 00 10 00 01 00 04 01 0C 00 40 00 00 00 01 02
FF=20
  00 02 02 FF FF=20
 3451222.533633 < 02 01 20 0E 00 0A 00 01 00 05 01 06 00 40 00 00 00 00 00=20
 3451222.533719 < 02 01 20 0C 00 08 00 01 00 04 01 04 00 40 00 00 00=20
 3451222.568912 > 04 13 05 01 01 00 01 00=20
 3451222.580161 > 04 13 05 01 01 00 01 00=20
 3451223.503064 > 02 01 20 16 00 12 00 01 00 05 01 0E 00 40 00 00 00 00 00
01=20
  02 FF 00 02 02 FF FF=20
 3451225.027417 > 02 01 20 33 00 2F 00 40 00 31 32 33 34 35 36 37 38 39 30
3A=20
  3B 3C 3D 3E 3F 31 32 33 34 35 36 37 38 39 30 3A 3B 3C 3D 3E=20
  3F 31 32 33 34 35 36 37 38 39 30 3A 3B 3C 3D 3E=20
 3451225.035109 > 02 01 00 01 00 3F=20
 3451225.035598 > 04 FF 1B 06 19 45 72 72 6F 72 20 69 6E 20 6C 6D 5F 64 61
74=20
  61 2E 63 28 31 39 30 34 29 0A=20
 3451226.772904 > 02 01 20 34 00 30 00 40 00 31 32 33 34 35 36 37 38 39 30
3A=20
  3B 3C 3D 3E 3F 31 32 33 34 35 36 37 38 39 30 3A 3B 3C 3D 3E=20
  3F 31 32 33 34 35 36 37 38 39 30 3A 3B 3C 3D 3E 3F=20

root@jack-00000000:~>./l2test -d -P 1
l2test[586]: Waiting for connection on psm 1 ...
l2test[587]: Connect from 00:A0:96:1F:83:71 [imtu 672, omtu 255, flush_to
65535]
l2test[587]: Receiving ...
l2cap_recv_acldata: Unexpected continuation frame (len 1)
l2test[587]: Recevied 47 bytes
l2test[587]: Recevied 48 bytes

-Daryl.
