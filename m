Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   Max Krasnyansky <maxk@qualcomm.com>,
   Stephen Crane <steve.crane@rococosoft.com>
In-Reply-To: <1073041780.2634.162.camel@saag>
References: <1071791711.6635.18.camel@pegasus>
	 <1072989541.2634.154.camel@saag>  <1073041465.25261.21.camel@pegasus>
	 <1073041780.2634.162.camel@saag>
Content-Type: text/plain
Message-Id: <1073042658.25261.32.camel@pegasus>
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
Date: Fri, 02 Jan 2004 12:24:18 +0100

Hi Edd,

> > I am looking forward to include the bluez-pin as default pin-helper
> > program. Do you have included the DBUS patch for hcid? If yes, please
> > mail me the version you have used.
> 
> No, I didn't include this patch.

I have no coding experiences with DBUS at the moment, but I already
decided to make DBUS the default method for the new Bluetooth security
manager.

> Btw, the bluez-pin source seems to include a PNG of the Bluetooth logo
> -- I was under the impression that only qualified software can use
> this.  If so, we need to find some other logo to distribute, don't we?

I am no expert for this, but my understanding is that we can't use the
Bluetooth logo until the stack got its qualification. I think the best
way is to replace this logo. Maybe we should start an official BlueZ
logo contest.

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
