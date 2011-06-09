Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Jun 2011 23:16:48 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] Bluetooth: Limit depth of the HCI TX queue with ERTM
 mode
Message-ID: <20110609021648.GA2776@joana>
References: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
 <1307143270-2655-3-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307143270-2655-3-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-06-03 16:21:09 -0700]:

> In order to provide timely responses to REJ, SREJ, and poll input from
> the remote device, it helps to reduce the number of ERTM data frames
> in the HCI TX queue at one time. If a full TX window of data is in the
> HCI TX queue, any responses to REJ, SREJ, or polls must wait in line
> behind all previously queued data. This latency leads to disconnects,
> and will be more severe with extended window sizes.


I prefer if we go with a hci_send_acl_prio() implementation. It will have much
less overhead using a workqueue. As it will be filled only by S-frames with a
few bytes each I don't think we will have problems. So lets go with this
approach and see what we can get.

	Gustavo
