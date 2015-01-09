Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Jan 2015 11:45:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] shared/gatt: Fix NULL dereference
Message-ID: <20150109094556.GA7762@t440s.lan>
References: <1418981124-19877-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418981124-19877-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Dec 19, 2014, Andrei Emeltchenko wrote:
> The which is executed after checking (!op) is dereferencing op in
> function discovery_op_free().
> ---
>  src/shared/gatt-client.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Both patches in this set have been applied. Thanks.

Johan
