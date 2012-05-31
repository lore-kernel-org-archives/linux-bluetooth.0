Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 May 2012 15:52:31 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: Return proper mgmt state when LE pairing
 connection failed
Message-ID: <20120531185231.GA24769@joana>
References: <1338385163-10589-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1338385163-10589-2-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338385163-10589-2-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

* Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com> [2012-05-30 15:39:22 +0200]:

> MGMT_STATUS_BUSY should be returned when LE pairing cannot be started due
> to another outgoing connection attempt is ongoing.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
>  net/bluetooth/mgmt.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

	Gustavo
