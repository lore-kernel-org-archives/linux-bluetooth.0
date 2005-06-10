Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050610172528.41608.qmail@web26105.mail.ukl.yahoo.com>
From: Rodrigo Almeida <rodrigoalmeida_fr@yahoo.fr>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Re: Re: Newbie Question: Setting 2 BT Mice to specific /dev/input/mouse* files
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 10 Jun 2005 19:25:28 +0200 (CEST)

>   Hi Rodrigo,
>  
>  > (I"m in a Vanilla kernel, 2.6.11-mh2 patch, with
> the
>  > Logitech DiNovo USB HUB in HCI mode with 2 IOGEAR
> mini
>  > mice)
>  > 
>  > I"m working on a project that uses 2 BT Mice
>  > simultaneously. They don"t perform the same
> functions
>  > (core pointer control, ex.) each one has a
> specific
>  > interaction function associated. In order to deal
> with
>  > these two mice separately, I"ve to write in my
>  > XF86Config file like this:
>  > 
>  >   Option       "Device" "/dev/input/mouse1"
>  > and
>  >   Option       "Device" "/dev/input/mouse2"
>  > 
>  > rather than:
>  >   Option       "Device" "/dev/input/mice"
>  > and
>  >   Option       "Device" "/dev/input/mice"
>  > 
>  > The problem for me is that bluetooth mice seems
> to
>  > behave differently than other mice. They"ll not
> keep
>  > on the same /dev/input/mouse* during all the use
> time,
>  > but they will change from the /dev/input/mouse2
> to
>  > /dev/input/mouse3, for example.
>  > 
>  > I"ve searched in this mail list for related
> problems
>  > with no success. I"ve also read some HOTPLUG
> tutorials
>  > and FAQs but I haven"t found anywhere yet
> containing
>  > clues to the way that this dev files are picked.
>  > 
>  > Does anyone knows some pointer or FAQ to these
> issues
>  > of DEV files or a clue for why BlueZ works like
> this?
>  
>  they will disconnect and reconnect and then the
> device nodes might
>  change. You may can use udev to get stable device
> names, but this is a
>  question for the input subsystem gurus. I don"t
> know
> if this is already
>  supported.
>  
>  Regards
>  
>  Marcel
> 

Thanks for the tip, Marcel.
Udev is indeed the right way.

Fore those interested, I've found a nice FAQ
explaining how to integrate a PERL script for setting
the right dev file names:

http://www.redhat.com/magazine/002dec04/features/udev/

Anyway, after thinking and searching a lot about this
problem there's still a Bluetooth issue that maybe
someone has some info that I couldn't get:

Trough udev I may query a device to get its serial
number and other kinds of info. Unfortunately that
won't work for BT devices. With BT devices if one
types:
 
"udevinfo -a -p /sys/class/input/mouse2"

knowing that mouse2 is my BT Mouse, one will get only
the major and minor class of the mouse's dev file. The
system has no ways for knowing which dev file
corresponds to a specific BT Mouse. However BD
Adresses makes BT Devices individual.

Anyone has an idea for getting the BD address of a
specific input device? I mean, not using scan methods
as "hcitool -inq" or "hcitool -scan"... Or maybe some
scan method that shows which dev name the kernel used
for naming this device...

Thanks for any kind of idea,
Regards, Rodrigo
ps: Sorry for not replying in the original thread, I
wasn't able to do it.


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
