Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Apr 2012 12:42:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 BlueZ] adapter: Fix segfault when icon is uninitialized
Message-ID: <20120403094237.GA21680@x220>
References: <1333394427-9803-1-git-send-email-bruna.moreira@openbossa.org>
 <1333397122-22456-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333397122-22456-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Mon, Apr 02, 2012, Bruna Moreira wrote:
> If device type is LE and GAP Appearance characteristic does not exist,
> the icon will not be initialized.
> ---
>  src/adapter.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
