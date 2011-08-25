Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 22:30:27 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/7] Bluetooth: Add support for pairing via mgmt over LE
Message-ID: <20110825013027.GG5462@joana>
References: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313798816-8647-6-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313798816-8647-6-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-08-19 21:06:54 -0300]:

> Using the advertising cache we are able to infer the type
> of the remote device, and so trigger pairing over the correct
> link type.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |   15 +++++++++++++--
>  1 files changed, 13 insertions(+), 2 deletions(-)

Applied, thanks.

	Gustavo
