Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4117B098.5020805@dark-reality.de>
References: <4117AB9A.9010909@dark-reality.de>
	 <1092071356.4564.12.camel@pegasus>  <4117B098.5020805@dark-reality.de>
Content-Type: text/plain
Message-Id: <1092073167.4564.26.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 09 Aug 2004 19:39:27 +0200

Hi Lars,

> | And as I said before, the best way is to extend the current SCO kernel
> | module with an ALSA interface, because the basic idea of snd-bt-sco is
> | wrong.
> 
> I think you are absolutly right, but can you explain a bit more what you
> have in mind? No code fragments or stuff, just how you think this might
> be structured and integrated best. I think you are the person who knows
> most about this topic.

I think the SCO driver should provide two interfaces. The first one we
know already is a socket interface to the SCO packets and the second
should handle the SCO packets directly over into an ALSA interface. May
you would like to switch between these two via an IOCTL, like we did it
for the RFCOMM layer.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
