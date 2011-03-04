Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: [PATCH] Fix adapter reference count in input plugin
Date: Fri, 4 Mar 2011 20:02:17 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
References: <1299059097-24462-1-git-send-email-szymon.janc@tieto.com> <20110304183826.GB21452@jh-x301>
In-Reply-To: <20110304183826.GB21452@jh-x301>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201103042002.18032.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> This one looks like it's working around the core issue instead of fixing
> it. The _remove function shouldn't get called if _probe failed. I.e. the
> issue seems to be somewhere in the core daemon.

Every btd_adapter_driver do that so I just followed.

But I agree that proper fix should be in core daemon i.e. flag in
btd_adapter_driver structure and set/test in load/unload_driver in adapter.c
or a separate list of activated drivers.

-- 
BR
Szymon Janc
