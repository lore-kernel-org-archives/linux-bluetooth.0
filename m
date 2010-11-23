Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Nov 2010 20:55:58 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 12/20] Bluetooth: fix receiving L2CAP packets over LE
Message-ID: <20101123225558.GD11860@vigoh>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
 <1290524796-32246-13-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290524796-32246-13-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2010-11-23 12:06:28 -0300]:

> As L2CAP packets coming over LE don't have any more encapsulation,
> other than L2CAP, we are able to process them as soon as they arrive.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/l2cap.c |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)

So move this patch before the SMP changes in the patchset.

-- 
Gustavo F. Padovan
http://profusion.mobi
