Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] shared/gatt-client: Fix invalid access during descriptor discovery.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1409775988-24535-1-git-send-email-armansito@chromium.org>
Date: Thu, 4 Sep 2014 20:40:53 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <631220BA-964E-4555-9798-474FFC30E6EB@holtmann.org>
References: <1409775988-24535-1-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch fixes an off-by-one error during descriptor discovery, which results
> in an invalid access if more than one descriptor declaration exists within a
> service handle range.
> ---
> src/shared/gatt-client.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied.

Regards

Marcel

