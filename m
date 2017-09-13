Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH BlueZ] sdp: Fix Out-of-bounds heap read in
 service_search_attr_req function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170913070140.12576-1-luiz.dentz@gmail.com>
Date: Wed, 13 Sep 2017 09:08:22 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <25AA664B-4C5C-4D89-88DC-3C84202F7611@holtmann.org>
References: <20170913070140.12576-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Check if there is enough data to continue otherwise return an error.
> ---
> src/sdpd-request.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied.

Regards

Marcel

