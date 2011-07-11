Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Jul 2011 11:33:52 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: ilia.kolominsky@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Ilia Kolomisnky <iliak@ti.com>
Subject: Re: [PATCH Bluetooth-next v3] Fixes l2cap "command reject" reply
 according to spec.
Message-ID: <20110711143352.GA2816@joana>
References: <1310276864-6193-1-git-send-email-iliak@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310276864-6193-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

* ilia.kolominsky@gmail.com <ilia.kolominsky@gmail.com> [2011-07-10 08:47:44 +0300]:

> From: Ilia Kolomisnky <iliak@ti.com>
> 
> There can 3 reasons for the "command reject" reply produced
> by the stack. Each such reply should be accompanied by the
> relevand data ( as defined in spec. ). Currently there is one
> instance of "command reject" reply with reason "invalid cid"
> wich is fixed. Also, added clean-up definitions related to the
> "command reject" replies.
> 
> Signed-off-by: Ilia Kolomisnky <iliak@ti.com>
> ---
>  include/net/bluetooth/l2cap.h |   19 ++++++++++++++++++-
>  net/bluetooth/l2cap_core.c    |   15 +++++++++------
>  2 files changed, 27 insertions(+), 7 deletions(-)

Applied, thanks.

	Gustavo
