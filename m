Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 16:35:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove unnecessary assignment
Message-ID: <20110714133531.GA2770@dell.ger.corp.intel.com>
References: <1310490718-16776-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310490718-16776-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Jul 12, 2011, Claudio Takahasi wrote:
> D-Bus connection is set by the callers of the discover primary service
> function on both situations: create device without bonding or after
> bonding complete.
> ---
>  src/device.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
