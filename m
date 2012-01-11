Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jan 2012 15:58:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/4] gobex: handle Single Response Mode (SRM)
 headers
Message-ID: <20120111135802.GC27506@x220>
References: <1325598744-18855-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325598744-18855-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jan 03, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Single Response Mode (SRM) is a 1-byte quantity containing a value to
> enable or disable SRM, as well as to indicate support for SRM.
> ---
>  gobex/gobex-transfer.c |   54 ++++++++++++--
>  gobex/gobex.c          |  194 +++++++++++++++++++++++++++++++++++++++++-------
>  gobex/gobex.h          |    1 +
>  3 files changed, 216 insertions(+), 33 deletions(-)

Since the rather long discussion with Hendrik doesn't seem to have
changed your mind about the correctness of these patches I've now
applied them upstream :)

Johan
