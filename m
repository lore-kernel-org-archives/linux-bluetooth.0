Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] RE: Qualification testing - rfcomm
Date: Fri, 11 Jul 2003 12:05:13 -0700
Message-ID: <001501c347df$5c945550$1a01010a@baked>
MIME-Version: 1.0
In-Reply-To: <001001c347cb$97a39840$1a01010a@baked>
Content-Type: multipart/mixed; boundary="=-Mp4WBDsX/xbh7QroFArr"
List-ID: <bluez-devel.lists.sourceforge.net>


--=-Mp4WBDsX/xbh7QroFArr
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; CHARSET=us-ascii

Marcel,

I just reproduced it here. Attached is an aclsession script which will do
it. First run aclsession on one machine, then run rctest on the other
machine. Also attached are the console output and hcidump from the machine
running rctest.

The pattern of send 5 packets, wait 20 seconds, send 5 more, etc appears to
continue forever. I'm told that it should just keep sending data.

-Daryl.

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net 
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of 
> Daryl Van Vorst
> Sent: July 11, 2003 9:44 AM
> To: 'Marcel Holtmann'
> Cc: 'BlueZ Mailing List'
> Subject: [Bluez-devel] RE: Qualification testing - rfcomm
> 
> 
> Marcel,
> 
> You're right that it doesn't check the error code, it just 
> exits. But that doesn't explain why it sends 5 frames, waits 
> for 20 seconds, and then sends 5 more.  Shouldn't send block?
> 
> I haven't yet tried to reproduce that behaviour.  So I'm not 
> certain that the sequence of send 5, wait 20, send 5 repeats 
> indefinitely.  I'll take a look at it shortly.
> 
> Thanks for the flow control patch...  I'll wait and see if 
> anything comes out of the above stuff before sending it out 
> for testing.
> 
> -Daryl.
> 
> > -----Original Message-----
> > From: Marcel Holtmann [mailto:marcel@rvs.uni-bielefeld.de]
> > Sent: July 11, 2003 1:55 AM
> > To: Daryl Van Vorst
> > Cc: BlueZ Mailing List
> > Subject: Re: Qualification testing - rfcomm
> > 
> > 
> > Hi Daryl,
> > 
> > > Finally got some results on those latest rfcomm changes for
> > > qualification. Looks like there are a few more problems. :( 
> >  But we're
> > > close. :)
> > > 
> > > TP/RFC/BV-09-C:
> > > "Verify that the IUT handles flow control correctly when
> > the Tester,
> > > acting as a device conforming to Bluetooth version 1.0B,
> > controls the
> > > data flow using the Modem Status Command. The IUT's device
> > role is of
> > > no importance."
> > > 
> > > The command and console output:
> > > 
> > > root@jack-00000000:~>./rctest -s -P 1 -b 20 00:A0:96:1F:83:71
> > > rctest[351]: Connected
> > > rctest[351]: Sending ...
> > > rctest[351]: Send failed. Resource temporarily unavailable(11)
> > > 
> > > The IUT sends data in 5 frames, then stops for aboue 20s,
> > then sends 5
> > > more, then stops, etc. Technically, this test passed 
> because we did
> > > stop sending data after the tester send MSC stop to the IUT. But 
> > > something's clearly not right.
> > 
> > this looks quite right, but the rctest program don't check
> > the error code. If it receives EAGAIN it should try again, 
> > but it aborts.
> > 
> > Regards
> > 
> > Marcel
> > 
> > 
> > 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Parasoft
> Error proof Web apps, automate testing & more.
> Download & eval WebKing and get a free book. 
> www.parasoft.com/bulletproofapps1 
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net 
> https://lists.sourceforge.net/lists/listinfo/b> luez-devel
> 

--=-Mp4WBDsX/xbh7QroFArr
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="rc_aclsession"
Content-Type: application/octet-stream; NAME=rc_aclsession

open 00:80:37:1a:95:78
wait 10
send 0C 00 01 00 03 01 08 00 40 00 40 00 00 00 00 00
wait 10
send 0A 00 01 00 05 02 06 00 40 00 00 00 00 00
send 08 00 01 00 04 8C 04 00 40 00 00 00
wait 10
wait 10
send 04 00 40 00 03 73 01 D7
wait 10
send 0E 00 40 00 01 EF 15 81 11 02 00 07 00 00 01 00 00 AA
wait 10
send 04 00 40 00 0B 73 01 92
wait 10
send 08 00 40 00 01 EF 09 E1 05 0B 8D AA
send 08 00 40 00 01 EF 09 E3 05 0B 8D AA
wait 10
wait 10
wait 10
wait 10
wait 10
wait 10


--=-Mp4WBDsX/xbh7QroFArr
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="rc_console"
Content-Type: application/octet-stream; NAME=rc_console

./rctest -s -P1 -b 20 00:80:37:19:BA:86
rctest[21784]: Connected
rctest[21784]: Sending ...


--=-Mp4WBDsX/xbh7QroFArr
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="rc_hcidump"
Content-Type: application/octet-stream; NAME=rc_hcidump

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
AQA=

--=-Mp4WBDsX/xbh7QroFArr--
