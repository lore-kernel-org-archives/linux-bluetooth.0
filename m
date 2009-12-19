Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20091217125456.GA3860@atheros-laptop>
References: <20091217125456.GA3860@atheros-laptop>
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Date: Fri, 18 Dec 2009 17:17:42 -0800
Message-ID: <43e72e890912181717x26ded925w4ffd0c1fa02c42b1@mail.gmail.com>
Subject: Re: [PATCH]compat-wireless:Fixed bluetooth modules compilation
	issues.
To: Bala Shanmugam <sbalashanmugam@atheros.com>
Cc: Luis Rodriguez <Luis.Rodriguez@atheros.com>,
	mcgrof@bombadil.infradead.org,
	Jothikumar Mothilal <Jothikumar.Mothilal@atheros.com>,
	linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-wireless-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 17, 2009 at 4:54 AM, Bala Shanmugam
<sbalashanmugam@atheros.com> wrote:
> Bluetooth modules in net/bluetooth were not compiled as
> CONFIG macro in config.mk and Makefile are different.
>
> Bluetooth modules has compilation issues as source code
> is taken from linux-next.git tree.  Fixed the same.
>
>  Signed-off-by: Bala Shanmugam <sbalashanmugam@atheros.com>

Applied thanks.

  Luis
