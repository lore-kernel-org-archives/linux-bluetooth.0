Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Simone Gotti <simone.gotti@email.it>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Compile bluez-bluefw-1.0 fails
Cc: Alex Holland <ah160@student.cs.york.ac.uk>
References: <200404182321.55431.dvornheder@t-online.de> <1082391148.4403.57.camel@pegasus> <200404191822.46586.ah160@student.cs.york.ac.uk>
In-Reply-To: <200404191822.46586.ah160@student.cs.york.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404191952.11018.simone.gotti@email.it>
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
Date: Mon, 19 Apr 2004 19:52:11 +0200

Hi,

On Monday 19 April 2004 19:22, Alex Holland wrote:
> On Monday 19 Apr 2004 17:12, Marcel Holtmann wrote:
> > so far so good. Everything seems to look fine, but actually the
> > bcm203x driver can't load the BCM2033-MD.hex firmware file from the
> > userspace. Add some debugging lines to firmware.agent to see if it
> > got really called by the hotplug system.
>
> I wasn't quite sure how to do this, but I tried adding this to the start
> of the firmware.agent file (after the header, before the code):
>
> echo "Now in firmware.agent"
>
> This didn't appear during the boot sequence, and doesn't appear in
> dmesg, so I assume the firmware.agent isn't being called.
>
> Any suggestions, or is this now a Hotplug problem? If it is, could you
> tell me how to phrase it as a question for the Hotplug mailing list?
>
> Alex Holland

In /etc/hotplug/firmware.agent there's a commented line like this

# DEBUG=yes export DEBUG

remove the #  and you'll see a lot of debug informations.


Bye!
-- 
Simone Gotti
<simone.gotti@email.it>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
