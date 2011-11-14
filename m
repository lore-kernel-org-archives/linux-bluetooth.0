Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Nov 2011 21:17:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/2] Initial Time Profile implementation
Message-ID: <20111114191732.GB15156@fusion.localdomain>
References: <1320422368-23820-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320422368-23820-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Nov 04, 2011, Anderson Lizardo wrote:
> This initial implementation for Time Profile contains the mandatory Current
> Time Service (CTS), including the mandatory Current Time Characteristic and the
> optional Local Time Information Characteristic.
> 
> The only limitation is that notifications for the Current Time Characteristic
> value are not being sent yet. The mechanism to detect changes on the system
> time is platform specific, therefore we need more infrastructure to support
> this and allow multiple platform support.
> 
> Future patches will address this (and also make sure the notifications enabled
> by clients are persistent across reboots), and we will also introduce Reference
> Time Update Service (which also depends on platform specific mechanisms.)
> 
> This series depend on the "High level GATT API for service registration" series
> sent a while ago. Note that, despite the limitation explained above, we
> consider this code ready for upstream inclusion (it is mandatory for server to
> implement it, but not mandatory for the client to enable the notification, it
> can just read the current time on each connection.)

Applied. Thanks.

Johan
