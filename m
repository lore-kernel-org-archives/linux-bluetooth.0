Return-Path: <computersforpeace@gmail.com>
Date: Tue, 14 Aug 2018 13:16:02 -0700
From: Brian Norris <computersforpeace@gmail.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Brian Norris <briannorris@chromium.org>,
	AL Yu-Chen Cho <acho@suse.com>
Subject: Re: [PATCH] bluetooth/{bnep,cmtp,hidp}: Remove unnecessary
 smp_mb__{before,after}_atomic
Message-ID: <20180814201602.GA159642@ban.mtv.corp.google.com>
References: <1534272066-9366-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534272066-9366-1-git-send-email-andrea.parri@amarulasolutions.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 14, 2018 at 08:41:06PM +0200, Andrea Parri wrote:
> The barriers are unneeded; wait_woken() and woken_wake_function()
> already provide us with the required synchronization: remove them
> and document that we're relying on the (implicit) synchronization
> provided by wait_woken() and woken_wake_function().
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
>  net/bluetooth/bnep/core.c |  7 ++++---
>  net/bluetooth/cmtp/core.c | 14 ++++++++------
>  net/bluetooth/hidp/core.c | 13 ++++++++-----
>  3 files changed, 20 insertions(+), 14 deletions(-)

Seems good to me:

Reviewed-by: Brian Norris <computersforpeace@gmail.com>
