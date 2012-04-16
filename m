Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Apr 2012 18:46:02 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH v0 5/6] Bluetooth: btusb: Dynamic alternate setting
Message-ID: <20120416214602.GA2796@joana>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1334126932-27327-6-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334126932-27327-6-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

* Mikel Astiz <mikel.astiz.oss@gmail.com> [2012-04-11 08:48:51 +0200]:

> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> The alternate setting must be dynamically set according to the number of
> active SCO links, and the bit depth of the audio. The possible values
> for the alternate setting are described in the Bluetooth Core
> Specification, Volume 4, Part B, section 2.1.1.
> 
> Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
> ---
>  drivers/bluetooth/btusb.c |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)

Applied, thanks.

	Gustavo
