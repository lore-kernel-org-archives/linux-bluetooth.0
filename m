Return-Path: <cyrus@holtmann.org>
From: <aji.kumar@accenture.com>
To: <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: executing GetFolder Items leaves the session disconnected
Date: Mon, 1 Jul 2013 18:00:32 +0000
Message-ID: <558B77349A98DB438591B5FD930034092638D4A8@048-CH1MPN1-142.048d.mgd.msft.net>
References: <1372243017-1461-1-git-send-email-luiz.dentz@gmail.com>
 <20130626104156.GA28255@x220.ger.corp.intel.com>
In-Reply-To: <20130626104156.GA28255@x220.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan/Luiz,

I am currently involved in testing bluez for avrcp 1.4 controller roles with phones that support avrcp 1.4, but currently I am running out of luck..

Please help with the below questions?

        Does bluez have support for avrcp 1.4 controller role??

        If yes, How do we test bluez for 1.4 controller role with a phone that has implemented avrcp 1.4

By going through the "doc" it looks like that we need to get "<variable_path>/dev_bd_address/playerid" object path first to do any browsing and searching activities, why does this appear after a "source" and "control" connection with the device under test??

Is there any steps that is missing here?

With thanks and regards
Aji.






This message is for the designated recipient only and may contain privileged, proprietary, or otherwise confidential information. If you have received it in error, please notify the sender immediately and delete the original. Any other use of the e-mail by you is prohibited.

Where allowed by local law, electronic communications with Accenture and its affiliates, including e-mail and instant messaging (including content), may be scanned by our systems for the purposes of information security and assessment of internal compliance with Accenture policy.

______________________________________________________________________________________

www.accenture.com

