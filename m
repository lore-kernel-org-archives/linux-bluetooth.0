Return-Path: <cyrus@holtmann.org>
Message-ID: <5310BFEF.8010405@gmx.net>
Date: Fri, 28 Feb 2014 17:57:19 +0100
From: Tobias Jakobi <liquid.acid@gmx.net>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [bluez-5.14] connect fails with 'org.bluez.Error.NotAvailable'
References: <530FBB6B.8080300@gmx.net> <CAJdJm_P9FD+NwSAfG=1bWg0Ep2Ku7eTqwpLN2aX6p5-+rc=3sA@mail.gmail.com>
In-Reply-To: <CAJdJm_P9FD+NwSAfG=1bWg0Ep2Ku7eTqwpLN2aX6p5-+rc=3sA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson Lizardo wrote:
> Looks like you are missing a "power on" on the server side. Notice
> that the client side shows "Powered: yes" on the info command.
> 
> Best Regards,
> 
Hello Anderson!

Sadly this doesn't solve the issue. The BT device on the server side is
already powered on. Otherwise I wouldn't be able to establish the
connection with the Android smartphone in the first place.

With best wishes,
Tobias

