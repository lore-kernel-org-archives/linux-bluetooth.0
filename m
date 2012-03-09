Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Mar 2012 18:01:53 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v2 0/4] client: parameter naming convention
Message-ID: <20120309000153.GC19895@x220.amr.corp.intel.com>
References: <1331131829-28509-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331131829-28509-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, Mar 07, 2012, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> These patches review the naming convention in transfer.h and
> session.h, in order to avoid misleading use of the terms "name",
> "filename" and "targetname".
> 
> This second proposal splits the first patch into two patches, and
> avoids a bug that would have been introduced: the reply of the agent
> needs to be handled with care, since depending on the operation type
> (put or get) the reply of the agent should overwrite one field or the
> other.
> 
> Mikel Astiz (4):
>   client: add obc_transfer_set_filename
>   client: fix naming convention in transfer api
>   client: refactor naming convention in session api
>   client: simplify obc_session_pull
> 
>  client/session.c  |   55 ++++++++++++++++++----------------------------------
>  client/session.h  |   12 +++++-----
>  client/transfer.c |   14 +++++++++---
>  client/transfer.h |    2 +
>  4 files changed, 37 insertions(+), 46 deletions(-)

All patches in this set have been applied. Thanks.

Johan
