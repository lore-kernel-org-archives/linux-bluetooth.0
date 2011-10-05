Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Oct 2011 11:18:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] Fix wrong write GATT-subprocedure for Link Loss
Message-ID: <20111005081859.GA11882@fusion.localdomain>
References: <1317748963-13176-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317748963-13176-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Oct 04, 2011, Claudio Takahasi wrote:
> According to Link Loss Service specification, Write Characteristic
> Value sub-procedure should be used to change the Alert Level.
> ---
>  proximity/monitor.c |   25 +++++++++++++++++++++----
>  1 files changed, 21 insertions(+), 4 deletions(-)

Both patches applied. Thanks.

Johan
