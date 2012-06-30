Return-Path: <cyrus@holtmann.org>
Date: Sat, 30 Jun 2012 11:42:10 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Improve debugging messages for hci_conn
Message-ID: <20120630144210.GA1920@joana>
References: <1339750229-10370-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339750229-10370-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-06-15 11:50:28 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Improve debugging of hci_conn objects by: adding print to hci_conn
> refcounting, adding object spcifier when missing, change conn to hcon
> since conn is heavily used for l2cap_conn objects and this is misleading.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    6 ++++++
>  net/bluetooth/hci_conn.c         |   44 +++++++++++++++++++-------------------
>  2 files changed, 28 insertions(+), 22 deletions(-)

Patch has been applied to bluetooth-next, thanks.

	Gustavo
