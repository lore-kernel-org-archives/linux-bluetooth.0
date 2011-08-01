Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Aug 2011 16:20:43 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: use recommended LE connection parameters
Message-ID: <20110801192043.GB4430@joana>
References: <1311802809-10565-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311802809-10565-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2011-07-27 18:40:09 -0300]:

> The new connection parameters now match the recommended values for
> Proximity and Health Thermometer profiles. The previous values were
> ramdomly chosen, and are either too low or too high for most cases.
> 
> New values:
> 
> Scan Interval: 60 ms
> Scan Window: 30 ms
> Minimum Connection Interval: 50 ms
> Maximum Connection Interval: 70 ms
> Supervision Timeout: 420 ms
> 
> See "Table 5.2: Recommended Scan Interval and Scan Window Values" and
> "Table 5.3: Recommended Connection Interval Values" for both profiles
> for details. Note that the "fast connection" parameters were chosen,
> because we do not support yet dynamically changing these parameters from
> initiator side.
> 
> Additionally, the Proximity profile recommends (section "4.4 Alert on
> Link Loss"):
> 
> "It is recommended that the Link Supervision Timeout (LSTO) is set to 6x
> the connection interval."
> 
> Minimum_CE_Length and Maximum_CE_Length were also changed from 0x0001 to
> 0x0000 because they are informational and optional, and old value was
> not reflecting reality.
> ---
>  net/bluetooth/hci_conn.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)

Applied, and also added the Signed-off-by line that you forgot. Thanks.

	Gustavo
