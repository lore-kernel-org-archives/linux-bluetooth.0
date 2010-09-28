Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Sep 2010 14:18:47 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add checking for agent reply state in adapter
Message-ID: <20100928111847.GA25553@jh-x301>
References: <1285665470-5261-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285665470-5261-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Tue, Sep 28, 2010, Radoslaw Jablonski wrote:
> Added checking for agent reply state before cancelling agent in
> session_free(..). This check is needed to ensure that memory for
> agent request will be freed only once (In that case, free on this
> request is called later in the end of agent_reply func)
> ---
>  src/adapter.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

Thanks. The patch has been pushed upstream with s/is_reply/got_reply/
which is more intuitive imho.

Johan
