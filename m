Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Aug 2014 09:11:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv5 1/3] tools: Fix memory leak
Message-ID: <20140804061154.GA9924@t440s.P-661HNU-F1>
References: <20140801103830.GC24358@t440s.P-661HNU-F1>
 <1406892371-32504-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406892371-32504-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Aug 01, 2014, Andrei Emeltchenko wrote:
> lmpver and hciver are allocated through malloc and need to be freed.
> ---
>  tools/parser/hci.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

All three patches have been applied. Thanks.

Johan
