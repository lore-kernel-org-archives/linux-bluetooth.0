Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ] core/device: Make filtered discovery able to detect beacons
In-Reply-To: <1464347909-19738-1-git-send-email-luiz.dentz@gmail.com>
References: <1464347909-19738-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 27 May 2016 16:47:33 -0300
Message-ID: <8760tze10q.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes it possible to use SetDiscoveryFilter to disable checking
> discoverable flags making it possible to see beacons such as the ones
> create by tools/eddystone that doesn't show on regular discovery sessions
> since they are not discoverable/connectable.
> ---
> This is an alternative to core/device: Fix checking flags for
> non-connectable advertisements as it would not spam the UI trying to
> configure new devices with beacons and improve the filtered discovery
> to be more useful in regard of matching beacons.
>

I like this alternative better. I, too, dislike the idea of showing
non-connectable devices by default.


Cheers,
--
Vinicius
