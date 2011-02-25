Return-Path: <cyrus@holtmann.org>
Message-ID: <4D67E50D.8050302@codeaurora.org>
Date: Fri, 25 Feb 2011 09:21:17 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: [bluetooth-next 00/15] SMP Just Works Implementation
References: <cover.1298307667.git.vinicius.gomes@openbossa.org>
In-Reply-To: <cover.1298307667.git.vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo, Vinicius,

I would like to add my support for promoting these LE Security Manager 
patches into the bluetooth-next tip.

On 2/21/2011 9:23 AM, Vinicius Costa Gomes wrote:
> Hi,
>
> This patch series implement the Just Works SMP procedures for LE links.
>
> These patches can also be reached from here[1].
>
>
> Cheers,
> --
> Vinicius
>
> [1] http://git.infradead.org/users/vcgomes/linux-2.6.git (for-next branch)
>
> Anderson Briglia (7):
>    Bluetooth: Implement the first SMP commands
>    Bluetooth: Start SMP procedure
>    Bluetooth: simple SMP pairing negotiation
>    Bluetooth: LE SMP Cryptoolbox functions
>    Bluetooth: Add SMP confirmation structs
>    Bluetooth: Add SMP confirmation checks methods
>    Bluetooth: Minor fix in SMP methods
>
> Vinicius Costa Gomes (8):
>    Bluetooth: Add support for using the crypto subsystem
>    Bluetooth: Add support for LE Start Encryption
>    Bluetooth: Add support for resuming socket when SMP is finished
>    Bluetooth: Fix initial security level of LE links
>    Bluetooth: Update the security level when link is encrypted
>    Bluetooth: Add support for Pairing features exchange
>    Bluetooth: Add support for SMP timeout
>    Bluetooth: Add key size checks for SMP
>
>   include/net/bluetooth/hci.h      |   34 +++
>   include/net/bluetooth/hci_core.h |   10 +
>   include/net/bluetooth/l2cap.h    |    9 +
>   include/net/bluetooth/smp.h      |   46 ++++
>   net/bluetooth/Kconfig            |    6 +
>   net/bluetooth/Makefile           |    2 +-
>   net/bluetooth/hci_conn.c         |   47 ++++
>   net/bluetooth/hci_core.c         |   22 ++
>   net/bluetooth/hci_event.c        |   69 +++++
>   net/bluetooth/l2cap_core.c       |  137 ++++++----
>   net/bluetooth/l2cap_sock.c       |   17 ++
>   net/bluetooth/smp.c              |  535 ++++++++++++++++++++++++++++++++++++++
>   12 files changed, 876 insertions(+), 58 deletions(-)
>   create mode 100644 net/bluetooth/smp.c
>
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
