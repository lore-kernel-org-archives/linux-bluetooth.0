Return-Path: <listas@loquecreas.com>
Message-Id: <200410311021.i9VALQvJ002716@mail.holtmann.net>
From: "Pablo Vieira" <listas@loquecreas.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Talking to a digital camera
Date: Sun, 31 Oct 2004 11:21:19 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <1099216155.16247.36.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

This thing

http://h10010.www1.hp.com/wwpc/us/en/sm/WF05a/18972-236253-64302-34210-64302
-314647.html

seems to support BIP. Sorry for my ignorance, but would it make it usable
for my project?

Thanks

Pablo

> -----Mensaje original-----
> De: bluez-users-admin@lists.sourceforge.net [mailto:bluez-users-
> admin@lists.sourceforge.net] En nombre de Marcel Holtmann
> Enviado el: domingo, 31 de octubre de 2004 10:49
> Para: Pablo Vieira
> CC: BlueZ Mailing List
> Asunto: RE: [Bluez-users] Talking to a digital camera
> 
> Hi Pablo,
> 
> think about the "Reply to All" button ;)
> 
> > > > I want to talk wirelessly to a digicam (a Canon Powershot A75, but
> most
> > > use
> > > > similar protocols). These cameras use USB to talk to the host
> computer
> > > and
> > > > I'm wondering if I could use any Bluetooth device to serve as a
> wireless
> > > > bridge to the camera, in the same way there are Bluetooth printer
> > > adapters
> > > > that talk to printers. Actually, I was thinking: would it be
> possible to
> > > use
> > > > one of these adapters?
> > > >
> > > > I AM NOT TRYING TO DOWNLOAD OR UPLOAD PICTURES from or to the
> camera. I
> > > just
> > > > want the camera's shutter to be released remotely, as well as
> setting up
> > > > parameters such as shutter speed, aperture, etc.
> > >
> > > I haven't heard of any adapter like this, but what you need sounds
> like
> > > PTP to BIP bridge.
> > >
> > Thanks Marcel, do you know what would be the difference between a BT
> printer
> > adapter and the one I need? Wouldn't it be possible to use a printer
> adapter
> > to talk to the camera?
> 
> this depends on if the USB descriptors are matching, but in general you
> don't have PTP or USB storage on the printer.
> 
> > I'm trying to subscribe to the gphoto lists (I have some technical
> problems
> > that I'm trying to solve) but PTP seems to be geared towards downloading
> and
> > uploading pictures, not simple camera control. Don't know what BIP is,
> could
> > you please tell me?
> 
> BIP means Basic Imaging Profile and the rest you should find out by
> yourself.
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
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
