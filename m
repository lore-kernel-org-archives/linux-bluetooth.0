Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Feb 2012 19:50:29 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Change interleaved discovery behavior
Message-ID: <20120301015029.GG26492@x220>
References: <1330094465-4625-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330094465-4625-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Feb 24, 2012, Andre Guedes wrote:
> According to last discussion on IRC, if an interleaved discovery is
> issued, but the device is not dual mode, we should return error
> instead of performing a regular BR/EDR or LE-only discovery.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |   29 +++++------------------------
>  1 file changed, 5 insertions(+), 24 deletions(-)

Applied. Thanks.

Johan
