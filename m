Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Jul 2010 12:09:21 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Dan Tian <Dan.Tian@Atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Haijun Liu <Haijun.Liu@Atheros.com>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>
Subject: Re: [PATCH 1/3] Add BT3 AMP device support, by Atheros Linux BT3
 team.
Message-ID: <20100715150921.GA3188@vigoh>
References: <CDAFEDABF718A54BABD0DA5476695307CE881EC1@SHEXMB-01.global.atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CDAFEDABF718A54BABD0DA5476695307CE881EC1@SHEXMB-01.global.atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

* Dan Tian <Dan.Tian@Atheros.com> [2010-07-15 15:37:32 +0800]:

> From 40cbfbf5c1bc9109364970956d9b6f74f5846c70 Mon Sep 17 00:00:00 2001
> From: Haijun.Liu <Haijun.Liu@Atheros.com>
> Date: Wed, 14 Jul 2010 22:50:56 +0800
> Subject: [PATCH 1/3] Add BT3 AMP device support, by Atheros Linux BT3 team.
> 
> 
> Signed-off-by: Haijun.Liu <Haijun.Liu@Atheros.com>
> ---
>  include/net/bluetooth/hci.h      |  342 +++++++++++++++++++-
>  include/net/bluetooth/hci_core.h |  264 ++++++++++++++-
>  net/bluetooth/cmtp/core.c        |    1 +
>  net/bluetooth/hci_conn.c         |  201 +++++++++++-
>  net/bluetooth/hci_core.c         |  349 ++++++++++++++++++--
>  net/bluetooth/hci_event.c        |  698 +++++++++++++++++++++++++++++++++++++-
>  6 files changed, 1822 insertions(+), 33 deletions(-)


Could you split all your patches in little chunks? +1882 is very hard to
review. And please be more verbose on the commit message, it can help us
figure out what's happening.


-- 
Gustavo F. Padovan
http://padovan.org
