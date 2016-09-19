Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 1/5] Bluetooth: Refactor read_ext_controller_info handler
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1474309556-7447-1-git-send-email-szymon.janc@codecoup.pl>
Date: Mon, 19 Sep 2016 20:34:23 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FC27F313-90B1-47A6-924D-BCC39A5F47C0@holtmann.org>
References: <1474309556-7447-1-git-send-email-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> There is no need to allocate heap for reply only to copy stack data to
> it. This also fix rp memory leak and missing hdev unlock if kmalloc
> failed.
> 
> Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
> ---
> net/bluetooth/mgmt.c | 36 ++++++++++++++++--------------------
> 1 file changed, 16 insertions(+), 20 deletions(-)

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel

