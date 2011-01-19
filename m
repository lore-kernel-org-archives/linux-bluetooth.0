Return-Path: <cyrus@holtmann.org>
Subject: Re: -DG_DISABLE_DEPRECATED and g_io_channel_*()
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1295377703.1774.6.camel@ubuntuLab1>
References: <1295377703.1774.6.camel@ubuntuLab1>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 Jan 2011 12:25:12 +0100
Message-ID: <1295436312.3873.240.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> There appears to be a number of deprecated g_io_channel_* functions
> being called from the bluez tip, which are breaking the build due to
> Marcel's latest commit today:
> 
> commit effe770cd43cf53fa5842291941dbfc82beab645
> Author: Marcel Holtmann <marcel@holtmann.org>
> Date:   Tue Jan 18 14:56:31 2011 +0100
> 
>     Use -DG_DISABLE_DEPRECATED compiler define
> 
> 
> Should this commit be backed out until these deprecated usages have been
> fixed, or is this the general way that the issue is forced?
> 
> Obviously deprecated functions should not be used, but it creates an
> unbuildable bluez in the meantime.

I broke it on purpose to draw some attention to this ;)

Regards

Marcel


