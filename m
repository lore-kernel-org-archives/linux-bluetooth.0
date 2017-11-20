Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511187704.16347.17.camel@hadess.net>
Subject: Re: [PATCH BlueZ 2/2] device: Don't disable auto-connect for
 trusted devices
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Mon, 20 Nov 2017 15:21:44 +0100
In-Reply-To: <20171120134244.24548-2-luiz.dentz@gmail.com>
References: <20171120134244.24548-1-luiz.dentz@gmail.com>
         <20171120134244.24548-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2017-11-20 at 15:42 +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Trusted shall indicate if the device is allowed connect in any
> circumstance, even if the user has called device.Disconnect.

This fixes my Bluetooth LE mouse not being able to reconnect to the
computer at all after it was disconnected through a toggle switch,
requiring removing the pairing on the computer, and pairing it again.

But as the device is still able to disconnect, and the mouse just
considers the disconnect a transient transport problem, it will
reconnect straight away.

I might make some changes to the UI to make it clearer that we did
manage to disconnect, and that the device reconnected, otherwise it
looks like the switch didn't work.

So, +1 from me!
