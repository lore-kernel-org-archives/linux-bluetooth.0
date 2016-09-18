Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3] monitor: Add support for Set Appearance mgmt command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1474195647-10789-1-git-send-email-szymon.janc@codecoup.pl>
Date: Sun, 18 Sep 2016 16:15:51 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0C296804-7C71-4CF9-A7DB-6B420A76CFCA@holtmann.org>
References: <1474195647-10789-1-git-send-email-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> @ MGMT Command: Set Appearance (0x0043) plen 2        {0x0002}
>        Appearance: Blood Pressure (0x0380)
> @ MGMT Event: Command Complete (0x0001) plen 3        {0x0002}
>      Set Appearance (0x0043) plen 0
>        Status: Success (0x00)
> ---
> monitor/packet.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)

this patch and the other 4 from v2 have been applied.

Regards

Marcel

