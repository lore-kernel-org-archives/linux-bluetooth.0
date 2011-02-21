Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Feb 2011 13:57:46 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix Find by Type Response with start == end grp
 handle
Message-ID: <20110221165746.GB9130@jh-x301>
References: <1298299014-31175-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298299014-31175-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Mon, Feb 21, 2011, Bruna Moreira wrote:
> Find by type value response in attribute server was in loop when the
> start/end grp handles from a primary service had same values.
> 
> Initializing end grp handle with start handle makes the special check
> when end grp handle was zero unnecessary so it was removed.
> ---
>  src/attrib-server.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
