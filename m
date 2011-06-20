Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Jun 2011 16:32:39 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Remove useless access to the socket
Message-ID: <20110620193239.GD7240@joana>
References: <1308361587-8338-1-git-send-email-vinicius.gomes@openbossa.org>
 <1308361587-8338-3-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308361587-8338-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-06-17 22:46:27 -0300]:

> We already have access to the chan, we don't have to access the
> socket to get its imtu.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Patches 2 and 3 are applied. Thanks.

	Gustavo
