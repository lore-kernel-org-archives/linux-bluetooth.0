Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Feb 2012 15:07:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v2 2/6] client: fix unreported error case
Message-ID: <20120216130747.GA16080@x220.ger.corp.intel.com>
References: <1329230829-27046-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1329230829-27046-3-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329230829-27046-3-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Feb 14, 2012, Mikel Astiz wrote:
> +		if (p->func) {
> +			GError *gerr;
> +
> +			g_set_error(&gerr, OBEX_IO_ERROR, err,
> +							"Authorization failed");

This is wrong. You must initialize gerr to NULL before passing a pointer
to it to g_set_error. From the GLib documentation:

	"if err is non-NULL, then *err must be NULL"

Johan
