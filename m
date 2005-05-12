Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec050512165123ac21b1@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] trouble setting up pand
In-Reply-To: <20050512183747.75536.qmail@web21125.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050512183747.75536.qmail@web21125.mail.yahoo.com>
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
Date: Thu, 12 May 2005 19:51:10 -0400

Try using a different release of familiar.

I believe bluetooth support is broken in familiar 0.8.1 and 0.8.2.  We
were unable to get bluetooth working on a H5550 or H3800 and
encountered inexplicable errors that did not appear on other versions
of familiar and on x86 machines.

I recommend pb's unstable16 build that he made about a year ago.  You
can find that.here:
http://handhelds.org/~pb/unstable/old/

-albert

On 5/12/05, Vinod <geekvinod@yahoo.com> wrote:
>=20
> > > 1) modprobe bnep's on both ipaqs
> > > 2) set one as master and confirmed it
> > > 3) pand --listen --role GN on the master
> > > 4) pand --connect 'master-address' which i got
> > from
> > > hcitool scan
> >
> > skip step 2, because it may cause troubles.
>=20
> tried skipping step 2 and set both back as
> slaves,resulting in same error.
>=20
> > > Then i get the following message
> > >
> > > root@h3600:/etc/bluetooth# udhcpc[29501]: udhcpc
> > > (v0.9.9-pre) started
> > > udhcpc[29501]: SIOCGIFINDEX failed!: No such
> > device
> >
> > What else do you see in the syslog. Run "hcidump -X
> > -V" as root to check
> > the BNEP connection setup.
> Unfortunately the latest familiar version(0.8.2),
> which i have, does not have hcidump in its linux
> distribution. And i still havent figured a way out to
> compile with gcc on my ipaq. is there any other other
> way to check bnep0 status? Doing ifconfig bnep0
> returns
>=20
> ifconfig bnep0
> ifconfig: bnep0: error fetching interface information:
> Device not found
>=20
> So i believe bnep connection does not exist.
>=20
> would appreciate if you let me know if any other
> workaround exists until i figure out a way to run make
> on my ipaq.
>=20
> Vinod
>=20
> Yahoo! Mail
> Stay connected, organized, and protected. Take the tour:
> http://tour.mail.yahoo.com/mailtour.html
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=3D7393&alloc_id=3D16281&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
