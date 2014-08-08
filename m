Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 0/4] Bluetooth: Convert SMP to use l2cap_chan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407479838-5652-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 8 Aug 2014 10:47:36 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1320930F-C0A3-4CAE-A4FD-D160D26A2493@holtmann.org>
References: <1407479838-5652-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> With this patches we do the initial conversion of SMP to use l2cap_chan
> and its related callbacks. There are many more simplifications possible
> after this, but to keep the conversion minimal I haven't done those yet.
> To keep the code compiling and functional between each patch the code
> that introduces the initial callbacks uses a custom 0x1f CID not to
> intefere with the legacy SMP CID handling. Only in the last patch which
> adds fully functional SMP handling through l2cap_chan is this custom CID
> converted back to the proper L2CAP_CID_SMP.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (4):
>      Bluetooth: Add more L2CAP convenience callbacks
>      Bluetooth: Add SMP L2CAP channel skeleton
>      Bluetooth: Make AES crypto context private to SMP
>      Bluetooth: Convert SMP to use l2cap_chan infrastructure
> 
> include/net/bluetooth/hci_core.h |   2 +-
> include/net/bluetooth/l2cap.h    |  27 +++-
> net/bluetooth/hci_core.c         |  13 +-
> net/bluetooth/l2cap_core.c       |  10 --
> net/bluetooth/smp.c              | 280 +++++++++++++++++++++++++++--------
> net/bluetooth/smp.h              |   6 +-
> 6 files changed, 248 insertions(+), 90 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

