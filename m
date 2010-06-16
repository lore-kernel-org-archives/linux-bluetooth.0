Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3 1/3] Implements hci_reassembly to reassemble Rx
 packets
From: suraj <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <Luis.Rodriguez@Atheros.com>,
	<Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <1276088748.31226.6.camel@atheros013-desktop>
References: <1276088748.31226.6.camel@atheros013-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Jun 2010 12:54:35 +0530
Message-ID: <1276673075.18938.8.camel@atheros013-desktop>
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, 2010-06-09 at 18:35 +0530, suraj wrote:
> Implements feature to reassemble received HCI frames from any input stream.
> 
> Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> ---
>  net/bluetooth/hci_core.c |  115 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 115 insertions(+), 0 deletions(-)
> 
Let me know if you have any comments on this implementation

Regards
Suraj
