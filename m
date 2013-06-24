Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Jun 2013 11:14:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3 5/5] client: prettify help table
Message-ID: <20130624081422.GB16051@x220>
References: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1371824255-3071-5-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371824255-3071-5-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Fri, Jun 21, 2013, Lucas De Marchi wrote:
> cmd + options have a maximum length of 25. Align the description
> after this value. In order not to reach 80 chars so easily change the
> first \t to 2 spaces, like is done in udev, kmod, systemd, etc.
> ---
>  client/main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Patches 2-5 have been applied. Thanks.

Johan
