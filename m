Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 12:41:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 BlueZ] gatttool: Update interactive prompt if
 connection is lost
Message-ID: <20120328094103.GD28310@x220>
References: <1332516126-6665-1-git-send-email-jefferson.delfes@openbossa.org>
 <1332854515-22080-1-git-send-email-jefferson.delfes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332854515-22080-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

On Tue, Mar 27, 2012, Jefferson Delfes wrote:
> In interactive mode, when connection is lost, the prompt used to remain
> in "connected" state. This patch fixes that case, by always showing the
> actual connection state.
> ---
>  attrib/interactive.c |   39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)

Applied. Thanks.

Johan
