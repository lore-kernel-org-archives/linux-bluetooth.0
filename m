Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1504785933.6911.64.camel@hadess.net>
Subject: Re: [PATCH] autopair: Don't handle the iCade
From: Bastien Nocera <hadess@hadess.net>
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>,
        linux-bluetooth@vger.kernel.org
Date: Thu, 07 Sep 2017 14:05:33 +0200
In-Reply-To: <973c2ecf-7916-b070-bbe5-1b92f7565b8c@jp.fujitsu.com>
References: <20170904175446.4798-1-hadess@hadess.net>
         <973c2ecf-7916-b070-bbe5-1b92f7565b8c@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-09-07 at 16:46 +0900, ERAMOTO Masaya wrote:
> Hi Bastien,
> 
> On 09/05/2017 02:54 AM, Bastien Nocera wrote:
> > We can't easily enter digits other than 1 through 4 (inclusive)
> > so leave it up to the agent to figure out a good passcode
> > for the iCade.
> > 
> > Note that we can not use the VID/PID of the device, as it is not
> > yet known at that point.
> 
> Does not the device class of iCade include its unique value or a
> value 
> for similar devices?

No, the iCade is configured as a keyboard so it can be paired with
Apple iOS devices which only recognise keyboards. Each keypress and key
release is a separate keyboard key press/release.

In mainline Linux, you can find the hid-icade driver that'll take care
of transforming those key presses and key releases into joypad events:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-icade.c

As we don't want the autopair keyboard to generate impossible to "type"
numbers, we need to do this somewhere else. It's done in gnome-
bluetooth's pairing agent as the device was deemed too niche to have
this handled in bluez. We still need the quirk however.
