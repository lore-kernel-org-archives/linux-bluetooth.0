Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pm-325 help, anyone aside from marcel?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050407160939.51153.qmail@web50705.mail.yahoo.com>
References: <20050407160939.51153.qmail@web50705.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1112891952.9047.90.camel@pegasus>
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
Date: Thu, 07 Apr 2005 18:39:12 +0200

Hi John,

> I was wondering if anyon else could help me with
> getting the bluetooth for DUN/com port emulation
> working in linux, as I have it in XP, with LG PM-325
> phone?  An rfcomm device cannot be created with it,
> saying connection refused(presumably due to wrong
> channel?).  I have repeatedly responded to marcel's
> questioning on the issue, but he seems to have decided
> to start ignoring me all of the sudden, after asking
> me several questions about my issue.  I have emailed
> him personally and asked if there's any other
> information I could provide him that would help
> resolve my issue, but all in vain.

as I already told you, you need to choose the right RFCOMM channel for
the dialup networking or serial port profile. After that call

	rfcomm bind 0 <bdaddr> <channel>

and /dev/rfcomm0 is working like any other serial port. The hcidump
always showed that you used the wrong channel number.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
