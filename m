Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Oct 2015 11:03:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/6] emulator: Fix LE Connection Complete Event data
Message-ID: <20151005080333.GA632@t440s.lan>
References: <1443008219-15890-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443008219-15890-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Wed, Sep 23, 2015, Mariusz Skamra wrote:
> This sets LE Connection Complete Event paramaters based on parameters
> from LE Create Connection command.
> Event parameters like Conn_Interval and Supervision_Timeout
> shouldn't be set to 0.
> ---
>  emulator/btdev.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)

All patches in this set have been applied. Thanks.

Johan
