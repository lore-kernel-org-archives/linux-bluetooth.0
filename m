Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluez-gnome: Fix crash on pairing request of known
 rfcomm device
From: Bastien Nocera <hadess@hadess.net>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1252595415.3430.17.camel@hammer.suse.cz>
References: <1252595415.3430.17.camel@hammer.suse.cz>
Content-Type: text/plain
Date: Thu, 10 Sep 2009 16:21:44 +0100
Message-Id: <1252596104.23937.1329.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2009-09-10 at 17:10 +0200, Stanislav Brabec wrote:
> Attached patch fixes crash after access attempt to the device configured
> in rfcomm.conf, but not yet paired.
> 
> How to reproduce:
> 
> 1. Configure an unknown RFCOMM device that requires authentication in
>    rfcomm.conf (e. g. mobile phone).
> 2. run pppd on /dev/rfcomm1
> 
> Behavior:
> - Pairing request on mobile phone
> - Crash of bluetooth-applet on desktop
> 
> The patch fixes only the crash, not the error completely (at least in
> version 1.8). Behavior after the fix:
> - Pairing request on mobile phone, then ask for PIN
> - No reaction on desktop

Fixed the same bug in gnome-bluetooth.

Cheers

