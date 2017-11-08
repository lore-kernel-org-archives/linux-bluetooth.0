Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 8 Nov 2017 09:49:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] plugins/sixaxis: Fix cable pairing not working
Message-ID: <20171108074930.GA11778@x1c.lan>
References: <20171107182356.15683-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171107182356.15683-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Nov 07, 2017, Bastien Nocera wrote:
> In 6c467e9, get_pairing_type() was modified to return a structure that's
> allocated on the stack. While not a problem for the direct callers,
> as the function is defined as "inline", function that expected to return
> this structure themselves would fail, as the stack would be trampled
> upon on function exit.

The devices array inside get_pairing() is declared as static, so I don't
see how this can be on the stack? Are these the structures you're
referring to? That said, it seems weird to have an inline function
declare a static variable, since then every single caller of the
function would cause another static variable to be allocated, right? It
seems to me that if the function is still desired to be inline then the
cable_pairing array should at least be moved into some c-file, so that
it only gets created once. Perhaps a better solution is however to stop
having get_pairing() as inline to begin with?

Johan
