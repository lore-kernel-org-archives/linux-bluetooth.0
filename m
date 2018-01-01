Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20171229095135.GA25623@wunner.de>
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
 <9ef8be4ef80c38b693e5755c738a88de9c907944.1514143015.git.lukas@wunner.de>
 <1514450477.7000.302.camel@linux.intel.com> <20171228091805.GA1559@wunner.de>
 <1514453177.7000.320.camel@linux.intel.com> <CACRpkdb=Wj9dEfu7YEfQCA94MdBNQmp5UwHOgRsTZX=bf5d-Hw@mail.gmail.com>
 <1514464858.7000.334.camel@linux.intel.com> <CACRpkdYRojbfCC_b9vO0MquvLeenru0rrYNv7WzMg3d3b=iF+g@mail.gmail.com>
 <20171229095135.GA25623@wunner.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 1 Jan 2018 16:23:12 +0100
Message-ID: <CACRpkda1uzW2A=13tobpNrNNgTmv-ri6kb628TYS7rv3xPsx4A@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Avoid WARN splat due to missing GPIOLIB
To: Lukas Wunner <lukas@wunner.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
	Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>,
	"Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Dec 29, 2017 at 10:51 AM, Lukas Wunner <lukas@wunner.de> wrote:

> By the way, what is the rationale for this rule that consumers shall
> depend on rather than select GPIOLIB?

I think consumers should depend on GPIOLIB and producers
should select GPIOLIB.

Alas, I suck at Kconfig, people have expressed that it is terse,
ambigous (to the point of not using regular grammar) and so
on, I am just as confused as the next developer.

Yours,
Linus Walleij
