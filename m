Return-Path: <cyrus@holtmann.org>
Date: Sat, 25 Jan 2014 17:13:29 -0500
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Rename adapter_remove_device to btd_adapter_remove_device
Message-ID: <20140125221329.GB14531@x220.p-661hnu-f1>
References: <20140125005506.7AD85100900@puck.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140125005506.7AD85100900@puck.mtv.corp.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Fri, Jan 24, 2014, Petri Gynther wrote:
> Allow this symbol to be exported and usable from external plugins.
> ---
>  src/adapter.c | 14 +++++++-------
>  src/adapter.h |  3 +++
>  2 files changed, 10 insertions(+), 7 deletions(-)

The patch looks fine, but we usually don't export symbols without
knowing that there exists a valid use case for it. So could you perhaps
give some background (or even a follow-up patch) to explain what you
need this for?

Johan
