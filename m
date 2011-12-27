Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Dec 2011 12:05:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] Fix GAttrib ref counting in Generic Attribute
Message-ID: <20111227100555.GB5584@x220.P-661HNU-F1>
References: <1324503710-29815-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324503710-29815-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Dec 21, 2011, Claudio Takahasi wrote:
> Although ATT connection callbacks control GAttrib reference, each
> entity using GAttrib should be increment the GAttrib reference to
> keep the code standard.
> ---
>  attrib/client.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)

Both patches have been applied. Thanks.

Johan
