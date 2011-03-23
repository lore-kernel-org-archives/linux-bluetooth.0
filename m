Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Mar 2011 15:07:44 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix ATT error code response for authentication
Message-ID: <20110323130744.GA7124@jh-x301>
References: <1300827081-31136-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300827081-31136-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Mar 22, 2011, Claudio Takahasi wrote:
> This patch fix the error code in the Error Response PDU. If an attribute
> requires authentication and the link security level doesn't meet the
> requirements the server should reply Insufficient Authentication(0x05).
> ---
>  src/attrib-server.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

Pushed upstream. Thanks.

Johan
