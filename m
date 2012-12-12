Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Dec 2012 14:02:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 01/11] obexd: Port bluetooth plugin to use external
 profile support
Message-ID: <20121212120236.GA11264@x220.ger.corp.intel.com>
References: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Dec 12, 2012, Luiz Augusto von Dentz wrote:
> This changes obexd to use ProfileManager.RegisterProfile
> ---
>  obexd/plugins/bluetooth.c | 696 ++++++++++++++--------------------------------
>  1 file changed, 212 insertions(+), 484 deletions(-)

All patches in this set have been applied. I also removed the service
plugin in the same go as now all known users of it are gone.

Johan
