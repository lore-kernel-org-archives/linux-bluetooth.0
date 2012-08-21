Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Aug 2012 15:10:29 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mgmt: Fix returning a list with invalid
 indexes
Message-ID: <20120821181029.GA14471@samus>
References: <1344988788-16378-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344988788-16378-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 20:59 Tue 14 Aug, Vinicius Costa Gomes wrote:
> When a device is in the HCI_SETUP state, it was being counted as
> a valid device, but it wasn't included in the list returned to
> userspace.
> 
> This can be reproduced when you add an adapter after doing
> 'rfkill block all', for example.
> 
> This commit also has the (intended) effect of making
> 'btmgmt power on' work after the rfkill block has been lifted.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

bump :-)


Cheers,
-- 
Vinicius
