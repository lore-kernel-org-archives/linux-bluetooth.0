Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <961904947d3f021b8ed4f7a00dc1241761974060.camel@hadess.net>
Subject: Re: [PATCH v2 3/5] client: Add scan.discoverable command
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jul 2018 12:21:15 +0200
In-Reply-To: <20180730064424.13996-3-luiz.dentz@gmail.com>
References: <20180730064424.13996-1-luiz.dentz@gmail.com>
         <20180730064424.13996-3-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2018-07-30 at 09:44 +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds discoverable command to scan menu which can be used to set
> if adapter should become discoverable while scanning:
> 
> [bluetooth]# scan.discoverable on
> [bluetooth]# scan on
> SetDiscoveryFilter success
> [CHG] Controller XX:XX:XX:XX:XX:XX Discoverable: yes
> Discovery started
> [CHG] Controller XX:XX:XX:XX:XX:XX Discovering: yes
> [bluetooth]# scan off
> Discovery stopped
> [CHG] Controller XX:XX:XX:XX:XX:XX Discoverable: no

This doesn't call SetDiscoverFilter() when the scan as already started,
meaning that my earlier test still fails.

> As mentioned on IRC, this does not work if the Discoverable filter is
> set after the discovery has started. So:
> discoverable off
> scan on
> scan.discoverable on
> show <- this will show "Discoverable" still off.

Doing a quick "scan off" / "scan on" will show "SetDiscoveryFilter
success" appearing, this should also appear when the filter is changed
while scanning is on-going.

If you don't want to change the currently filter, it might be good for
the client to show a "Filter change queued" or similar message that
would show that the setting hasn't been applied, but would be for the
next run.

Cheers
