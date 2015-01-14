Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Jan 2015 11:21:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, bharat.panda@samsung.com,
	cpgs@samsung.com
Subject: Re: [PATCH] Bluetooth: Remove dead code
Message-ID: <20150114092108.GA30198@t440s.lan>
References: <1420466575-14615-1-git-send-email-gowtham.ab@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420466575-14615-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Mon, Jan 05, 2015, Gowtham Anandha Babu wrote:
> Variable 'controller' is assigned a value that is never used.
> Identified by cppcheck tool.
> 
> Signed-off-by: Gowtham Anandha Babu <gowtham.ab@samsung.com>
> ---
>  net/bluetooth/cmtp/capi.c | 6 ------
>  1 file changed, 6 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
