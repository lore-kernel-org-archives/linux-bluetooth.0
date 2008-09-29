Return-Path: <cyrus@holtmann.org>
Message-ID: <48E1004F.20605@suse.de>
Date: Mon, 29 Sep 2008 18:20:31 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluez-gnome: how to turn adapter off?
References: <48E0FB63.4000601@suse.de> <1222704357.3311.87.camel@cookie.hadess.net>
In-Reply-To: <1222704357.3311.87.camel@cookie.hadess.net>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
> On Mon, 2008-09-29 at 17:59 +0200, Stefan Seyfried wrote:
>> Hi,
>>
>> I now got several bugreports from people searching for the button to turn
>> their bluetooth device off in the bluetooth-applet. I seem to remember that
>> there was the setting "off" (in addition to "Hidden", "Always visible",
>> "Temporary visible") in previous versions. So what's the rationale for
>> removing it (users seem to expect to find it there)? And if I remember
>> incorrectly: could we place such a button there?
> 
> There was never an "off" switch. There was:
> - Other devices can connect
> - Visible and connectable for other devices
> - Limited discoverable and connectable
> 
> The last 2 were folded into a single option.

Ok, so I remembered wrong ;-) How about adding a "disable this adapter"
option? Would a patch that implements this be welcome?
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
