Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Aug 2010 16:55:50 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	joakim.xj.ceder@stericsson.com, johan.hedberg@gmail.com
Subject: Re: [PATCH] Bluetooth: BT_SECURITY_HIGH requires 16 digit pin code
Message-ID: <20100827195550.GA11191@vigoh>
References: <1282909460-19337-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282909460-19337-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> [2010-08-27 13:44:20 +0200]:

> The security level BT_SECURITY_HIGH expects secure connection
> and a minimum 16 digit pin code used for bonding. It's requitred by the
> Sim Access Profile.
> 
> Patch on behalf of ST-Ericsson SA.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
> ---
>  include/net/bluetooth/hci.h      |   17 +++++++
>  include/net/bluetooth/hci_core.h |    4 ++
>  net/bluetooth/hci_conn.c         |   97 +++++++++++++++++++++++++++++++-------
>  net/bluetooth/hci_event.c        |    4 ++
>  net/bluetooth/hci_sock.c         |    3 +
>  net/bluetooth/rfcomm/core.c      |   10 ++++-
>  6 files changed, 116 insertions(+), 19 deletions(-)
>  mode change 100644 => 100755 include/net/bluetooth/hci.h
>  mode change 100644 => 100755 include/net/bluetooth/hci_core.h
>  mode change 100644 => 100755 net/bluetooth/hci_conn.c
>  mode change 100644 => 100755 net/bluetooth/hci_event.c
>  mode change 100644 => 100755 net/bluetooth/rfcomm/core.c

You are changing the files modes. Don't do that.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
