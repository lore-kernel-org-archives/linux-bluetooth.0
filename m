Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Sep 2010 19:11:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] hciconfig: add LE_SET_ADVERTISE_ENABLE cmd
Message-ID: <20100906161158.GB25826@jh-x301>
References: <1283786296-16211-1-git-send-email-anderson.briglia@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283786296-16211-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Mon, Sep 06, 2010, Anderson Briglia wrote:
> This patch implements two new hciconfig commands: leadv and noleadv.
> These new hciconfig flags are responsible to LE_SET_ADVERTISE_ENABLE
> command implementation.
> ---
>  tools/hciconfig.c |   40 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)

Thanks. The patch is now upstream.

Johan
