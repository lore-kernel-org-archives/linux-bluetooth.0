Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <558B77349A98DB438591B5FD930034092638D4A8@048-CH1MPN1-142.048d.mgd.msft.net>
References: <1372243017-1461-1-git-send-email-luiz.dentz@gmail.com>
	<20130626104156.GA28255@x220.ger.corp.intel.com>
	<558B77349A98DB438591B5FD930034092638D4A8@048-CH1MPN1-142.048d.mgd.msft.net>
Date: Mon, 1 Jul 2013 22:26:42 +0300
Message-ID: <CABBYNZK4V5rEsWmTG6eyQVvB3b0rzKwFU87QD0BCNXwC1SUBPg@mail.gmail.com>
Subject: Re: executing GetFolder Items leaves the session disconnected
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: aji.kumar@accenture.com
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Aji,

On Mon, Jul 1, 2013 at 9:00 PM,  <aji.kumar@accenture.com> wrote:
> Hi Johan/Luiz,
>
> I am currently involved in testing bluez for avrcp 1.4 controller roles with phones that support avrcp 1.4, but currently I am running out of luck..
>
> Please help with the below questions?
>
>         Does bluez have support for avrcp 1.4 controller role??
>
>         If yes, How do we test bluez for 1.4 controller role with a phone that has implemented avrcp 1.4

You can use our command line tool under tools/bluetooth-player or use
tools/mpris-player to emulate a MPRIS player in the system and then
control it using MPRIS clients.

> By going through the "doc" it looks like that we need to get "<variable_path>/dev_bd_address/playerid" object path first to do any browsing and searching activities, why does this appear after a "source" and "control" connection with the device under test??

We need to discover the players as per 1.4 it is possible to have more
than one with different capabilities and you most likely would not be
able to do anything without being connected so at this point I not
really following about control connection because you can't really
connect the browsing channel without it.

> Is there any steps that is missing here?
>
> With thanks and regards
> Aji.
>
>
>
>
>
>
> This message is for the designated recipient only and may contain privileged, proprietary, or otherwise confidential information. If you have received it in error, please notify the sender immediately and delete the original. Any other use of the e-mail by you is prohibited.
>
> Where allowed by local law, electronic communications with Accenture and its affiliates, including e-mail and instant messaging (including content), may be scanned by our systems for the purposes of information security and assessment of internal compliance with Accenture policy.
>
> ______________________________________________________________________________________
>
> www.accenture.com
>



--
Luiz Augusto von Dentz
