Return-Path: <cyrus@holtmann.org>
Date: Sun, 3 Jul 2011 14:44:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] avrcp: mark signals as deprecated
Message-ID: <20110703114445.GD10186@dell.ger.corp.intel.com>
References: <1309646531-3681-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309646531-3681-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Sat, Jul 02, 2011, Gustavo F. Padovan wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> 
> Connected and Disconnected are deprecated signals
> ---
>  doc/control-api.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Why do you think these should be deprecated? Right now there are no
other signals available in the org.bluez.Control interface that'd give
the same information.

Johan
