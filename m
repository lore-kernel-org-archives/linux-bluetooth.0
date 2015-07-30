Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH 1/2] Bluetooth: Add BT_HS config option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1437729175-16824-1-git-send-email-arron.wang@intel.com>
Date: Thu, 30 Jul 2015 13:34:30 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9B7AB04A-3FF7-41DA-ACA1-775684DEA813@holtmann.org>
References: <1437729175-16824-1-git-send-email-arron.wang@intel.com>
To: Arron Wang <arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arron,

> Move A2MP Module under BT_HS config option and allow
> the user have flexible option to choose the feature only
> they need
> 
> a2mp_discover_amp() & a2mp_channel_create() are a2mp module
> entry point for master and slave, and this is dynamic
> invoked depends on the userspace or remote request, then
> we defined their implementation depends on BT_HS config
> 
> Signed-off-by: Arron Wang <arron.wang@intel.com>
> ---
> net/bluetooth/Kconfig  |    5 +++++
> net/bluetooth/Makefile |    3 ++-
> net/bluetooth/a2mp.h   |   19 +++++++++++++++++++
> net/bluetooth/amp.h    |   14 ++++++++++++++
> 4 files changed, 40 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

