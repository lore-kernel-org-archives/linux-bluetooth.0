Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Aug 2011 13:23:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix memory allocation in Proximity Monitor
Message-ID: <20110808102325.GB14171@dell>
References: <1312381533-20485-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312381533-20485-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Aug 03, 2011, Claudio Takahasi wrote:
> textfile get functions returns memory allocated using malloc. String
> is now being re-allocated using glib functions to keep the code standard
> in the Proximity Monitor code.
> ---
>  proximity/monitor.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
