Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Apr 2011 18:47:18 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH] Bluetooth: Fix Out Of Band pairing when mgmt interface
 is disabled
Message-ID: <20110407214718.GB2366@joana>
References: <1302087719-18197-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302087719-18197-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2011-04-06 13:01:59 +0200]:

> Use kernel stored remote Out Of Band data only if management interface
> is enabled. Otherwise HCI_OP_REMOTE_OOB_DATA_NEG_REPLY was sent to
> controller even if remote Out Of Band data was present in bluetoothd.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/hci_event.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
