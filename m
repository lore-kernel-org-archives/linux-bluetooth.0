Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Jul 2011 10:33:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/11] On demand connection in Generic Attribute
Message-ID: <20110727073338.GA24540@dell>
References: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Jul 12, 2011, Claudio Takahasi wrote:
> Dependency:"[PATCH BlueZ 00/12] On demand connection management"
> 
> The following patch series contains cleanups in the Generic Attribute
> code and it uses the mechanism based on registered connection callbacks
> to manage connections.
> 
> Watchers register connection callback to allow receiving notifications. If
> watchers are not registered and other GATT based profile doesn't require
> an active connection, callbacks can be unregistered. SetProperty and
> DiscoverCharacteristics methods request on demand connection if necessary.
> 
> Claudio Takahasi (11):
>   Remove not necessary data from gatt_service
>   Remove storing device path in gatt_service
>   Remove leftover D-Bus message in gatt_service
>   Cleanup of primary service registration
>   Cleanup of primary service structs
>   Register the ATT connection callbacks
>   Remove implicit connection from generic API
>   Change GAttrib ref counting in Generic Attribute
>   Register ATT connection callback based on watchers
>   On demand connection for characteristics discovery
>   Add on demand characteristic write
> 
>  attrib/client.c |  593 ++++++++++++++++++++++++++----------------------------
>  attrib/client.h |    2 +-
>  src/device.c    |    2 +-
>  3 files changed, 288 insertions(+), 309 deletions(-)

This patch set has been pushed upstream. Thanks.

Johan
