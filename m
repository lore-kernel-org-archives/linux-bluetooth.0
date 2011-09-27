Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:48:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v3 1/3] Extend functions parameter list for vCard's
 format
Message-ID: <20110927094826.GM3952@dell>
References: <1315487540-16607-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315487540-16607-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Thu, Sep 08, 2011, Rafal Michalski wrote:
> This patch extends some functions ("get_escaped_fields" and some from
> "vcard_printf_*" family) parameter list for format value, since it would
> be needed to select escaping and encoding method, depending on vCard's
> type (vCard 2.1 or vCard 3.0).
> ---
>  plugins/vcard.c |   23 ++++++++++++-----------
>  1 files changed, 12 insertions(+), 11 deletions(-)

All three patches applied. Thanks.

Johan
