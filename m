Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Jul 2011 10:41:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] avrcp: remove unused dbus reply message
Message-ID: <20110710074134.GA30472@dell.ger.corp.intel.com>
References: <1309897486-20006-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309897486-20006-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Jul 05, 2011, Lucas De Marchi wrote:
> Fix leak of dbus messages being created but not unreferenced after
> method returns.
> ---
>  audio/control.c |   10 ----------
>  1 files changed, 0 insertions(+), 10 deletions(-)

Applied. Thanks.

Johan
