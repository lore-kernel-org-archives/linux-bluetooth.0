Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Apr 2012 13:07:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/7] Add address type to L2CAP socket
Message-ID: <20120425100702.GA26311@x220>
References: <1335318151-21063-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335318151-21063-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Apr 24, 2012, Claudio Takahasi wrote:
> Dependency: "[PATCH 0/8] LE Connection"
> 
> Rebased version of the previous RFC: "[RFC BlueZ v1 1/7] Add Bluetooth
> address type in sockaddr_l2"
> 
> Andre Guedes (1):
>   l2test: Add option to inform the address type
> 
> Claudio Takahasi (6):
>   Add Bluetooth address type in sockaddr_l2
>   btio: Add address type in bt_io_connect
>   Add address type for BLE bt_io_connect calls
>   Remove leftover field in remote_dev_info struct
>   Remove addr_type_t definition from adapter.h
>   Remove MGMT address type definition
> 
>  btio/btio.c       |   21 +++++++++++---
>  btio/btio.h       |    1 +
>  lib/bluetooth.h   |    5 +++
>  lib/l2cap.h       |    1 +
>  lib/mgmt.h        |    5 ---
>  mgmt/main.c       |   26 +++++++++---------
>  plugins/hciops.c  |   51 ++++++++++++++++++----------------
>  plugins/mgmtops.c |   77 +++++++++++++++++-----------------------------------
>  src/adapter.c     |   70 ++++++++++++++++++++++++-----------------------
>  src/adapter.h     |   45 +++++++++++++------------------
>  src/device.c      |   59 +++++++++++++++++++++-------------------
>  src/device.h      |    6 ++--
>  src/event.c       |   29 ++++++++++---------
>  src/event.h       |    6 ++--
>  test/l2test.c     |   27 +++++++++++++++++-
>  15 files changed, 221 insertions(+), 208 deletions(-)

All patches in this set have been applied. Thanks.

Johan
