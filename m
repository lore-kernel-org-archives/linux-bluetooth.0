Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Feb 2011 00:29:28 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Add hcitool command to change the parameters of a
 given LE connection
Message-ID: <20110223032928.GF16014@jh-x301>
References: <1298410927-9165-1-git-send-email-claudio.takahasi@openbossa.org>
 <1298410927-9165-3-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298410927-9165-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Feb 22, 2011, Claudio Takahasi wrote:
> Allows the LE master to start the Connection Parameter Update Procedure.
> Parameters values consistency are not verified on purpose allowing
> invalid values to test fail scenarios.
> ---
>  tools/hcitool.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++

All three patches have been pushed upstream. Thanks.

Johan
