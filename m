Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Dec 2010 13:26:32 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Jun Nie <niej0001@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Brian Gix <bgix@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] bluetooth: add NULL pointer check in hci
Message-ID: <20101208152632.GB1247@vigoh>
References: <AANLkTinu7oKUD5FmGyJ2x+ZYqRmOyFijuZgWtgjg=tk=@mail.gmail.com>
 <20101207150608.GA1867@vigoh>
 <AANLkTinN3R4q-YA=4jweveB4LfE9S2SwhCK2xXYORw6W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinN3R4q-YA=4jweveB4LfE9S2SwhCK2xXYORw6W@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jun,

* Jun Nie <niej0001@gmail.com> [2010-12-08 13:46:34 +0800]:

> From e729eda3b2cfae501c704e2eb39e07aa1b8607f0 Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Tue, 7 Dec 2010 14:03:38 +0800
> Subject: [PATCH] bluetooth: add NULL pointer check in hci
> 
> If we fail to find a hci device pointer in hci_uart, don't try
> to deref the NULL one we do have.
> 
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
>  drivers/bluetooth/hci_ldisc.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

Patch is applied now, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
