Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Sep 2011 22:56:06 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Use the MEDIUM security level for pairings
Message-ID: <20110914015606.GJ16856@joana>
References: <1314985882-24059-1-git-send-email-vinicius.gomes@openbossa.org>
 <1314985882-24059-4-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314985882-24059-4-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-09-02 14:51:22 -0300]:

> This lifts the requirement of 16 digits pin codes when pairing
> with devices that do not support SSP when using the mgmt interface.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)

Patches 1 and 3 area applied. Thanks.

	Gustavo
