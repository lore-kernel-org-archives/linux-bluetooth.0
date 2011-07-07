Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jul 2011 15:26:33 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: ilia.kolominsky@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Ilia Kolomisnky <iliak@ti.com>
Subject: Re: [PATCH Bluetooth-next v2] Fixes l2cap "command reject" reply
 according to spec.
Message-ID: <20110707182633.GB16322@joana>
References: <1310009762-18032-1-git-send-email-iliak@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310009762-18032-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* ilia.kolominsky@gmail.com <ilia.kolominsky@gmail.com> [2011-07-07 06:36:02 +0300]:

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

Patch doesn't apply to bluetooth-next

Applying: Fixes l2cap "command reject" reply according to spec.
fatal: corrupt patch at line 62
Patch failed at 0001 Fixes l2cap "command reject" reply according to spec.
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

	Gustavo
