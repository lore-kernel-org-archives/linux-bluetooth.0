Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Mar 2014 16:54:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v1 0/9] GATT API: Add Register Services Async
Message-ID: <20140306145410.GA2435@localhost.P-661HNU-F1>
References: <CAKT1EBfVP_aYMDFdK+vqBxOKEZh2tdfasKkEks4v5H6h-ZXerw@mail.gmail.com>
 <1394113467-24331-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394113467-24331-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Mar 06, 2014, Claudio Takahasi wrote:
> This patchset is an extension of "[PATCH BlueZ v7 00/11] GATT API:
> External Services". It adds the following features:
>   * new gdbus helper to allow notifying the clients when
>     GetManagedObjects() reply is received and all proxies reported to
>     upper-layer.
>   * reply for RegisterService() after validating fetched objects
>   * adds the service declaration to the local GATT database
> 
> * Changes from v0 to v1:
>   - renames g_dbus_client_set_proxies_ready_watch() to
>     g_dbus_client_set_ready_watch()
> 
> Claudio Takahasi (9):
>   gdbus: Add g_dbus_client_set_ready_watch()
>   gatt: Add proxy added handler
>   gatt: Add proxy removed handler
>   gatt: Add GATT service to the local database
>   gatt: Make RegisterService() async
>   test: Add external service GATT skeleton
>   test: Add signal handling for gatt-service
>   test: Add registering external service
>   bluetooth.conf: Add ObjectManager interface
> 
>  .gitignore          |   1 +
>  Makefile.tools      |   5 +
>  gdbus/client.c      |  17 ++++
>  gdbus/gdbus.h       |   4 +-
>  src/bluetooth.conf  |   1 +
>  src/gatt-dbus.c     | 135 +++++++++++++++++++++++++-
>  test/gatt-service.c | 267 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 425 insertions(+), 5 deletions(-)
>  create mode 100644 test/gatt-service.c

All patches in the set have been applied. Thanks.

Johan
