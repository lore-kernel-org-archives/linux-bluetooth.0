Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Wed, 21 Jun 2006 10:52:55 +0530
Message-ID: <000801c694f2$c07e3190$7f0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1150792316.18381.11.camel@localhost>
Subject: Re: [Bluez-users] dbus-glib problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel
Could you tell me what change did you make to remove the dbus-glib check. I
can make the same change on my side as I am unable to access CVS from my
machine.

Thanks for your kind help.

Best Regards,

Sumeet



-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Tuesday, June 20, 2006 2:02 PM
To: BlueZ users
Subject: Re: [Bluez-users] dbus-glib problem


Hi,

> >> checking for BLUEZ... yes
> >> checking for DBUS... Package dbus-glib-1 was not found in the 
> >> pkg-config search path. Perhaps you should add the directory 
> >> containing `dbus-glib-1.pc' to the PKG_CONFIG_PATH environment 
> >> variable No package 'dbus-glib-1' found
> >> configure: error: dbus-glib > 0.35 is required
> >>
> >> There seem to be some dependencies. I have tried installing 
> >> dbus-0.61 and glib-2.8.6 but it does not work. Please tell me what 
> >> packages to install to remove these dependencies and send me a link 
> >> also if possible.
> > 
> > we don't require the dbus-glib bindings. No idea why it is looking 
> > for them. This seems like a bug in D-Bus package. What kind 
> > distribution is this?
> 
> I had the same problem on my ubuntu. You have to install 
> dbus-glib-dev.
> The configure script is looking for the include files but apparently 
> does not seems to say it.

oops. This is my mistake. I accidentally put in a check for dbus-glib, but
this is not needed at all. We only use the low-level D-Bus API. I fixed that
in the CVS now.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
