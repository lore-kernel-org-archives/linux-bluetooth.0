Return-Path: <cyrus@holtmann.org>
Date: Fri, 31 Aug 2012 10:55:56 -0700
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Remove unneeded zero init
Message-ID: <20120831175556.GB5599@joana>
References: <1346339195.23377.8.camel@aeonflux>
 <1346420369-11909-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346420369-11909-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-08-31 16:39:28 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> hdev is allocated with kzalloc so zero initialization is not needed.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    9 ---------
>  net/bluetooth/hci_core.c         |    2 +-
>  2 files changed, 1 insertion(+), 10 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
