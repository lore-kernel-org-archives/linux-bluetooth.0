Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   Max Krasnyansky <maxk@qualcomm.com>,
   Stephen Crane <steve.crane@rococosoft.com>
In-Reply-To: <1072989541.2634.154.camel@saag>
References: <1071791711.6635.18.camel@pegasus>
	 <1072989541.2634.154.camel@saag>
Content-Type: text/plain
Message-Id: <1073041465.25261.21.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: Release of new BlueZ libs and utils
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
Date: Fri, 02 Jan 2004 12:04:25 +0100

Hi Edd,

> > For the BlueZ libs I don't plan another release, because the new major
> > version of the Bluetooth library is making good progress. But for the
> > BlueZ Utils I want to make another release that addresses the problems
> > with the pin_helper program. I think the C based bluez-pin is a good
> > idea and maybe we should also integrate the DBus support into the next
> > release. So I like to get comments on this and if you have patches,
> > please resend them.
> 
> For a while now the Debian packages have brought in the DBUS/GTK
> bluez-pin implementation as the default, and I've had no complaints at
> all. DBUS seems to be really catching on as the way to do things like
> this.

I am looking forward to include the bluez-pin as default pin-helper
program. Do you have included the DBUS patch for hcid? If yes, please
mail me the version you have used.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
