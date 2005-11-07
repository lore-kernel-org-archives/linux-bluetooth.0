Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] dbus.c: cleanup/fix method parameter getting
Message-ID: <20051107093436.GB6845@localhost.localdomain>
References: <20051105124837.GA27883@localhost.localdomain> <1131315924.5824.14.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1131315924.5824.14.camel@blade>
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
Date: Mon, 7 Nov 2005 11:34:36 +0200

Hi Marcel,

On Sun, Nov 06, 2005, Marcel Holtmann wrote:
> we should do our own range check, because the intention is to design an
> API and not to simply map the Bluetooth HCI to D-Bus. If we have weird
> parameters that doesn't matter in real or are only for internal inside
> hcid or the kernel then we leave them out. If we wanna combine to HCI
> commands into one D-Bus method then we do this to. So please don't try
> to stick to the HCI specification. Try to design some logical API for
> Bluetooth.

Sure. However it would be nice to hear your opinions about e.g. the
level of abstraction we should strive for and if there are areas (e.g.
SDP) which should be abstracted more than others. At least for RFCOMM I
was thinking of doing a similar interface that we have in maemo [1],
where you could directly use identifiers such as "DUN" and "FTP" to
connect to a service without the need to do SDP separately. Of course
there should also be the possibility to use an exact UUID for less
common services.

[1] http://www.maemo.org/platform/docs/osso-gwconnect.html

> > Another thing with the inquiry and periodic inquiry methods is that the
> > inquiry method allows the caller to specify the num_responses parameter
> > while the periodic inquiry method has it hardcoded to 100 currently.
> > Should the parameter also be added to periodic inquiry or should it be
> > removed from normal inquiry?
> 
> See my comment above. The question here is if we need this parameter for
> any method call or should we make it a configurable option. So we have a
> sane default for num_responses and if somebody wants to use a different
> one that a second method to change it is needed.

Is there a reason to have a limit at all, i.e. why not always use the
value 0 (= unlimited number of responses)? Of course we can add a method
for setting another default, but can you give and example of a situation
where that would be needed?

Johan


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
