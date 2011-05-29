Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 May 2011 21:25:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Simplify options for including/excluding plugins
Message-ID: <20110529182513.GA32088@dell.ger.corp.intel.com>
References: <1306338000-7905-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306338000-7905-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, May 25, 2011, Luiz Augusto von Dentz wrote:
> Plugins options are now handle with --plugin(-p)/--noplugin(-P) which
> takes a string set containing the plugin names separated by ',',':' or
> ' 'similar to bluetoothd, ofono and connman.
> ---
>  src/main.c   |   68 +++++++++++++++------------------------------------------
>  src/obexd.h  |    2 +-
>  src/plugin.c |   51 +++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 68 insertions(+), 53 deletions(-)

All three patches have been pushed. Thanks.

Johan
