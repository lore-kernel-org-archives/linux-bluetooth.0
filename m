Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Oct 2012 20:01:31 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [bluetooth:master 12/33] net/bluetooth/l2cap_core.c:4495:6:
 sparse: symbol 'l2cap_physical_cfm' was not declared. Should it be static?
Message-ID: <20121024220131.GB3030@joana>
References: <508863c1.QTbySMnQ9kj6jDZz%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <508863c1.QTbySMnQ9kj6jDZz%fengguang.wu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fengguang,

* Fengguang Wu <fengguang.wu@intel.com> [2012-10-25 05:55:13 +0800]:

> Hi Mat,
> 
> FYI, there are new sparse warnings show up in
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
> head:   77220c6582477e696e3f3a53634fb1bd73128e95
> commit: 8eb200bd2f1c772dcb7f108f690ef03b054be04e [12/33] Bluetooth: Handle physical link completion
> 
> + net/bluetooth/l2cap_core.c:4495:6: sparse: symbol 'l2cap_physical_cfm' was not declared. Should it be static?
> 
> Please consider folding the attached diff :-)

Thanks a lot for finding this, but please can you send me a proper git
formatted patch with Signed-off-by message so I can add your patch to
bluetooth-next.

	Gustavo
