Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [Fwd: Re: [Asterisk-Dev] New Bounty: Bluetooth
	Phone Support]
From: Marcel Holtmann <marcel@holtmann.org>
To: jbarre <jbarre@biarritx.dyndns.org>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <415C4A11.8070903@biarritx.dyndns.org>
References: <415C4A11.8070903@biarritx.dyndns.org>
Content-Type: text/plain
Message-Id: <1096617904.5403.11.camel@notepaq>
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
Date: Fri, 01 Oct 2004 10:05:04 +0200

Hi Jerome,

> The Asterisk-Dev list is talking about bt... ounce again...
> 
> Since I'm (really) not an expert in this kind of stuff, I would like to 
> have your opinion.
> 
> Here is a copy of my last reply to this list.
> 
> Note: I'm not in the bluez-devel list. Too much mail... :-(
> 
> Please don't forget to add my email address to your reply.

as long as there are no mobile phones with cordless telephony (CTP)
support I think it makes no sense to think about the integration into a
PBX. You will be hit by the restrictions of the headset/handsfree
profiles, because they are designed for a different approach. However,
what you first need is correct ALSA-SCO-Bluetooth integration.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
