Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Dec 2010 23:57:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add LE read supported states for hciconfig
Message-ID: <20101229215717.GA20485@jh-x301>
References: <1293657444-9911-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293657444-9911-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Dec 29, 2010, Claudio Takahasi wrote:
> Displays the states and state combinations that the link layer
> supports. Usage: hciconfig hcix lestates
> ---
>  tools/hciconfig.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 89 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
