Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 19:24:13 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/5] Bluetooth: Remove unused API's and code optimization
Message-ID: <20120413222413.GH1680@joana>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
 <1334243001-17016-26-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334243001-17016-26-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

* Syam Sidhardhan <s.syam@samsung.com> [2012-04-12 20:33:16 +0530]:

> This series of patches removes various unused API's and avoid unwanted
> goto statements.

I think you did a mistake when sending these patches, userspace and
kernel patches are mixed in the same thread. when using git send-email
send one patches per project and not everything in the same batch, please.

	Gustavo
