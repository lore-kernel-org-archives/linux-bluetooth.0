Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Aug 2010 16:33:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Maemo6 MCE: listen to adapter mode changes
Message-ID: <20100817133344.GA14727@jh-x301>
References: <AANLkTim2ni6aE3-9Rx+HGeFFmmG-by6PMh4zgrJFnk-m@mail.gmail.com>
 <AANLkTimpogcSN1eKO9A2aWB1aB7YNZSRD7f-vGMvma9q@mail.gmail.com>
 <20100817103051.GA29845@jh-x301>
 <AANLkTikfG3Beawf-kguknYcz-T8WXL9hk9H_D9N35=SS@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikfG3Beawf-kguknYcz-T8WXL9hk9H_D9N35=SS@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Tue, Aug 17, 2010, Daniel Örstadius wrote:
> Corrected in the attached patch.
> 
> /Daniel

> From 263f53fe9cddd9fe9c8c8d4e8265cfbbe3f8c37e Mon Sep 17 00:00:00 2001
> From: Daniel Orstadius <daniel.orstadius@nokia.com>
> Date: Tue, 17 Aug 2010 15:48:45 +0300
> Subject: [PATCH] Maemo6 MCE: listen to adapter powered state
> 
> Registers a callback to btd_adapter to get notified when the
> powered state of the adapter is changed. This is needed to update
> the state stored in the MCE if the adapter is powered on or off
> using for example SetProperty(Powered). The current setting of
> the MCE is saved in a variable and if the notification to the
> plugin does not match this value the MCE is updated accordingly
> using its DBus method for setting radio states.
> ---
>  plugins/maemo6.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 48 insertions(+), 2 deletions(-)

Thanks. This patch is now also upstream.

Johan
