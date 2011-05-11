Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 May 2011 15:01:44 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Double check sec req for pre 2.1 device
Message-ID: <20110511180144.GF22065@joana>
References: <1304667751-21670-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304667751-21670-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> [2011-05-06 09:42:31 +0200]:

> In case of pre v2.1 devices authentication request will return
> success immediately if the link key already exists without any
> authentication process.
> 
> That means, it's not possible to re-authenticate the link if you
> already have combination key and for instance want to re-authenticate
> to get the high security (use 16 digit pin).
> 
> Therefore, it's necessary to check security requirements on auth
> complete event to prevent not enough secure connection.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_conn.c         |   17 +++++++++++++++++
>  net/bluetooth/rfcomm/core.c      |    2 +-
>  3 files changed, 19 insertions(+), 1 deletions(-)

Patch has been applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
