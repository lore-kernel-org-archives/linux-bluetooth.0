Return-Path: <johan.hedberg@gmail.com>
Date: Mon, 15 Aug 2016 11:30:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: add printf format attribute to
 hci_set_[fh]w_info()
Message-ID: <20160815083053.GA32660@t440s.lan>
References: <20160729112825.22091-1-nicolas.iooss_linux@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160729112825.22091-1-nicolas.iooss_linux@m4x.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nicolas,

On Fri, Jul 29, 2016, Nicolas Iooss wrote:
> Commit 5177a83827cd ("Bluetooth: Add debugfs fields for hardware and
> firmware info") introduced hci_set_hw_info() and hci_set_fw_info().
> These functions use kvasprintf_const() but are not marked with a
> __printf attribute.  Adding such an attribute helps detecting issues
> related to printf-formatting at build time.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
> ---
>  include/net/bluetooth/hci_core.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
