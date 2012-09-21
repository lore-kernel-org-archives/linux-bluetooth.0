Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Sep 2012 16:19:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] gatt: Delay D-Bus reply on char discovery
Message-ID: <20120921131927.GA15946@x220>
References: <1347353240-1942-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347353240-1942-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Tue, Sep 11, 2012, chen.ganir@ti.com wrote:
> Delay sending the D-Bus reply for the discover_characteristics
> command. The D-Bus reply for characteristics is sent before all
> the relevant characteristic information is gathered. This can
> cause problems, when trying to get characteristic information too
> soon. This patch moves the D-Bus reply to the end of the char
> discovery process. Only after all descriptors are discovered and
> read, the D-Bus reply is sent.
> ---
>  attrib/client.c |  138 +++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 93 insertions(+), 45 deletions(-)

This one needs to be rebased against latest git (I think the
btd_get_dbus_connection patch broke it).

Johan
