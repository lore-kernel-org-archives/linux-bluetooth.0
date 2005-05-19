Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HID Keyboard Emulator enquiry
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1116519017.6838.63.camel@tonyvaio.cregganna.com>
References: <1116512877.6838.52.camel@tonyvaio.cregganna.com>
	 <1116515326.24921.23.camel@pegasus>
	 <1116519017.6838.63.camel@tonyvaio.cregganna.com>
Content-Type: text/plain
Message-Id: <1116521849.24921.28.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 19 May 2005 18:57:28 +0200

Hi Anthony,

> > > I'm looking for a HID Bluetooth keyboard emulator for linux so that I
> > > can type to my Nokia phone from my PC. I tried google but no luck.
> > 
> > does your phone support HID-host?
> > 
> I believe it does - it supports the Su-8W Bluetooth keyboard.
> 
> http://www.nokia.com/nokia/0,,67021,00.html
> 
> I  have downloaded the phone's Symbian app and its looking for keyboards
> - I don't understand hcidump output so can't give a definitive answer as
> to what its looking for - I assume is HID.
> 
> (Can post hcidump output if you would like.)

I just installed the software on my Nokia 6600 and it is searching for
the Device ID record and the HID service record.

< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0067 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0067 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00

Both service records are not available and thus it fails.

> > > Does anyone know if such a thing already exists. If not I'm willing to
> > > write one.
> > 
> > At the moment nothing like this exists.
> 
> Great! Time to write some code! I assume I have to allocate a channel,
> advertise it with sdp, listen for a connection and the rest is just
> application code.....

Two channels. L2CAP PSM 17 and PSM 19.

> Any pointers to a similar bluez app I can copy the bluetooth stuff
> from..... Any manuals pages for coding to the bluez sdp and socket
> interfaces?

Not really, but this is straight forward socket programming. But you
need to use HIDP and HID reports and upper protocol.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
