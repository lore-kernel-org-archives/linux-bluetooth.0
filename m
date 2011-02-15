Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Feb 2011 11:48:45 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Add encode/decode for write response
Message-ID: <20110215144845.GC20583@jh-x301>
References: <1297779409-32597-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297779409-32597-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Tue, Feb 15, 2011, Bruna Moreira wrote:
> The encode/decode functions for Write Response operations were created
> to keep consistency with the rest of GATT API.
> ---
>  attrib/att.c        |   21 +++++++++++++++++++++
>  attrib/att.h        |    2 ++
>  src/attrib-server.c |    4 +---
>  3 files changed, 24 insertions(+), 3 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
