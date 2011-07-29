Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jul 2011 13:09:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix setting noinst_LIBRARIES in Makefile.am
Message-ID: <20110729100948.GC3880@dell>
References: <1311198469-28610-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311198469-28610-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Jul 20, 2011, Anderson Lizardo wrote:
> When both audio and sap plugins are enabled, noinst_LIBRARIES is
> incorrectly overwritten.
> ---
> NOTE: Actually, I'm not sure if audio/libtelephony.a and sap/libsap.a are being
> used at all. Any reason why they are generated? Makefile dependency resolution
> perhaps?
> 
>  Makefile.am |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
