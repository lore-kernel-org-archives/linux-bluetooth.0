Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Jan 2013 01:45:54 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix pair device command reply if adapter is
 powered off
Message-ID: <20130123034554.GA1632@joana>
References: <1358509687-7194-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358509687-7194-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2013-01-18 12:48:07 +0100]:

> According to Bluetooth Management API specification Pair Device Command
> should generate command complete event on both success and failure.
> This fix replying with command status (which lacks address info) when
> adapter is powered off.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/mgmt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
