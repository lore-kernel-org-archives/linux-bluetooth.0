Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3FFC03A3.5090807@york.ac.uk>
From: Alex Holland <ah160@york.ac.uk>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] blue-fw not working for USB Belkin F8T001 in	Gentoo
 Linux
References: <3FFBFC34.3050509@york.ac.uk> <1073479827.2508.143.camel@pegasus>
In-Reply-To: <1073479827.2508.143.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 07 Jan 2004 13:03:31 +0000

Marcel Holtmann wrote:

> I never got the bluefw working fine with my Broadcom based dongles. So I
> wrote a kernel driver for loading the firmware. My -mh2 patch for 2.6.0
> contains this bcm203x driver, but I haven't one for the 2.4 series.

Interesting - bluefw appeared to work when I was using the 2.4.20-r9 
kernel sources. It would report success, but my bluetooth connection was 
very dodgy (see previous mails about instability). However, I don't know 
if this was due to the usb extension cable I was using, or the firmware 
being loaded incorrectly (possibly the latter, as it worked fine in 
Windows even with the cable).

Any plans to backport the -mh2 patch to 2.4? The Gentoo devs would 
probably be interested, they're patch crazy :)

In the meantime, I'll just do the XP/Linux reboot trick, I guess.

Alex



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
