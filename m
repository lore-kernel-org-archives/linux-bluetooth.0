Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: Add sockaddr length checks before accessing
 sa_family in bind and connect handlers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170629120459.16937-1-mjurczyk@google.com>
Date: Thu, 29 Jun 2017 14:38:34 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <838A10A8-41D2-41B4-BAAD-BD8FFE84260D@holtmann.org>
References: <20170629120459.16937-1-mjurczyk@google.com>
To: Mateusz Jurczyk <mjurczyk@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mateusz,

> Verify that the caller-provided sockaddr structure is large enough to
> contain the sa_family field, before accessing it in bind() and connect()
> handlers of the Bluetooth sockets. Since neither syscall enforces a minimum
> size of the corresponding memory region, very short sockaddrs (zero or one
> byte long) result in operating on uninitialized memory while referencing
> sa_family.
> 
> Signed-off-by: Mateusz Jurczyk <mjurczyk@google.com>
> ---
> net/bluetooth/l2cap_sock.c  | 5 +++--
> net/bluetooth/rfcomm/sock.c | 3 ++-
> net/bluetooth/sco.c         | 6 ++----
> 3 files changed, 7 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

