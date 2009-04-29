Return-Path: <cyrus@holtmann.org>
Subject: Re: BUG: sleeping function called from invalid context at
 mm/slub.c:1595 --- "hcitool cc" or "l2ping"
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F704301E3F5C7F5@SC-VEXCH1.marvell.com>
References: <477F20668A386D41ADCC57781B1F704301E3F5C7F5@SC-VEXCH1.marvell.com>
Content-Type: text/plain
Date: Tue, 28 Apr 2009 17:56:05 -0700
Message-Id: <1240966565.997.65.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> I'm getting this error whenever I use "hcitool cc" or "l2ping xx:xx:xx:xx:xx:xx"  command.
> 
> Kernel: version 2.6.30-rc3 from bluetooth-testing tree
> HCI Tool: version 3.20
> Laptop: Lenovo X61s

can you rebase the bluetooth-testing.git tree from a few hours ago and
test again.

Regards

Marcel


