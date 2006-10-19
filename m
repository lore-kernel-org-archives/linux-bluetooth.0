Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 19 Oct 2006 14:41:07 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061019124107.GD31910@suse.de>
References: <20061019115608.GB31910@suse.de>
	<1161259469.27710.40.camel@localhost>
	<20061019123133.GA18838@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20061019123133.GA18838@localhost.localdomain>
Subject: Re: [Bluez-users] DiscoverDevices with apitest?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Thu, Oct 19, 2006 at 03:31:33PM +0300, Johan Hedberg wrote:
> On Thu, Oct 19, 2006, Marcel Holtmann wrote:
> > You need to keep the calling application running, because otherwise hcid
> > will stop the discovery. That is actually what you see in syslog.
> =

> You could also try the attached patch. After that the following command =

> should do the trick:
> ./apitest -l DiscoverDevices

almost, see below
 =

> I think we may want to apply this to CVS. Marcel, what do you think?

I like it :-) I already had tried apitest -l DiscoverDevices, but it did
not work.

> Index: apitest
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/bluez/utils/test/apitest,v
> retrieving revision 1.1
> diff -u -r1.1 apitest
> --- apitest	28 Sep 2006 15:23:24 -0000	1.1
> +++ apitest	19 Oct 2006 12:30:33 -0000
> @@ -399,7 +399,8 @@
>              self.dbus_mgr_sig_setup()
>              self.dbus_dev_sig_setup()
>              print 'Listening for events...'
> -        elif self.cmd in mgr_cmds:
> +
> +        if self.cmd in mgr_cmds:
>              try:
>                  self.dbus_mgr_setup()
>              except dbus.DBusException, e:
> @@ -413,7 +414,7 @@
>                  print 'Failed to setup device interface: %s' % e
>                  sys.exit(1)
>              self.call_dev_dbus_func()
> -        else:
> +        else if not self.listen:

           elif not self.listen

>              print 'Unknown command: %s' % self.cmd
>              self.usage()
>              sys.exit(1)
-- =

Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohen

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
