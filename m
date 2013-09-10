Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Sep 2013 10:55:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>
Subject: Re: [PATCH] build: use -lrt for clock_gettime on glibc < 2.17
Message-ID: <20130910075506.GA20611@x220.p-661hnu-f1>
References: <52E3B66B-DC7A-4225-8779-8C1E9B0FC15E@holtmann.org>
 <1378454956-26605-1-git-send-email-djcb.bulk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378454956-26605-1-git-send-email-djcb.bulk@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dirk-Jan,

On Fri, Sep 06, 2013, Dirk-Jan C. Binnema wrote:
> From: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>
> 
> glibc before 2.17 (e.g., fedora 18) requires -lrt for clock_gettime;
> add -lrt where needed in that case.
> ---
>  Makefile.am  | 2 +-
>  configure.ac | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

It seems Marcel went ahead and applied his own patch for this (I think
he didn't realize there was a pending one here). Could you check if
latest git now works for you?

Johan
