Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Nov 2013 10:39:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] gdbus: Don't try to remove removed sources
Message-ID: <20131111083921.GB4541@x220.p-661hnu-f1>
References: <1384016577.3880.36.camel@nuvo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384016577.3880.36.camel@nuvo>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sat, Nov 09, 2013, Bastien Nocera wrote:
> When we return FALSE from idle handlers, the source is removed.
> This will be causing warnings in glib 2.40.
> 
> See https://bugzilla.gnome.org/show_bug.cgi?id=710724
> ---
>  gdbus/object.c | 3 +++
>  1 file changed, 3 insertions(+)

This patch has been applied. Thanks.

Johan
