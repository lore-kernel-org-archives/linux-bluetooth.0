Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <fcc18fe9c3f4430df4699a248465cf62e3a3a390.camel@hadess.net>
Subject: Re: [PATCH v2 1/5] doc/adapter-api: Add Discoverable option to
 SetDiscoveryFilter
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jul 2018 12:21:13 +0200
In-Reply-To: <20180730064424.13996-1-luiz.dentz@gmail.com>
References: <20180730064424.13996-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2018-07-30 at 09:44 +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This enables the client to set its discoverable setting while
> discovering which is very typical situation as usually the setings
> application would allow incoming pairing request while scanning, so
> this would reduce the number of calls setting Discoverable and
> DiscoverableTimeout and restoring after done with discovery.

This seems to take into account the changes in filters (though
SetDiscoveryFilter) that happen while discovery is running, so the
gnome-bluetooth branch works as expected:
https://gitlab.gnome.org/GNOME/gnome-bluetooth/merge_requests/1

There still might be a problem in a later patch for bluetoothctl.
