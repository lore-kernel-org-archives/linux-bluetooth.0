Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 May 2012 11:31:45 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Allow only one LE connection attempt
Message-ID: <20120531143145.GR18069@joana>
References: <1338385163-10589-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338385163-10589-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

* Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com> [2012-05-30 15:39:21 +0200]:

> Only one outgoing LE connection attempt should be possible.
> hci_connect() will now return -EBUSY in case there's another pending
> outgoing connection.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
>  net/bluetooth/hci_conn.c |    5 +++++
>  1 file changed, 5 insertions(+)

Patch has been applied to bluetooth-next, thanks.

	Gustavo
