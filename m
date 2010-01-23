Return-Path: <cyrus@holtmann.org>
Date: Sat, 23 Jan 2010 19:25:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: papukaija <papukaija@skynet.be>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Feature request: remember bluetooth on/off setting
Message-ID: <20100123172550.GA18667@jh-x301>
References: <a69c0aba1001230519v3a197d9cq7942599e3a371168@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a69c0aba1001230519v3a197d9cq7942599e3a371168@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Jan 23, 2010, papukaija wrote:
> I rarely use bluetooth devices, so I turn bluetooth off until I need
> it. Every time I start my system (netbook; Samsung nc10) up again and
> log in again, I manually turn bluetooth off again.  I'd like
> bluetoothd to remember whether I last had bluetooth off or on, and use
> that same setting the next time.

bluetoothd already has this feature. You just need to make sure that
RememberPowered=true in /etc/bluetooth/main.conf

Johan
