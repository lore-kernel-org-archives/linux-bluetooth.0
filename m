Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Charles Bueche <charles@bueche.ch>
To: Douglas Russell <puggy@gentoo.org>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] MX900 page updated
Message-Id: <20040625143916.77ad643c@bluez.bueche.ch>
In-Reply-To: <200406250941.15538.puggy@gentoo.org>
References: <20040624205328.47bf51ee@bluez.bueche.ch>
	<1088107922.4296.135.camel@pegasus>
	<200406250941.15538.puggy@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 25 Jun 2004 14:39:16 +0200

Hi Douglas,

thanks for the info. I added a link to your HOWTO and your message to
the feedback section.

Regs,
Charles

On Fri, 25 Jun 2004 09:41:15 +0000
Douglas Russell <puggy@gentoo.org> wrote:

> I know this has been covered above but I just thought I'd add a little
> more info. Gentoo has got 2.7 libs and utils, but the dependancy
> system doesn't work quite as well as necessary to take care of
> seemless rolling in of one package to another, so anyone upgrading
> should then make sure bluez-sdp and bluez-pan are unmerged before they
> upgrade. I'm working on making things like kdebluetooth compile with
> 2.7 libs at the moment as currently they fail as sdp are no longer
> independent libs. Should be ready soon. Also, I made a howto for
> gentoo, which is largely based on your excellent work Charles but
> updated for 2.7 (hidd) and customized.
> http://dev.gentoo.org/~puggy/btmouse-howto/btmousehowto.html
> 
> Puggy
> 
> On Thursday 24 June 2004 20:12, Marcel Holtmann wrote:
> > Hi Charles,
> >
> > > now that gentoo has a 2.6.7 kernel, I have tried Marcel's mh patch
> > > with success, and I have updated my page about my setup :
> >
> > aren't there any Gentoo packages for bluez-libs and bluez-utils?
> >
> > > I'm not sure wheter I still need the uinput module since I
> > > switched to hidd. I remember Marcel saying uinput is not needed
> > > with hidd. So who sends events to /dev/input/mice ? hidd directly
> > > ?
> >
> > You don't need uinput anymore. The HIDP Module will do this all by
> > itself. On my presentation at LinuxTag tomorrow I am going to show
> > how this all works. I created some nice new graphics ;)
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email sponsored by Black Hat Briefings & Training.
> > Attend Black Hat Briefings & Training, Las Vegas July 24-29 -
> > digital self defense, top technical experts, no vendor pitches,
> > unmatched networking opportunities. Visit www.blackhat.com
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
> digital self defense, top technical experts, no vendor pitches, 
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
