Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem "coldplugging"
From: Marcel Holtmann <marcel@holtmann.org>
To: Oguzhan Eris <eris3@ekls.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1073239248.2928.18.camel@localhost>
References: <1073239248.2928.18.camel@localhost>
Content-Type: text/plain
Message-Id: <1073243976.25261.160.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 04 Jan 2004 20:19:36 +0100

Hi,

> Hi, I was wondering if someone could help me out with a problem using
> the IOGEAR GBU301 device which requires bluefw.
> 
> Everything works fine if I hotplug the device with the device matching
> bluefw.usermap and running the appropriate bluefw command.  
> 
> I have kernel 2.6.0   (now upto  rc1-mm1)  with the bluetooth matches
> from patch-2.6.0-mh1   (it applied cleanly to 2.6.0-rc1)  I have tried
> ALL combinations.

the patch-2.6.0-mh1 don't apply cleanly to 2.6.0-rc1 :(

Try to use 2.6.0-mh2 and don't install bluefw. The new bcm203x provides
the same functionalty and uses the firmware.agent hotplug script for
firmware loading.

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
