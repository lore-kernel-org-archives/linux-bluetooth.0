Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41508DCF.3070308@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez users list <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] pairing with headset
References: <20040921190606.GA11925@cirrus.madduck.net>
In-Reply-To: <20040921190606.GA11925@cirrus.madduck.net>
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
Date: Tue, 21 Sep 2004 14:23:43 -0600

Hi

(I thought I should cc: to the list)

 > However, I cannot make bluez see it. What's more, if I pair phone
 > and headset (which also works), then `hcitool scan` does not find
 > the phone anymore. I have to delete the pairing between the headset
 > and the phone to be able to communicate with the phone again.


With my Motorola v710 and an ericsson h60(?) headset, I have to *turn 
off* the headset before I can connect the computer to the headset. You 
don't have to go through the pain of "re" pairing that way. Even when 
the headset is on but not being used to talk, it seems to have some kind 
of 'weak' connection there.

 > Also, I can't figure out how to pair the computer with the headset
 > (assuming that phone and headset are not paired). I set the voice
 > type to 0x0040 (not sure why, but I saw it on the Internet; it also
 > does not work with 0x0060, the default) and I added Audio and
 > Telephony to the dongle's classes; I even added the HF SDP service.
 > But when I execute `hcitool scan`, only the phone shows up.


we're experimenting with audio at 
http://sourceforge.net/projects/bluetooth-alsa/

i will update the cvs sources. currently, you'll have to stick with 
0x0060 (the default). currently, sound is jittery because it uses the 
headset connection to pace the output (it should be tied to a clock instead)

Brad


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
