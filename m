Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Nov 2013 16:40:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 8/8] android/daemon: Refactor sending acl state
Message-ID: <20131101144029.GA4773@x220.p-661hnu-f1>
References: <1383313305-9442-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383313305-9442-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383313305-9442-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Nov 01, 2013, Andrei Emeltchenko wrote:
> Sending ACL state change might be refactored.
> ---
>  android/adapter.c |   32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)

Patches 2-7 have been applied. 1/8 didn't apply and this last one is
quite unnecessary since there will never be more than two users and
you're actually adding more lines than you're removing.

Johan
