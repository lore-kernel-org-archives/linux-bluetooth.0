Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jan 2012 15:02:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix memory leak when loading keys
Message-ID: <20120124130240.GA30801@x220>
References: <1327364511-6348-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327364511-6348-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Jan 23, 2012, Vinicius Costa Gomes wrote:
> If we need a copy of those keys we should copy them.
> ---
>  plugins/hciops.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)

Applied. Thanks.

In the future, could you please try to adopt the commit summary naming
convention we've started using where there's a short prefix to highlight
the part of the code the patch relates to. In this this case it should
have been "hciops: ...".

Johan
