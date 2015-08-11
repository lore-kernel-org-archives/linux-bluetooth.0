Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] ath3k: Revert 7e730c7f3d1f39c25cf5f7cf70c0ff4c28d7bec7
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1439290229-6937-1-git-send-email-hanipouspilot@gmail.com>
Date: Tue, 11 Aug 2015 12:23:29 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Message-Id: <96FCB7AC-6E4C-4ED1-8048-87843978A63B@holtmann.org>
References: <1439290229-6937-1-git-send-email-hanipouspilot@gmail.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

> This patch causes infinite loop on loading firmware on Acer Aspire
> V3è371-31KW and probably other laptops.
> 
> This is a serious regression, because system becomes unresponsive.
> 
> This should be reverted until the firmware loading issue is sorted out.

this needs a lot more explanation on why I am suppose to revert this now.

And now I am really reluctant to have any ath3k patches marked as stable. If things are not tested properly, then please refrain from adding stable tags since these are clearly more than just VID/PID additions.

Regards

Marcel

