Return-Path: <cyrus@holtmann.org>
Date: Sun, 18 Dec 2011 17:45:43 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/7 v2] Bluetooth: Add timer for automatically disabling
 the service cache
Message-ID: <20111218194543.GC2621@joana>
References: <1323902861-15990-1-git-send-email-johan.hedberg@gmail.com>
 <1323902861-15990-6-git-send-email-johan.hedberg@gmail.com>
 <20111215000814.GA22803@samus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111215000814.GA22803@samus>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-12-14 21:08:14 -0300]:

> Hi Johan,
> 
> On 00:47 Thu 15 Dec, johan.hedberg@gmail.com wrote:
> > From: Johan Hedberg <johan.hedberg@intel.com>
> > 
> > We do not want the service cache to be enabled indefinitely after
> > mgmt_read_info is called. The solve this a timer is added which will
> 
> Minor nitpick: "To solve this".

I fixed this as well.

	Gustavo
