Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 May 2012 12:52:19 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 17/17] Bluetooth: A2MP: Manage incoming connections
Message-ID: <20120529155218.GD4575@joana>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1338289158-25655-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1338289158-25655-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338289158-25655-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-05-29 13:59:17 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Handle incoming A2MP connection by creating AMP manager and
> processing A2MP messages.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/a2mp.h |    4 ++++
>  net/bluetooth/a2mp.c         |   16 ++++++++++++++++
>  net/bluetooth/l2cap_core.c   |   19 +++++++++++++++----
>  3 files changed, 35 insertions(+), 4 deletions(-)

A 17 patches were applied to bluetooth-next. Thanks.

	Gustavo
