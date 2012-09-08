Return-Path: <cyrus@holtmann.org>
Date: Sat, 8 Sep 2012 00:41:46 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Update management interface revision
Message-ID: <20120908034146.GA1942@joana>
References: <1346945967-19424-1-git-send-email-johan.hedberg@gmail.com>
 <1346945967-19424-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346945967-19424-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-09-06 18:39:27 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> For each kernel release where commands or events are added to the
> management interface, the revision field should be increment by one.
> 
> The increment should only happen once per kernel release and not
> for every command/event that gets added. The revision value is for
> informational purposes only, but this simple policy would make any
> future debugging a lot simple.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both patches have been applied to bluetooth.git. Thanks.

	Gustavo
