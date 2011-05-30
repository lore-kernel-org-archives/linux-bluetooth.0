Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 May 2011 18:04:44 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Do not send SET_EVENT_MASK for 1.1 and
 earlier devices
Message-ID: <20110530210444.GH2556@joana>
References: <1306484181-2615-1-git-send-email-ville.tervo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306484181-2615-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Ville Tervo <ville.tervo@nokia.com> [2011-05-27 11:16:21 +0300]:

> Some old hci controllers do not accept any mask so leave the
> default mask on for these devices.
> 
> < HCI Command: Set Event Mask (0x03|0x0001) plen 8
>     Mask: 0xfffffbff00000000
> > HCI Event: Command Complete (0x0e) plen 4
>     Set Event Mask (0x03|0x0001) ncmd 1
>     status 0x12
>     Error: Invalid HCI Command Parameters
> 
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> ---
>  net/bluetooth/hci_event.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)

Applied to bluetooth-2.6. Thanks all.

-- 
Gustavo F. Padovan
http://profusion.mobi
