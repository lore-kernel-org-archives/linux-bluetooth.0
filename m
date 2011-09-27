Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 11:28:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] Fix adapter->up declaration
Message-ID: <20110927082814.GG3952@dell>
References: <1315829192-30924-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315829192-30924-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Sep 12, 2011, Claudio Takahasi wrote:
> Minor code convention fix. This patch fix "up" variable declaration in
> adapter structure. Convert "up" to gboolean making it compliant with
> its usage.
> ---
>  src/adapter.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

All three patches applied. Thanks.

Johan
