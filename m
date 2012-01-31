Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jan 2012 18:04:40 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/8] Bluetooth: Rename smp_key_size to enc_key_size
Message-ID: <20120131020440.GA4517@x220.globalsuite.net>
References: <1327962558-25720-1-git-send-email-vinicius.gomes@openbossa.org>
 <1327962558-25720-3-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327962558-25720-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Jan 30, 2012, Vinicius Costa Gomes wrote:
> This makes clear that this is the size of the key used to
> encrypt the link.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/smp.h |    2 +-
>  net/bluetooth/smp.c         |   18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)

Patches 1 and 2 have been applied to my bluetooth-next tree (with
Marcel's acks), so no need to resend them.

Johan
