Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alex Holland <ah160@student.cs.york.ac.uk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Compile bluez-bluefw-1.0 fails
References: <200404182321.55431.dvornheder@t-online.de> <200404191419.59021.ah160@student.cs.york.ac.uk> <1082381412.4403.42.camel@pegasus>
In-Reply-To: <1082381412.4403.42.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404191441.53945.ah160@student.cs.york.ac.uk>
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
Date: Mon, 19 Apr 2004 14:41:53 +0100

On Monday 19 Apr 2004 14:30, Marcel Holtmann wrote:

> > bcm203x_probe: Mini driver request failed
>
> that is the problematic line and it means that the request_firmware()
> call can't load the file BCM2033-MD.hex. Do you have installed the
> hotplug scripts and is the firmware.agent script present?

I have hotplug installed, and firmware.agent seems to be present 
in /etc/hotplug. The Gentoo packages I'm using are as follows:

hotplug-20040401
hotplug-base 20040401

Perhaps this was someone's idea of an April Fool's joke? These seem to 
be the most-recent versions avaliable in Gentoo, even in unstable.

Do I need CONFIG_FW_LOADER enabled in the Kernel? The help page states 
it's only needed where no in-kernel-tree modules require hotplug 
firmware loading support, so I figured it didn't apply to the Bluez 
stuff. It's compiled as a module at present, but perhaps this is the 
problem.

Cloney



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
