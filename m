Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <427EF21A.7040908@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: Florian Echtler <echtler@fs.tum.de>, bluez-devel@lists.sourceforge.net
References: <Pine.LNX.4.62.0505052044560.10038@block> <427A8B7F.1010105@xmission.com> <Pine.LNX.4.62.0505062220440.10201@block>
In-Reply-To: <Pine.LNX.4.62.0505062220440.10201@block>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: [Bluez-devel] Re: some btsco hacks
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 08 May 2005 23:16:10 -0600

Florian

> I noticed that there was a small bug left in my patch (the value of
> force_sco was overwritten when a reconnect was requested). This small
> additional patch should fix that.

ok, applied.

> Well, my .btscorc currently looks like this:
> 
> AT\+CKPD=200
> sco-toggle on off
> AT\+CKPD=200
> system /home/echtler/bin/headset %d &
> 
>>do you know what the syntax of 'back references' is in .btscorc?
> 
> Back references to what/where?

backrefs are parts of the regexp surrounded by (). the matching 
expression is remembered and can be placed in the command string, by \0 
\1 etc it turns out.

I figured them out & noted in the docs.

In keeping with \0 \1 for backrefs in the regexp and \p for pid, the 
headset state should be \s instead of %d. Would you be willing to make 
that change (or I could)?

thanks
Brad


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
