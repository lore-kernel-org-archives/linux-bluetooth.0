Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Mar 2012 10:42:39 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Refactor stop_discovery
Message-ID: <20120322134239.GD6260@joana>
References: <1332267336-15967-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332267336-15967-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2012-03-20 15:15:36 -0300]:

> This patch does a trivial code refactoring in stop_discovery
> function by using a switch statement instead of an if-return-else
> approach.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |   40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)

Applied, thanks.

	Gustavo
