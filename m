Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 10:26:32 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Simplify L2CAP timer logic
Message-ID: <20120320132632.GB20925@joana>
References: <1332247868-32396-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332247868-32396-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-20 14:51:08 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Simplify L2CAP timers logic. Previous logic was hard to understand.
> Now we always hold(chan) when setting up timer and put(chan) only
> if work pending and we successfully cancel delayed work.
> 
> If delayed work is executing it will put(chan) itself.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |   27 ++++++++++++++-------------
>  1 files changed, 14 insertions(+), 13 deletions(-)

Applied, thanks.

	Gustavo
