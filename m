Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0511011253j63b51196md1f9b3ee3918b525@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] dbus.c cleanup
In-Reply-To: <20051101202345.GA30490@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1130609278.5396.48.camel@blade> <1130612847.5396.51.camel@blade>
	 <e1effdeb0510310359g33724820y596b244076d08315@mail.gmail.com>
	 <1130760726.17124.17.camel@blade>
	 <e1effdeb0510310547m51a457f2m19f00ec5cf194289@mail.gmail.com>
	 <1130850674.31561.65.camel@blade>
	 <e1effdeb0511010521x6dfff470o9580b22bebd1c75d@mail.gmail.com>
	 <e1effdeb0511011108v13f75f08i6291e266eb235a34@mail.gmail.com>
	 <1130875099.5048.17.camel@blade>
	 <20051101202345.GA30490@localhost.localdomain>
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
Date: Tue, 1 Nov 2005 18:53:29 -0200

Hi,

Hal also add a timer to try re-initialize the connection and register
the paths when the "Disconnect" signal is received.

Ok guys I will try implement a similar HAL approach :)

Regards,
Claudio.

On 11/1/05, Johan Hedberg <johan.hedberg@nokia.com> wrote:
> On Tue, Nov 01, 2005, Marcel Holtmann wrote:
> > > IMHO, I think it not necessary handle this scenario. Restart the
> > > dbus-daemon is not common.
> >
> > Every time you update your D-Bus installation. The Ubuntu guys even
> > popup a message box that you should reboot your system ;)
>
> At least in debian there's a /etc/dbus-1/event.d directory where scripts
> are automatically run when the dbus daemons starts or stops. E.g. hal
> installs its own script there for starting/stoping hald at the right
> moment.
>
> Johan
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
> it for free - -and be entered to win a 42" plasma tv or your very own
> Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
