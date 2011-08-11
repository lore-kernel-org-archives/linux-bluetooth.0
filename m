Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Aug 2011 18:08:00 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: cmtp: Fix session cleanup on failed conn add
Message-ID: <20110811210800.GF19699@joana>
References: <1312556032.2172.16.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312556032.2172.16.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

* Peter Hurley <peter@hurleysoftware.com> [2011-08-05 10:53:52 -0400]:

> Once the session thread is running, cleanup must be handled
> by the session thread only.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  net/bluetooth/cmtp/core.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)

Applied, Thanks.

	Gustavo
