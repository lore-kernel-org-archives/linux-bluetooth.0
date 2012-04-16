Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Apr 2012 15:54:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Prerequisites for playstation-peripheral
 _external_ plugin
Message-ID: <20120416125428.GA30242@x220.P-661HNU-F1>
References: <1329144168-19263-1-git-send-email-ospite@studenti.unina.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329144168-19263-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Mon, Feb 13, 2012, Antonio Ospite wrote:
> I proposed these changes back in September[1] but they didn't receive
> a lot of comments, I know they are not very interesting to most of you,
> but let me repeat the rationale behind them.
> 
>   1. It was decided to have the playstation-peripheral as an external
>      plugin because it is going to be used by few people and it is not
>      worth to keep it in the bluetoothd binary. Distributors could
>      choose to put external plugins in their own packages so to provide
>      a install-time choice instead of a compile-time choice to use the
>      plugin services.
> 
>   2. external plugins can only access symbols exported as global in
>      src/bluetooth.ver, like btd_* and very few others.

libbluetooth public symbols should be available for anyone, including
plugins. If they're not that needs fixing. As for the other ones missing
a btd_ prefix you should just fix those too, i.e. this new _str function
shouldn't be needed at all.

Btw, where's the code for this playstation-peripheral plugin? That would
be important to see in order to better understand the use cases these
new bluetoothd APIs are needed for.

Johan
