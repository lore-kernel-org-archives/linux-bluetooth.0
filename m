Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Aug 2012 12:27:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 1/3] att: Add prepare write support
Message-ID: <20120815092707.GA25877@x220>
References: <1343420976-19921-1-git-send-email-eder.ruiz@openbossa.org>
 <1343669655-12586-1-git-send-email-eder.ruiz@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343669655-12586-1-git-send-email-eder.ruiz@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eder,

On Mon, Jul 30, 2012, Eder Ruiz Maria wrote:
> Add functions for encoding/decoding Prepare Write Request and
> Response PDUs.
> ---
>  attrib/att.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  attrib/att.h |    5 +++++
>  2 files changed, 59 insertions(+)

All three patches have been applied. Thanks.

I also went ahead and finally updated the entire attrib code base to use
proper size_t, ssize_t, off_t etc variables where appropriate. This
means that any unapplied attrib patches may need rebasing (and fixing to
follow the same convention).

Johan
