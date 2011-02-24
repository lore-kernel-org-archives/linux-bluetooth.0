Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Feb 2011 16:42:48 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Westerlund <dwesterl@cc.hut.fi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Maemo6 MCE: skip first adapter_powered callback
Message-ID: <20110224194248.GA28774@jh-x301>
References: <AANLkTinzSuO8a87BuqAxakQS5=pd9zRd7zdmBasjXrxs@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinzSuO8a87BuqAxakQS5=pd9zRd7zdmBasjXrxs@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> From: Daniel Orstadius <daniel.orstadius@nokia.com>
> Date: Thu, 24 Feb 2011 13:45:33 +0200
> Subject: [PATCH] Maemo6 MCE: skip first adapter_powered callback
> 
> The maemo6 MCE plugin should be used with the flag InitiallyPowered
> in main.conf set to 'true' so that BlueZ powers on the adapter
> and leaves it in that state when the daemon is started. The plugin
> will read the radio state from the MCE and set the state
> accordingly. The maemo6 plugin is a btd_adapter_driver and those
> drivers are loaded after BlueZ has read the BD address etc from the
> adapter.
> 
> This patch adds a boolean flag in the callback to ignore the initial
> powering on of the adapter by BlueZ, since it shouldn't be
> propagated to the MCE. With InitiallyPowered set to 'false' the
> adapter_powered callback is not called when the adapter is turned
> on at BlueZ startup, which is why this wasn't implemented before.
> ---
>  plugins/maemo6.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

This patch has been pushed upstream. Thanks.

Johan
