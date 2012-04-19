Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Apr 2012 11:03:08 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Update L2CAP Channel State for LE Link during
 Pairing
Message-ID: <20120419140308.GA4127@joana>
References: <1334724874-3086-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334724874-3086-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

* Hemant Gupta <hemant.gupta@stericsson.com> [2012-04-18 10:24:34 +0530]:

> This patch updates the L2CAP Channel state to Connected when LE Link
> is established, so that data transmission can start on CID 4.
> Without this fix if remote side sends data on CID 4 immidiately after
> LE Link was established, data was being discarded in l2cap_att_channel()
> API because channel state was still BT_CONNECT when SMP pairing is in
> progress. This was resulting in disconnection from remote side after 30 seconds
> since ATT request was not answered by user space as data was discarded.

I'm not too familiar with all LE specifications, but doesn't this initial
data need to be secured? If the channel is not secure (the pairing has
not finished yet) and we may be transmitting in a not secure enough place.

	Gustavo
