Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Mar 2011 11:09:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 1/2] Use CID to infer transport type
Message-ID: <20110310090916.GA5566@jh-x301>
References: <1299083684-5062-2-git-send-email-bruna.moreira@openbossa.org>
 <1299269865-1259-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299269865-1259-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Fri, Mar 04, 2011, Bruna Moreira wrote:
> Instead of comparing GIOChannel pointers, use the CID returned by
> bt_io_get() to infer the transport type. LE uses the fixed CID for GATT.
> ---
>  src/attrib-server.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

Both patches have been pushes upstream. Thanks.

Johan
