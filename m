Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Nov 2012 12:22:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for SCO defered setup in test
Message-ID: <20121120102200.GA6570@x220.ger.corp.intel.com>
References: <1353340244-16443-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1353340244-16443-1-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Mon, Nov 19, 2012, Frédéric Dalleau wrote:
> This adds support for deferred setup in userspace test tools for SCO
> connections.
> 
> Regards,
> Frédéric
> 
> Frédéric Dalleau (2):
>   scotest: Add deferred setup option
>   btiotest: Enable deferred setup for sco sockets
> 
>  test/btiotest.c |   22 +++++++++++++++-----
>  test/scotest.c  |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 72 insertions(+), 10 deletions(-)

Both patches have been applied. Thanks.

Johan
