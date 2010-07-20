Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Jul 2010 15:35:21 +0300
From: "Hedberg Johan (Nokia-D/Helsinki)" <johan.hedberg@gmail.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fixed problem with incoming calls query
Message-ID: <20100720123521.GA11919@jh-x301>
References: <1279629030-10504-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279629030-10504-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 20, 2010, Radoslaw Jablonski wrote:
> After making some incoming, outgoing, missed calls, history lists of them
> (ich, och, mch) are stored on device. In current implementation queries
> towards tracker for incoming calls include also missed calls.
> So list for incoming calls displayed on paired BT headset/carkit screen
> (e.g. BH-903, CK-200) also contains numbers from missed calls list.
> 
> To block adding missed calls list numbers to incoming calls there should
> be added info that incoming call is in fact only answered call. So macros
> additionally include info: "nmo:isAnswered true ." Without this, missed
> calls was treated as incoming calls.
> ---
>  plugins/phonebook-tracker.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

Thanks for the patch. It has now been pushed upstream.

Johan
