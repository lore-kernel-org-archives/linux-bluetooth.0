Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Sjoerd Simons <sjoerd@luon.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] HCID D-Bus
Message-ID: <20050909132940.GE17543@spring.luon.net>
References: <e1effdeb050908125079935830@mail.gmail.com> <1126220839.5286.57.camel@blade> <5256d0b050909012577fcb19c@mail.gmail.com> <1126258645.5227.16.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1126258645.5227.16.camel@blade>
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
Date: Fri, 9 Sep 2005 15:29:40 +0200

On Fri, Sep 09, 2005 at 11:37:25AM +0200, Marcel Holtmann wrote:
> Hi Pete,
> 
> > I think 0.5 is compatible with >0.35. The current FC4 only uses  0.33
> > and I don't think its compatible with > 0.35. I think this is similar
> > for a number of the current releases (I think most with gnome 2.10)
> > but obviously isn't the case for the development streams that aren't
> > releases yet.
> 
> having 0.33 is better than 0.23 and this is what Debian unstable still
> uses. However lets make a list of the distributions:
> 
> 	SuSE Linux 10.0		D-Bus 0.35
> 	Fedora Core 4		D-Bus 0.33
> 	Ubuntu Breezy		D-Bus 0.36
> 	Debian unstable		D-Bus 0.23
    Debian experimental D-Bus 0.50
> 
> The only bad guy is Debian unstable and I don't care anymore. They use
> Xorg finally and have GCC 4.0 etc., but they can't move over to the next
> D-Bus generation. I think that is their problem now and the release of
> bluez-utils-0.22 will definitely drop the support for the old D-Bus 0.23
> version.

D-bus >= 0.3x has been in debian experimental for quite some time. There are
various transitions going on in debian unstable currently which makes it
inappropriate to do a dbus transition now too.
  
> I like to base everything around the current D-Bus 0.50 release, because
> the C API should be quite stable now. I will accept small workarounds to
> make D-Bus 0.3x work, but as soon as the distributions update their
> D-Bus libraries I will drop them.
> 
> This is not a nice thing to do, I know, but a wrong usage of D-Bus lets
> hcid segfault and this is not what I want.

As one of debian's dbus maintainers i would advise to indeed base everything on
dbus >= 0.50. Hopefully it won't take too long before we can move the new dbus
from experimental to unstable, so the workarounds for old dbus release are just
not worth it.

  Sjoerd
-- 
He keeps differentiating, flying off on a tangent.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
