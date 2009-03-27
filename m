Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1831784371.90681238186406345.JavaMail.root@mbv7.indiatimes.com>
References: <35c90d960903261839q500b755cuc75c40e96e973225@mail.gmail.com>
	<1831784371.90681238186406345.JavaMail.root@mbv7.indiatimes.com>
Date: Fri, 27 Mar 2009 13:43:33 -0700
Message-ID: <35c90d960903271343h542524d1y6a0188b29eb4f214@mail.gmail.com>
Subject: Re: a2dp connection of HT820 vs. BT620s
From: Nick Pelly <npelly@google.com>
To: pavan_savoy@indiatimes.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Mar 27, 2009 at 1:40 PM,  <pavan_savoy@indiatimes.com> wrote:
> Hey Nick,
>
> I did post this on the android-group as well, I mentioned I get a "write blocked for ** msecs" when audio gap occurs.
>
> Also, I tested Jabra with ubuntu's 3.16 bluez, it sounds funny [something to do with frequency, I suppose..],
> but no audio gap, basically same output as in Motorola head-set.
>
> Also please elaborate on what part of Android plug-in do you suspect ? I would want to take a look into it.

The audio metering code in liba2dp.c

Nick
