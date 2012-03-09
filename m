Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Mar 2012 09:40:14 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Correct type for ediv to __le16
Message-ID: <20120309123912.GC16366@joana>
References: <1331287932-28824-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331287932-28824-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-09 12:12:12 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Correct type warnings reported by sparse to show that this
> functions takes ediv argument in __le16 format.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    4 ++--
>  net/bluetooth/hci_core.c         |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

	Gustavo
