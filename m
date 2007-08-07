Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 7 Aug 2007 12:02:48 -0700 (PDT)
From: hong zhang <henryzhang62@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <mailman.164992.1186500592.21973.bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <525899.68874.qm@web58013.mail.re3.yahoo.com>
Subject: Re: [Bluez-users] configure: error: dbus > 0.35 is requered
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

List,

I am using bluez-utils-3.11 for ARM embedded linux.
When hcid is buildt, it complains libdbus-1.so

/usr/lib/libdbus-1.so: could not read symbols: File in
wrong format.

Because embedded linux kernel version is awalys behind
the most recent released kernel.
And I could not find old versions for bluez in
www.bluez.org.

What version of libdbus needed to match
bluez-utils-3.13 or 11?

---henry 
--- bluez-users-request@lists.sourceforge.net wrote:

> Send Bluez-users mailing list submissions to
> 	bluez-users@lists.sourceforge.net
> 
> To subscribe or unsubscribe via the World Wide Web,
> visit
> 
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> or, via email, send a message with subject or body
> 'help' to
> 	bluez-users-request@lists.sourceforge.net
> 
> You can reach the person managing the list at
> 	bluez-users-owner@lists.sourceforge.net
> 
> When replying, please edit your Subject line so it
> is more specific
> than "Re: Contents of Bluez-users digest..."
> 
> 
> Today's Topics:
> 
>    1. configure: error: dbus > 0.35 is requered (Je
> Co)
>    2. Re: configure: error: dbus > 0.35 is requered
> (Marcel Holtmann)
>    3. Re: configure: error: dbus > 0.35 is requered
> (Je Co)
>    4. Re: configure: error: dbus > 0.35 is requered
> (Adrian van Dongen)
>    5. [REGRESSION] last working kernel 2.6.18
> (Guennadi Liakhovetski)
>    6. Re: [REGRESSION] last working kernel 2.6.18
>       (Guennadi Liakhovetski)
>    7. Re: [REGRESSION] last working kernel 2.6.18
> (Marcel Holtmann)
> 
> 
>
----------------------------------------------------------------------
> 
> Message: 1
> Date: Tue, 7 Aug 2007 00:51:01 -0700 (PDT)
> From: Je Co <hulcjje@yahoo.com>
> Subject: [Bluez-users] configure: error: dbus > 0.35
> is requered
> To: bluez-users@lists.sourceforge.net
> Message-ID:
> <72022.81167.qm@web32403.mail.mud.yahoo.com>
> Content-Type: text/plain; charset="iso-8859-1"
> 
> Hello,
> 
> I'm trying to get bluetooth working om my
> Absolute-box. Hope I'm doing the right things,  to
> me  it's a bit confusing what to do to get things
> working properly.
> 
> Now I'm trying to install the bluez-libs and
> bluez-utils. Think bluez-libs went well, but
> bluez-utils gives error when configuring.
> 
> Searched into old posts, but couldn't find the
> solution (think due to my lack of knowledge).
> 
> Don't think dbus is installed on my system, but what
> confuses me most, is that it seems to me that part
> of the installation is installing dbus (isn't it in
> the  dir 'common'?). 
> 
> What do I have to do?
> 
> Thanks in advance.
> 
> 
>        
> ---------------------------------
> Fussy? Opinionated? Impossible to please? Perfect. 
> Join Yahoo!'s user panel and lay it on us.
> -------------- next part --------------
> An HTML attachment was scrubbed...
> 
> ------------------------------
> 
> Message: 2
> Date: Tue, 07 Aug 2007 10:04:00 +0200
> From: Marcel Holtmann <marcel@holtmann.org>
> Subject: Re: [Bluez-users] configure: error: dbus >
> 0.35 is requered
> To: BlueZ users <bluez-users@lists.sourceforge.net>
> Message-ID: <1186473840.20129.44.camel@violet>
> Content-Type: text/plain
> 
> Hi,
> 
> > I'm trying to get bluetooth working om my
> Absolute-box. Hope I'm doing
> > the right things,  to me  it's a bit confusing
> what to do to get
> > things working properly.
> > 
> > Now I'm trying to install the bluez-libs and
> bluez-utils. Think
> > bluez-libs went well, but bluez-utils gives error
> when configuring.
> > 
> > Searched into old posts, but couldn't find the
> solution (think due to
> > my lack of knowledge).
> > 
> > Don't think dbus is installed on my system, but
> what confuses me most,
> > is that it seems to me that part of the
> installation is installing
> > dbus (isn't it in the  dir 'common'?). 
> 
> you have to install the low-level D-Bus library
> libdbus and its
> development files. This is a hard requirement.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> 
> ------------------------------
> 
> Message: 3
> Date: Tue, 7 Aug 2007 04:10:20 -0700 (PDT)
> From: Je Co <hulcjje@yahoo.com>
> Subject: Re: [Bluez-users] configure: error: dbus >
> 0.35 is requered
> To: BlueZ users <bluez-users@lists.sourceforge.net>
> Message-ID:
> <482434.64770.qm@web32409.mail.mud.yahoo.com>
> Content-Type: text/plain; charset="iso-8859-1"
> 
> Marcel,
> 
> Thanks for fast reply!
> 
> Downloaded, configured, made and installed d-bus
> package, no problems.
> 
> Configuring, making and installing bluez-utils, no
> problems anymore.
> 
> Now I finally can start using the commands I find in
> other postings (hcitool etc.).
> 
> Didn't connect to my phone yet, but will be a matter
> of time I hope.
> 
> Think what lacks is a simple how-to from
> user-perspective how to get bluetooth up and
> running, in case a distro doesn't contain all
> necessary software like Absolute.
> 
> Jeu.
> 
> 
> Marcel Holtmann <marcel@holtmann.org> wrote: you
> have to install the low-level D-Bus library libdbus
> and its
> development files. This is a hard requirement.
> 
> Regards
> 
> Marcel
> 
> 
> 
>        
> ---------------------------------
> Building a website is a piece of cake. 
> Yahoo! Small Business gives you all the tools to get
> online.
> -------------- next part --------------
> An HTML attachment was scrubbed...
> 
> ------------------------------
> 
> Message: 4
> Date: Tue, 7 Aug 2007 13:18:20 +0200
> From: "Adrian van Dongen"
> <adrianvandongen@gmail.com>
> Subject: Re: [Bluez-users] configure: error: dbus >
> 0.35 is requered
> To: "BlueZ users"
> <bluez-users@lists.sourceforge.net>
> Message-ID:
> 
>
<cfd8c35a0708070418l1480ca07r7fa151be35aa5bb@mail.gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
> 
> I agree,
> 
> But i think this is up to the different distro's to
> provide the
> documentation for there end users, not the bluez
> community.
> 
=== message truncated ===



       
____________________________________________________________________________________
Moody friends. Drama queens. Your life? Nope! - their life, your story. Play Sims Stories at Yahoo! Games.
http://sims.yahoo.com/  

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
