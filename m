Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Feb 2011 13:03:56 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Westerlund <dwesterl@cc.hut.fi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add check for ACL_START_NO_FLUSH
Message-ID: <20110211210356.GA26894@jh-x301>
References: <AANLkTinUUNTzRf767irg3qSK8iefjn=pKMCknQ8f9=u-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinUUNTzRf767irg3qSK8iefjn=pKMCknQ8f9=u-@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Thu, Feb 10, 2011, Daniel ??rstadius wrote:
> In addition to ACL_START, hcidump should check for the flag
> ACL_START_NO_FLUSH to indicate the start of a frame.
> 
> Using '==' instead of '&' for the comparison since
> ACL_START_NO_FLUSH is defined to zero.
> 
> The flag was introduced in BlueZ commit
> 2430512c983cad8c20252f1df8f297399993ca3d
> ---
>  parser/l2cap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Pushed upstream after obvious coding-style fixes. Please pay attention
to those.

Johan
