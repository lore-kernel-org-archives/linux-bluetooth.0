Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Oct 2011 01:45:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] Add Vendor, Product and Version properties to
 org.bluez.Device
Message-ID: <20111002224541.GA8956@fusion.localdomain>
References: <1316706712-17611-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316706712-17611-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Sep 22, 2011, Luiz Augusto von Dentz wrote:
> This identifiers can be used by applications to implements quirks which
> seems to be very common in some profiles such as syncml and since this
> information is already stored permanently we can quickly retrieve it
> without having to connect or parse the records again.
> ---
>  doc/device-api.txt |   12 +++++++
>  src/device.c       |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.h       |    3 ++
>  3 files changed, 101 insertions(+), 0 deletions(-)

All four patches applied. Thanks.

Johan
