Return-Path: <cyrus@holtmann.org>
Message-ID: <1340100781.32164.1.camel@sirocco.config>
Subject: Re: [PATCH BlueZ] input: Fix not adding watches when io channel is
 connected
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 19 Jun 2012 12:13:01 +0200
In-Reply-To: <1340100156-19124-1-git-send-email-luiz.dentz@gmail.com>
References: <1340100156-19124-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Em Tue, 2012-06-19 às 13:02 +0300, Luiz Augusto von Dentz escreveu:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This can leave dangling pointers in case one of the channel is never
> connected which cause -EALREADY to be returned by
> input_device_set_channel next time the device attempts to connect.

This removes the warning when the PS3 BD Remote tries to connect, but
doesn't fix the original problem. Probably something to include
nonetheless.

Cheers

