Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180904103922.25504-1-luiz.dentz@gmail.com>
References: <20180904103922.25504-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Sep 2018 12:26:19 +0300
Message-ID: <CABBYNZJ-Ry4JN_f9sxFVAhHcQ5BY7LMdgeZ=tSpt9WFKr_QYpA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Bluetooth: L2CAP: Improve credits logic
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 4, 2018 at 1:39 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> These changes replace the existing threshold logic with a limpler logic
> that gives back credits after receiving an SDU. It also removes the
> debugfs entries to configure the MPS and credits with auto selected one
> derived from the MTU and MPS.
>
> v2: Account from the SDU length when adjusting the MPS.
>
> Luiz Augusto von Dentz (3):
>   Bluetooth: L2CAP: Derive MPS from connection MTU
>   Bluetooth: L2CAP: Derive rx credits from MTU and MPS
>   Bluetooth: L2CAP: Detect if remote is not able to use the whole MPS
>
>  include/net/bluetooth/l2cap.h |  3 --
>  net/bluetooth/l2cap_core.c    | 66 +++++++++++++++++++++++------------
>  2 files changed, 44 insertions(+), 25 deletions(-)

Ping.

-- 
Luiz Augusto von Dentz
