Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Feb 2011 16:05:37 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix wrong header include on interactive gatttool
Message-ID: <20110216190537.GE21777@jh-x301>
References: <1297869099-4419-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297869099-4419-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Feb 16, 2011, Claudio Takahasi wrote:
> This wrong include is triggering compiler warning: implicit declaration
> of function 'strdup'.
> ---
>  attrib/interactive.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
