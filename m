Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexander Holler <holler@ahsoftware.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <27710000.1071661012@[192.168.207.2]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] bluepin (gtk2 and actual xfree86)
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 Dec 2003 12:36:52 +0100

Hi,

as I'm using gentoo, I had the need for a gtk2-enabled-bluepin.

I've found a working patch in bluez-utils-2.3-14.src.rpm.

But to get it running on my system with xfree 4.3.0 I also had to comment 
out the following two lines:

#--------------------------------------------
# Set X display before initializing GTK
#set_display()

# Some versions of fontconfig will segfault if HOME isn't set.
#os.environ['HOME'] = ""
--------------------------------------------

Maybe this should be included in bluez-utils. GTK2 is now used widely so 
the rh-patch is something really usefull.

For the env-settings (HOME, DISPLAY, and XAUTHORITY), I don't now why they 
are set in bluepin, but without it works fin on my system (with it work 
not).

As I have only gentoo systems here, maybe someon with Debain, SuSE and/or 
RH could test if it works on those Systems too without setting these 
evnironment variables inside bluepin.

For the bluez-utils package, I would prefer to rename bluepin to 
bluepin-gtk1 and would checkin the gtk2-enabled-bluepin as plain bluepin.

Regards,

Alexander



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
