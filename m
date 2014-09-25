Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Gu Chaojie <chao.jie.gu@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/3] support signed write command
Date: Thu, 25 Sep 2014 10:54:57 +0200
Message-ID: <1457354.2RSuMrT851@uw000953>
In-Reply-To: <1411633738-19108-1-git-send-email-chao.jie.gu@intel.com>
References: <1411633738-19108-1-git-send-email-chao.jie.gu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gu Chaojie,

On Thursday 25 of September 2014 16:28:55 Gu Chaojie wrote:
> This patch set adds signed write command outgoing.
> Patch set v1 cannot apply on latest source code
> because it conflict with Arman's newest patch.
> 
> Gu Chaojie (3):
>   shared/att.c: Add signed command outgoing and related CSRK function
>   shared/gatt-client: Add CSRK part to support signed write
>   tools/btgatt-client: Add signed write CSRK option
> 
>  src/shared/att-types.h   |    3 ++
>  src/shared/att.c         |  101 ++++++++++++++++++++++++++++++++++++++++++++--
>  src/shared/att.h         |   13 ++++++
>  src/shared/gatt-client.c |   28 ++++++++++---
>  src/shared/gatt-client.h |    5 +++
>  tools/btgatt-client.c    |   35 +++++++++++++++-
>  6 files changed, 175 insertions(+), 10 deletions(-)
> 

This doesn't link:

  CCLD     tools/btgatt-client
src/shared/att.o: In function `bt_att_new':
bluez/src/shared/att.c:745: undefined reference to `bt_crypto_new'
bluez/src/shared/att.c:783: undefined reference to `bt_crypto_unref'
src/shared/att.o: In function `encode_pdu':
bluez/src/shared/att.c:314: undefined reference to `bt_crypto_sign_att'

-- 
Best regards, 
Szymon Janc
