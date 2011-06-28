Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jun 2011 11:12:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2] Fix finalize discovery if all stream end points are
 In Use
Message-ID: <20110628081209.GG18047@dell.ger.corp.intel.com>
References: <1308837507.14190.2.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308837507.14190.2.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Jun 23, 2011, Peter Hurley wrote:
> When handling the discover response, if all stream end points are
> in use, then we must finalize discovery, as no GET_CAPABILITIES
> command will be issued.
> ---
>  audio/avdtp.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)

Applied, thanks.

Johan
