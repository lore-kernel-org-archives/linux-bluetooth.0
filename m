Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Mar 2011 17:45:35 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [bluetooth-next] Bluetooth: fix sending LE data over USB
Message-ID: <20110316204534.GB2339@joana>
References: <1300137633-24495-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300137633-24495-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-03-14 18:20:33 -0300]:

> Now that we have support for LE connections, before discarding a
> frame we must check if there's a LE connection over that transport.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  drivers/bluetooth/btusb.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
