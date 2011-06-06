Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Jun 2011 11:01:34 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Briglia <anderson.briglia@openbossa.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [bluetooth-next v2 05/16] Bluetooth: Add LE SMP Cryptoolbox
 functions
Message-ID: <20110606140134.GA3345@piper>
References: <1307046738-19588-1-git-send-email-vinicius.gomes@openbossa.org>
 <1307046738-19588-6-git-send-email-vinicius.gomes@openbossa.org>
 <BANLkTinzz1G1HUETqp856_CV8kQgz7Ko1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTinzz1G1HUETqp856_CV8kQgz7Ko1A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 15:26 Mon 06 Jun, Luiz Augusto von Dentz wrote:
> Hi Anderson,
> 

[ snip ]

> 
> It seems we gonna need to add a dependency to smp to really make sure
> the crypto API is available, at least it didn't work for us here at
> upf without enabling ECB support (Thanks for Brian Gix to point this
> out).

The previous patch should have added this dependency. Going to fix this.
Thanks.

> 
> -- 
> Luiz Augusto von Dentz
> Computer Engineer


Cheers,
-- 
Vinicius
