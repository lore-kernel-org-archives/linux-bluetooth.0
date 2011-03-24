Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Mar 2011 17:12:26 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH 04/10] Bluetooth: Use kthread API in bnep
Message-ID: <20110324201226.GG2236@joana>
References: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
 <1300713606-23523-5-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300713606-23523-5-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hy Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2011-03-21 14:20:00 +0100]:

> kernel_thread() is a low-level implementation detail and
> EXPORT_SYMBOL(kernel_thread) is scheduled for removal.
> Use the <linux/kthread.h> API instead.

Just to be sure. Have you tested the kernel_thread removal patches for bnep
and hipd?

-- 
Gustavo F. Padovan
http://profusion.mobi
