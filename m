Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 12:32:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Store LE device address type with primary list
Message-ID: <20120426093203.GB18380@x220>
References: <1335360420-23445-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335360420-23445-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Wed, Apr 25, 2012, Hemant Gupta wrote:
> This patch stores the address type while storing the primary services
> of LE Device which is later used for re-creating device from primary
> service database.
> ---
>  src/adapter.c |   10 ++++++++--
>  src/device.c  |    9 +++++++--
>  2 files changed, 15 insertions(+), 4 deletions(-)

Would it make more sense (and I'm not asking just you but also the
INdTers) to have the address type as part of the key instead of the
value. After all it's basically an extension to the address and that way
tightly bound to it. Maybe something like the following:

11:22:33:44:55:66|1 <value1>
aa:bb:cc:dd:ee:ff|0 <value2>

The same should then also be considered for the longtermkeys file.

Johan
