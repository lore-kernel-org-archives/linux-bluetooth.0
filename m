Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] dbus.c: cleanup/fix method parameter
	getting
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051107093436.GB6845@localhost.localdomain>
References: <20051105124837.GA27883@localhost.localdomain>
	 <1131315924.5824.14.camel@blade>
	 <20051107093436.GB6845@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1131359661.5824.97.camel@blade>
Mime-Version: 1.0
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
Date: Mon, 07 Nov 2005 11:34:21 +0100

Hi Johan,

> > we should do our own range check, because the intention is to design an
> > API and not to simply map the Bluetooth HCI to D-Bus. If we have weird
> > parameters that doesn't matter in real or are only for internal inside
> > hcid or the kernel then we leave them out. If we wanna combine to HCI
> > commands into one D-Bus method then we do this to. So please don't try
> > to stick to the HCI specification. Try to design some logical API for
> > Bluetooth.
> 
> Sure. However it would be nice to hear your opinions about e.g. the
> level of abstraction we should strive for and if there are areas (e.g.
> SDP) which should be abstracted more than others. At least for RFCOMM I
> was thinking of doing a similar interface that we have in maemo [1],
> where you could directly use identifiers such as "DUN" and "FTP" to
> connect to a service without the need to do SDP separately. Of course
> there should also be the possibility to use an exact UUID for less
> common services.

I like that idea and since one of my advanced goals is to implement a
full SDP client into bluetoothd, this would work out just fine. Actually
the D-Bus interface should not use any kind of RFCOMM channel or L2CAP
PSM numbers. I consider it more as an API to the Bluetooth profiles and
not the protocols. So in the case of RFCOMM <-> TTY assignments we may
only wanna use bdaddr + uuid as parameters. The UUID then can be a clear
text value like "dun" or "ftp" or a hex value like "0x1111". For the
BD_ADDR it would also make sense if this can be an alias or the remote
name. Maybe changing the parameter name to device would be better.

Since the current SDP library is blocking, we would need some SDP client
code that integrates nicely into an event loop.

> > > Another thing with the inquiry and periodic inquiry methods is that the
> > > inquiry method allows the caller to specify the num_responses parameter
> > > while the periodic inquiry method has it hardcoded to 100 currently.
> > > Should the parameter also be added to periodic inquiry or should it be
> > > removed from normal inquiry?
> > 
> > See my comment above. The question here is if we need this parameter for
> > any method call or should we make it a configurable option. So we have a
> > sane default for num_responses and if somebody wants to use a different
> > one that a second method to change it is needed.
> 
> Is there a reason to have a limit at all, i.e. why not always use the
> value 0 (= unlimited number of responses)? Of course we can add a method
> for setting another default, but can you give and example of a situation
> where that would be needed?

The num_responses and the IAC should be separate setting. It would be
great if this setting is specific to the D-Bus session of the caller. In
this case every D-Bus user can have its own settings. Do you think this
is possible?

For the time (length) of the inquiry I am not sure at the moment.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
