Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0603070703u3b6001d7p869dfb71f5601108@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] dbus pin failure
In-Reply-To: <1141684560.4733.16.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1141396234.8699.10.camel@localhost.localdomain>
	 <1141397987.12964.23.camel@aeonflux.holtmann.net>
	 <1141418085.8699.23.camel@localhost.localdomain>
	 <1141532537.4871.9.camel@aeonflux.holtmann.net>
	 <1141663646.4110.60.camel@pmac.infradead.org>
	 <1141666471.4733.3.camel@aeonflux.holtmann.net>
	 <1141683988.29230.3.camel@localhost.localdomain>
	 <1141684560.4733.16.camel@aeonflux.holtmann.net>
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
Date: Tue, 7 Mar 2006 12:03:37 -0300

Hi David,

Try this version:
http://www.cin.ufpe.br/~ckt/gbluezconf/gbluezconf-00.10.tar.gz

It's isn't fully compliant with the latest D-Bus API, but it's working fine=
.

Regards,
Claudio.




On 3/6/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi David,
>
> > > so I assume this means that bluez-pin is at fault. Actually that is
> > > out of my responsibility.
> >
> > Do you have a sample PIN helper which is known to work? My dbus-fu is
> > weak; it would help if dbus wasn't a moving target :)
>
> you might wanna try this one:
>
> http://www.cin.ufpe.br/~ckt/gbluezconf/gbluezconf-00.08.tar.gz
>
> It is actually kinda rough, but did quite a good job on one of mobile
> systems.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
> that extends applications into web and mobile media. Attend the live webc=
ast
> and join the prime developer group breaking into this new coding territor=
y!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=
=3D121642
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
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
