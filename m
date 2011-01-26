Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jan 2011 15:09:55 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Do not use assignments in IF conditions
Message-ID: <20110126170955.GA27017@joana>
References: <1294759220-5002-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1294759220-5002-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294759220-5002-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-01-11 17:20:20 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Fix checkpatch warnings concerning assignments in if conditions.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/af_bluetooth.c |    6 ++++--
>  net/bluetooth/cmtp/capi.c    |    3 ++-
>  net/bluetooth/cmtp/core.c    |    9 ++++++---
>  net/bluetooth/hci_core.c     |   12 +++++++++---
>  net/bluetooth/hci_event.c    |   22 ++++++++++++++--------
>  net/bluetooth/hidp/core.c    |    9 ++++++---
>  net/bluetooth/l2cap.c        |    5 ++++-
>  7 files changed, 45 insertions(+), 21 deletions(-)

Patch has been applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
