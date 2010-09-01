Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Sep 2010 21:49:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Get IEEE1284 for a single printer
Message-ID: <20100901184902.GA30041@jh-x301>
References: <1275849744.7994.38.camel@localhost.localdomain>
 <20100608070935.GA22068@jh-x301>
 <1275988881.2458.12112.camel@localhost.localdomain>
 <20100608092621.GA8254@jh-x301>
 <1283351741.2361.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283351741.2361.19.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Wed, Sep 01, 2010, Bastien Nocera wrote:
> From: Bastien Nocera <hadess@hadess.net>
> Date: Sun, 6 Jun 2010 15:48:26 +0100
> Subject: [PATCH] (cups) Add ability to print IEEE1284 device ID
> 
> Add ability to print IEEE1284 device ID for Bluetooth
> printers to allow auto-configuration once paired.
> ---
>  cups/main.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 83 insertions(+), 0 deletions(-)

Thanks for the updated patch. It's now pushed upstream.

> I've only fixed the style problems in the patch itself. I'm happy to do
> the rest of the file, if you have a "indent" magic incantation for it.

In my experience indent can produce quite a mess compared to fixing
style issues manually. Anyway, I went ahead and did the cleanup myself
for the issues that I could quickly spot and pushed the fixes as a
separate patch upstream.

Johan
