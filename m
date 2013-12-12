Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH 1/2] Bluetooth: Add missing 6lowpan.h include
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1386834801-1635-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 12 Dec 2013 09:00:44 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <47311435-2F2F-4743-899E-D5EA3545E43C@holtmann.org>
References: <1386834801-1635-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The 6lowpan.c file was missing an #include statement for 6lowpan.h.
> Without it we get the following type of warnings:
> 
> net/bluetooth/6lowpan.c:320:5: warning: symbol 'bt_6lowpan_recv' was not declared. Should it be static?
> net/bluetooth/6lowpan.c:737:5: warning: symbol 'bt_6lowpan_add_conn' was not declared. Should it be static?
> net/bluetooth/6lowpan.c:805:5: warning: symbol 'bt_6lowpan_del_conn' was not declared. Should it be static?
> net/bluetooth/6lowpan.c:878:5: warning: symbol 'bt_6lowpan_init' was not declared. Should it be static?
> net/bluetooth/6lowpan.c:883:6: warning: symbol 'bt_6lowpan_cleanup' was not declared. Should it be static?
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/6lowpan.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

