Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 23:16:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/9] Create btd_error_invalid_args()
Message-ID: <20101207211600.GA26977@jh-x301>
References: <1291662648-10651-1-git-send-email-padovan@profusion.mobi>
 <20101207210511.GB25558@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101207210511.GB25558@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Dec 07, 2010, Johan Hedberg wrote:
> This as well as the second patch (ERROR_NOT_SUPPORTED) have been pushed
> upstream.

Actually I messed up with which patch is which and also pushed the one I
didn't really like (the NOT_SUPPORTED one). So all nine patches are now
upstream. However, as I pointed out in the other mail, please consider
the drawback of making completely generic functions for all errors. In
some cases it might make sense to att least be able to provide a context
specific custom message (and I'd be glad to accept patches that do
that).

Johan
