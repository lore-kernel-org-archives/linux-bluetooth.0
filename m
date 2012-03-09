Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Mar 2012 09:42:32 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Correct chan->psm endian conversions
Message-ID: <20120309124231.GE16366@joana>
References: <1331295377-6097-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331295377-6097-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-09 14:16:17 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> chan->psm is kept in __le16 format which was not always taken
> into account. Fix several bugs related to extra conversion.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

	Gustavo
