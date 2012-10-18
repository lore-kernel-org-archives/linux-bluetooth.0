Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Oct 2012 07:28:17 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: AMP: Get amp_mgr reference in HS hci_conn
Message-ID: <20121018102817.GA19695@joana>
References: <20121015152738.GC6498@joana>
 <1350555379-7462-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350555379-7462-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-10-18 13:16:19 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> When assigning amp_mgr in hci_conn (type AMP_LINK) get also reference.
> In hci_conn_del those references would be put for both conn types
> AMP_LINK and ACL_LINK associated with amp_mgr.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/a2mp.h |    2 +-
>  net/bluetooth/a2mp.c         |    4 +++-
>  net/bluetooth/amp.c          |    2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
