Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <c2af6e7ef9add1c109c25c02887e08334b05479d.camel@hadess.net>
Subject: Re: [PATCH BlueZ 2/5] adapter: Discovery filter discoverable
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Fri, 27 Jul 2018 16:13:08 +0200
In-Reply-To: <20180726141723.20199-2-luiz.dentz@gmail.com>
References: <20180726141723.20199-1-luiz.dentz@gmail.com>
         <20180726141723.20199-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2018-07-26 at 17:17 +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This implements the discovery filter discoverable and tracks which
> clients had enabled it and restores the settings when the last client
> enabling it exits.

As mentioned on IRC, this does not work if the Discoverable filter is
set after the discovery has started. So:
discoverable off
scan on
scan.discoverable on
show <- this will show "Discoverable" still off.

Once this works, I'll re-test and push this patch to gnome-bluetooth
which uses the new functionality when available:
https://gitlab.gnome.org/GNOME/gnome-bluetooth/merge_requests/1
