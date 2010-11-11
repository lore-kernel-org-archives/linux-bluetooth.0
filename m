Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 12:09:44 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix possible memory leak of the GIOChannel in the
 attribute server
Message-ID: <20101111100944.GH4132@jh-x301>
References: <1289426161-10045-1-git-send-email-claudio.takahasi@openbossa.org>
 <1289426161-10045-2-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289426161-10045-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Nov 10, 2010, Claudio Takahasi wrote:
> ---
>  src/attrib-server.c |   32 +++++++++++++++++++-------------
>  1 files changed, 19 insertions(+), 13 deletions(-)

Pushed upstream. Thanks.

Johan
