Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331131829-28509-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331131829-28509-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 8 Mar 2012 12:28:21 +0200
Message-ID: <CABBYNZJF8U8tTNhoAfb6X8YR=tyHn-jfQ1NvfwoE620E2=TikA@mail.gmail.com>
Subject: Re: [PATCH obexd v2 0/4] client: parameter naming convention
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, Mar 7, 2012 at 4:50 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> These patches review the naming convention in transfer.h and session.h, in order to avoid misleading use of the terms "name", "filename" and "targetname".
>
> This second proposal splits the first patch into two patches, and avoids a bug that would have been introduced: the reply of the agent needs to be handled with care, since depending on the operation type (put or get) the reply of the agent should overwrite one field or the other.
>
> Mikel Astiz (4):
>  client: add obc_transfer_set_filename
>  client: fix naming convention in transfer api
>  client: refactor naming convention in session api
>  client: simplify obc_session_pull
>
>  client/session.c  |   55 ++++++++++++++++++----------------------------------
>  client/session.h  |   12 +++++-----
>  client/transfer.c |   14 +++++++++---
>  client/transfer.h |    2 +
>  4 files changed, 37 insertions(+), 46 deletions(-)
>
> --
> 1.7.6.5

Ack.

-- 
Luiz Augusto von Dentz
