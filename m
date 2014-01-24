Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <41458C64-3510-481A-92F4-1296C06600CC@warski.org>
References: <41458C64-3510-481A-92F4-1296C06600CC@warski.org>
Date: Fri, 24 Jan 2014 10:38:58 -0400
Message-ID: <CAJdJm_PFAWLvBQFXOntGu+sA7-vGuVRx5956OL3CD8QjmqZiEA@mail.gmail.com>
Subject: Re: Discovering LE advertisements programatically
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Adam Warski <adam@warski.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

On Fri, Jan 24, 2014 at 10:15 AM, Adam Warski <adam@warski.org> wrote:
> I’m trying to find a good way to discover and retrieve LE advertisements programatically.
>
> My first shot was to try to use DBus. I was trying to extend what the test/test-discovery script is doing, but it seems using DBus I can only get notified of new devices being discovered. Is there a way to get the actual LE advertisement via DBus? The device properties seem not to contain the info from the advertisement PDU.
>
> If that’s not possible using DBus, is the way to go just using C?
>
> I also tried using command line, a combination of “hcitool lescan” and “hcidump”/“hcidump -R" gives what I need more or less (plain hcidump gives me the RSSI, hcidump -R gives me the raw packet that I need). Still, I guess there must be a better way.

My suggestion would be to take a look at "hcitool lescan" for how it
is done using C sockets. Or you can modify hcitool lescan to dump the
full advertising report instead of just the name.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
Manaus - Brazil
