Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Jul 2011 19:23:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] btio: Fix the return value of bt_io functions
Message-ID: <20110709162333.GF11005@dell.ger.corp.intel.com>
References: <1309885200-27393-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309885200-27393-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Jul 05, 2011, Vinicius Costa Gomes wrote:
> Some bt_io methods were ignoring the value stored in errno when
> reporting the error to the caller.
> ---
>  btio/btio.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)

Applied. Thanks.

Johan
