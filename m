Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Dec 2010 10:56:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/10] More btd_error_* patches
Message-ID: <20101214085621.GA1713@jh-x301>
References: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Dec 13, 2010, Gustavo F. Padovan wrote:
> This patch set adds a new error function btd_error_failed(), which has a str
> parameter to enable a more accurate error report in the case the usual
> btd_error_* does not fit.
> 
> After this patch set there will 10 occurrences of g_dbus_create_error() inside
> bluez code (not counting health/ here)

Thanks. The patches are now upstream. However, I did have to push other
fixes on top of them since a few functions that you assumed were
returning a proper negative errno value were in fact only returning -1.

Johan
