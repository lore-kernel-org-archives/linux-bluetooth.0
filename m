Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Mar 2011 11:16:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] telephony-ofono: fix handling of
 telephony_key_press_req
Message-ID: <20110324091628.GA30621@jh-x301>
References: <1300894927-31702-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300894927-31702-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Mar 23, 2011, Luiz Augusto von Dentz wrote:
> ---
>  audio/telephony-ofono.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)

Pushed upstream. Thanks. Btw, don't be afraid to use a bit more verbose
commit messages. I can guess what was wrong with the original code, but
it would be nice to have it explicitly stated in the commit message.

Johan
