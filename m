Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42790802.9080009@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluetooth audio control
References: <20050504162039.63928.qmail@web54706.mail.yahoo.com>
In-Reply-To: <20050504162039.63928.qmail@web54706.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 04 May 2005 11:36:02 -0600

Hiren,

This has been missing from the docs. I added it, but here it is as well:

     *  Put alternating lines of regexes and shell commands in 
~/.btscorc and when something that the headset sends matches these 
regexes, the shell command is run (with any back references replaced). 
This, of course, is primarily intended to "do stuff" when the headset 
button(s) are pressed.
     * Send SIGHUP to the userspace program to make it re-read the 
config file.
     * Send SIGUSR1 to the userspace program to make the headset ring.

If anyone has examples of .btscorc lines that do things like start and 
stop a recording, I'd like to add it to the docs.

Brad

Hiren Mandalia wrote:
> hi all,
> 
> i have the btsco installed and working with my Motorola headset HS850.
> I'm able to play audio from a linux machine to the headset. I'm looking
> for a program that will start/stop audio playback/record only when I
> press the 'Connect' button on my headset. does handsfree profile
> implement this functionality?
> 
> thanks,
> hiren
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam? Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> 


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
