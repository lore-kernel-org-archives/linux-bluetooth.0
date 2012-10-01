Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Oct 2012 11:38:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] gatt: Remove reading Service Changed characteristic
 after connected
Message-ID: <20121001083800.GB22036@x220>
References: <1346939130-22075-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346939130-22075-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Sep 06, 2012, Andrzej Kaczmarek wrote:
> Service Changed characteristic is a control-point attribute thus it
> cannot be read and attempting to do so will fail. Instead, server
> shall send indication once enabled in CCC.
> 
> This change is due to "Erratum 3833 - Service Changed" (ESR05) which
> changed characteristic value properties from 0x26 to 0x20.
> ---
>  profiles/gatt/gas.c | 37 -------------------------------------
>  1 file changed, 37 deletions(-)

Applied. Thanks.

Johan
