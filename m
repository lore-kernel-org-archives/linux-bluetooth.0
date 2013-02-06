Return-Path: <cyrus@holtmann.org>
Message-ID: <1360137464.15783.7.camel@aeonflux>
Subject: Re: [PATCH 2/2] adapter: Set default adapter id sooner
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 06 Feb 2013 09:57:44 +0200
In-Reply-To: <1360098656-12488-2-git-send-email-szymon@janc.net.pl>
References: <1360098656-12488-1-git-send-email-szymon@janc.net.pl>
	 <1360098656-12488-2-git-send-email-szymon@janc.net.pl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> When first adapter is registered set it as default before probing
> drivers or profiles as those might depend on that e.g. hostname.
> 
> This fix hostname plugin setting default adapter name to 'foo #1'
> instead of 'foo' if pretty hostname was received before probing
> adapter drivers.

you find an issue that I meant to fix, but never got around so far. So I
do not like the magic default_adapter_id global variable.

I would prefer if we add a is_default or similar variable to btd_adapter
and make it change if one adapter goes away.

Regards

Marcel


