Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Disabling HID Boot Protocol
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian Echtler <echtler@fs.tum.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0410241829170.12604@block.bubble>
References: <Pine.LNX.4.61.0410241307180.7693@block.bubble>
	 <1098618588.6465.5.camel@pegasus>
	 <Pine.LNX.4.61.0410241829170.12604@block.bubble>
Content-Type: text/plain
Message-Id: <1098676850.6465.76.camel@pegasus>
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
Date: Mon, 25 Oct 2004 06:00:50 +0200

Hi Florian,

> > > I'm using a MS Bluetooth Optical Desktop and would like to
> > > use the hotkeys again. I have kernel 2.6.8.1-mh1 and bluez-utils
> > > 2.10.. According to the mailing list archives, this version of 
> > > hidp.ko should already support report mode, however, I couldn't
> > > find any description on how to enable it. I suppose it's necessary
> > > to pass the correct "-b <subclass>" parameter to hidd?
> > the subclass parameter is only for overriding the value if the SDP
> > records are wrong. Check with hidd and if it tells you something about
> > boot mode then you are in boot mode, otherwise it uses report mode
> > automaticly. So what does "hidd --show" say?
> 
> [root@block:~][0] $ hidd --show
> 00:50:F2:7E:DF:AE Microsoft Five Button Mouse [045e:007c] connected 
> 00:50:F2:80:47:83 Microsoft Bluetooth keyboard [045e:007b] connected 

your two devices are using the report mode, otherwise you won't even see
their names and VID:PID.

> However, still no reaction from the multimedia keys, at least none
> in hcidump. Perhaps I should try 2.6.9-mh1?

You see nothing in hcidump, when you press them? That is strange. What
are the first HIDP messages for the keyboard in hcidump?

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
