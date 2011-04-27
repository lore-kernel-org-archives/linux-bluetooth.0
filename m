Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Apr 2011 16:25:53 -0700
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Use HCI_MAX_EIR_LENGTH instead of hard-coded value
Message-ID: <20110427232552.GC26404@jh-x301>
References: <1303935663-31142-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1303935663-31142-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Wed, Apr 27, 2011, Bruna Moreira wrote:
> ---
> 
> NOTE: the constants EIR_DATA_LENGTH and HCI_MAX_EIR_LENGTH are duplicated.
> This will be fixed in next patches of discovery cleanup.
> 
>  lib/hci.c         |    4 ++--
>  plugins/hciops.c  |    2 +-
>  src/storage.c     |    4 ++--
>  test/hciemu.c     |    6 +++---
>  tools/hciconfig.c |   10 +++++-----
>  5 files changed, 13 insertions(+), 13 deletions(-)

Applied. Thanks.

Johan
