Return-Path: <cyrus@holtmann.org>
Date: Sat, 5 Jan 2013 10:51:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Remove leftover from pending_uuids removal
Message-ID: <20130105085138.GA21219@x220.P-661HNU-F1>
References: <1357352134-19573-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357352134-19573-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Jan 04, 2013, Anderson Lizardo wrote:
> The struct controller_info "pending_uuids" field was removed on commit
> 1dd77eda25aae5ed963683dfc125d3ef01187eba.
> ---
>  src/mgmt.c |    9 ---------
>  1 file changed, 9 deletions(-)

Applied. Thanks.

Johan
