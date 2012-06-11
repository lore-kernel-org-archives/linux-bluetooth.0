Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] mgmtops: Fix adding UUID when EBUSY error is returned
Date: Mon, 11 Jun 2012 22:18:14 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <1339357852-6326-1-git-send-email-szymon@janc.net.pl> <20120611094011.GA16742@x220.ger.corp.intel.com>
In-Reply-To: <20120611094011.GA16742@x220.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201206112218.14428.szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Monday 11 June 2012 11:40:11 Johan Hedberg wrote:
> It's there a risk that this ends up in an infinite loop if the kernel is
> in some state where it always keeps sending STATUS_BUSY? Would it make
> sense to add a counter for retries and give up after 5 or 10 attempts?

That would meant host didn't get command complete for set COD command (meaning 
something else is badly broken), but I guess adding counter 'just in case' 
wouldn't hurt much.

> Would it also make sense to add a small delay before resending the
> command?

I'm not sure up to how long can setting COD take, on my pc it takes <100ms for 
`hciconfig hci0 class 0x540100` with USB dongle. Does g_timeout_add with 
timeout ~50ms make sense?

-- 
Szymon K. Janc
szymon@janc.net.pl

