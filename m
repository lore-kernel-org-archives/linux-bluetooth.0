Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Jun 2012 00:11:51 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Use AUTO_OFF constant in jiffies
Message-ID: <20120619031151.GD1679@joana>
References: <CAJdJm_MtZYC9=nFzchcCR+yZiyGVNCMpXnmPf7D-dKut1UT8BA@mail.gmail.com>
 <1339745802-8382-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339745802-8382-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-06-15 10:36:42 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Move AUTO_OFF_TIMEOUT to other constants changing name to
> HCI_AUTO_OFF_TIMEOUT and convert to jiffies.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h |    3 ++-
>  net/bluetooth/hci_core.c    |    5 +----
>  2 files changed, 3 insertions(+), 5 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
