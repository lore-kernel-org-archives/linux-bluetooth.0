Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix dereferencing conn variable before NULL check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1409975950-6110-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 5 Sep 2014 21:33:52 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D2210736-D81D-420C-8DB9-2A1C28605DEE@holtmann.org>
References: <1409975950-6110-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch fixes the following type of static analyzer warning (and
> probably a real bug as well as the NULL check should be there for a
> reason):
> 
> net/bluetooth/smp.c:1182 smp_conn_security() warn: variable dereferenced before check 'conn' (see line 1174)
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

