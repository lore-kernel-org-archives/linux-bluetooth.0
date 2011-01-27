Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Jan 2011 11:01:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: flushable packet supports headers
Message-ID: <20110127090134.GA30327@jh-x301>
References: <1295948747-11094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295948747-11094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Jan 25, 2011, Emeltchenko Andrei wrote:
> Modify headers to enable support for flushable packets. Following
> commit: 8bcbd526c84724d8de087130d53e79da256e34bf to linux kernel
> implements functionality on kernel side.
> ---
>  lib/bluetooth.h |    5 +++++
>  lib/hci.h       |    1 +
>  2 files changed, 6 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
