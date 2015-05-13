Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: carlo.caione@gmail.com
In-Reply-To: <86BBEE97-B28B-429A-8D13-AE41D7BC37A0@holtmann.org>
References: <1431100652-3658-1-git-send-email-carlo@caione.org>
	<86BBEE97-B28B-429A-8D13-AE41D7BC37A0@holtmann.org>
Date: Wed, 13 May 2015 23:51:45 +0200
Message-ID: <CAOQ7t2Z=u=GyWNdAZd=v4AQ4nE7TvXwQ4KgR4GteNrHngrp=eg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btrtl: Create separate module for Realtek BT driver
From: Carlo Caione <carlo@caione.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Carlo Caione <carlo@caione.org>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
	larry.finger@lwfinger.net, champion_chen@realsil.com.cn,
	Daniel Drake <drake@endlessm.com>, Carlo Caione <carlo@endlessm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, May 13, 2015 at 10:56 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Carlo,

Hi Marcel,

>> As already done for btintel and btbcm export setup as separate function
>> in a vendor-specific module to hold all the Realtek specific commands.

[cut]

I'll fix everything in v2.

>> +MODULE_AUTHOR("Carlo Caione <carlo@endlessm.com>");
>> +MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
>
> I think you mean Realtek and not Intel ;)

Yep, also I guess Daniel still owns the authorship of the module.
Sorry, added my name without thinking (was in 'auto-mode' :)

[cut]

> The rest seems to be fine and straight forward.

Thanks for the review,

-- 
Carlo Caione
