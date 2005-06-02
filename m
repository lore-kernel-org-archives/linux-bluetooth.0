Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Newbie Question: Setting 2 BT Mice to specific
	/dev/input/mouse* files
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050602164634.85367.qmail@web26108.mail.ukl.yahoo.com>
References: <20050602164634.85367.qmail@web26108.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1117735838.13834.18.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 02 Jun 2005 20:10:38 +0200

Hi Rodrigo,

> (I'm in a Vanilla kernel, 2.6.11-mh2 patch, with the
> Logitech DiNovo USB HUB in HCI mode with 2 IOGEAR mini
> mice)
> 
> I'm working on a project that uses 2 BT Mice
> simultaneously. They don't perform the same functions
> (core pointer control, ex.) each one has a specific
> interaction function associated. In order to deal with
> these two mice separately, I've to write in my
> XF86Config file like this:
> 
>   Option       "Device" "/dev/input/mouse1"
> and
>   Option       "Device" "/dev/input/mouse2"
> 
> rather than:
>   Option       "Device" "/dev/input/mice"
> and
>   Option       "Device" "/dev/input/mice"
> 
> The problem for me is that bluetooth mice seems to
> behave differently than other mice. They'll not keep
> on the same /dev/input/mouse* during all the use time,
> but they will change from the /dev/input/mouse2 to
> /dev/input/mouse3, for example.
> 
> I've searched in this mail list for related problems
> with no success. I've also read some HOTPLUG tutorials
> and FAQs but I haven't found anywhere yet containing
> clues to the way that this dev files are picked.
> 
> Does anyone knows some pointer or FAQ to these issues
> of DEV files or a clue for why BlueZ works like this?

they will disconnect and reconnect and then the device nodes might
change. You may can use udev to get stable device names, but this is a
question for the input subsystem gurus. I don't know if this is already
supported.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
