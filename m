Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 12:10:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Optimise call history queries
Message-ID: <20110614091010.GB31529@dell.ger.corp.intel.com>
References: <1308035340-4027-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308035340-4027-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Tue, Jun 14, 2011, Slawomir Bochenski wrote:
> This changes order of graph pattern elements, moving OPTIONAL block to
> the end of the query. This gives a dramatic performance improvement.
> ---
>  plugins/phonebook-tracker.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
