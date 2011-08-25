Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 22:30:55 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 6/7] Bluetooth: Add support for running SMP without a
 socket
Message-ID: <20110825013055.GH5462@joana>
References: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313798816-8647-7-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313798816-8647-7-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-08-19 21:06:55 -0300]:

> When doing the pairing procedure we won't have an associated
> socket, but we still have to do the SMP negotiation. This
> adds support for encrypting the link and exchanging keys.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/l2cap_core.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)

Applied, thanks.

	Gustavo
