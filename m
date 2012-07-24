Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 19:16:25 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Make connect / disconnect cfm functions
 return void
Message-ID: <20120724221625.GJ20029@joana>
References: <1343135175-21617-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343135175-21617-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-07-24 16:06:15 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Return values are never used because callers hci_proto_connect_cfm
> and hci_proto_disconn_cfm return void.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    8 ++++----
>  net/bluetooth/l2cap_core.c       |    6 ++----
>  net/bluetooth/sco.c              |    7 ++-----
>  3 files changed, 8 insertions(+), 13 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
