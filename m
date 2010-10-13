Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Oct 2010 17:25:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix X-IRMC-CALL-DATETIME format
Message-ID: <20101013142518.GA5138@jh-x301>
References: <1286975756-13134-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286975756-13134-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Oct 13, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Use the format suggested in the spec:
> 
> "For instance, a call that was missed on March 20th, 2005 at 10 am would
> be stamped: X-IRMC-CALL-DATETIME;MISSED:20050320T100000"
> ---
>  plugins/phonebook-tracker.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Pushed upstream. Thanks.

Johan
