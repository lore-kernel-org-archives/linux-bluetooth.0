Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] News: Stereo BT Headset from BlueTake
From: Marcel Holtmann <marcel@holtmann.org>
To: Brad Midgley <bmidgley@xmission.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <416EE163.1050605@xmission.com>
References: <416D8520.5060102@thomae-privat.de>
	 <416DA635.2070105@xmission.com> <1097741691.4640.19.camel@notepaq>
	 <416E8560.3070801@xmission.com> <1097762684.4640.49.camel@notepaq>
	 <416EE163.1050605@xmission.com>
Content-Type: text/plain
Message-Id: <1097927962.4911.16.camel@pegasus>
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
Date: Sat, 16 Oct 2004 13:59:22 +0200

Hi Brad,

> I must not have understood the distinction. I've seen stuff 
> (http://www.ericsson.com/bluetooth/files/newsletter5_0403_lores.pdf) 
> that suggests 1.2 brings with it higher-quality audio through new 
> profiles (A2DP, AVRCP, GAVDP) and stuff 
> (http://www.wordiq.com/definition/Bluetooth#Bluetooth_1.2) that says it 
> gives us better transfer heuristics (eSCO).
> 
> Are the profiles purely a function of the software stack? What about eSCO?

I checked the articles above and no one said, that you need Bluetooth
1.2 for A2DP. It might be confusing, but A2DP uses the ACL data link for
high quality audio and not SCO/eSCO links like the headset/handsfree or
cordless telephony/intercom profiles.

> I'd love to hear that the 1.1 adapter hardware is not being obsoleted by 
> 1.2. I don't mind having to get a new headset like the bluetake.

Everything should be backward compat as long as it based on the ACL data
links. If you like, you can use a Bluetooth 1.0b device like the old
Nokia DTL-1 Bluetooth card.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
