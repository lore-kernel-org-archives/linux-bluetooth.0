Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Jan 2013 09:32:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 4/6] device: Rename device_att_connect to
 device_connect_le
Message-ID: <20130125073256.GA19244@x220>
References: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
 <1359083227-13122-5-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359083227-13122-5-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Jan 25, 2013, Vinicius Costa Gomes wrote:
> This makes it clearer that this (currently unused) function should
> only be used with LE devices.
> ---
>  src/device.c | 2 +-
>  src/device.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Patches 3 and 4 have been applied.

Johan
