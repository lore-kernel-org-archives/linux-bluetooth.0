Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Sep 2011 15:28:27 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 3/3 v2] client: port to gobex
Message-ID: <20110901182827.GA5919@samus.indt.org>
References: <1314870472-31983-1-git-send-email-luiz.dentz@gmail.com>
 <1314870472-31983-3-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314870472-31983-3-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 12:47 Thu 01 Sep, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This remove gwobex dependency of the client using gobex instead.
> 
> Based on initial work by Johan Hedberg <johan.hedberg@intel.com>
> ---
>  Makefile.am       |    2 +-
>  client/driver.h   |    2 +-
>  client/ftp.c      |  139 +++++++++++++------
>  client/pbap.c     |  144 ++++++++++++++------
>  client/session.c  |   76 ++++++++---
>  client/session.h  |    8 +-
>  client/sync.c     |    3 +
>  client/transfer.c |  390 ++++++++++++++++++++++++++++++----------------------
>  client/transfer.h |    5 +-
>  9 files changed, 494 insertions(+), 275 deletions(-)
> 

Great job.

Take my "Ack", may it serve you well :-)


Cheers,
-- 
Vinicius
