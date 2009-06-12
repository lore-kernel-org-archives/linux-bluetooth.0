Return-Path: <cyrus@holtmann.org>
Message-ID: <4A320683.7000103@suse.de>
Date: Fri, 12 Jun 2009 09:40:51 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add udev mode to bluetoothd
References: <1244741895.11069.1319.camel@cookie.hadess.net> <1244742638.27363.51.camel@violet>
In-Reply-To: <1244742638.27363.51.camel@violet>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
> Hi Bastien,
> 
>> As discussed on IRC.
>>
>> Still needed:
>> - patch to wait for the bus to startup in udev mode

Should we really do that? (What if the bus never appears?, how long should we
wait?)
The alternative (not overwhelmingly nice, I admit) would be to record
somewhere in the system that bluetoothd tried to start but could not due to
the missing bus and then start it "manually" by an init script that is
guaranteed to run after DBus is started.

I had patches for waiting for the bus long time ago and can dig them out if
wanted.

Best regards,

	Stefan
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
