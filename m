Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Feb 2011 11:54:02 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: ville.tervo@nokia.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Use proper timer for hci command timout
Message-ID: <20110216145402.GF14085@joana>
References: <1297866761-11270-1-git-send-email-ville.tervo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297866761-11270-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* ville.tervo@nokia.com <ville.tervo@nokia.com> [2011-02-16 16:32:41 +0200]:

> From: Ville Tervo <ville.tervo@nokia.com>
> 
> Use proper timer instead of hci command flow control to timeout
> failed hci commands. Otherwise stack ends up sending commands
> when flow control is used to block new commands.
> 
> 2010-09-01 18:29:41.592132 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:16:CF:E1:C7:D7 mode 2 clkoffset 0x0000
> 2010-09-01 18:29:41.592681 > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 0
> 2010-09-01 18:29:51.022033 < HCI Command: Remote Name Request Cancel (0x01|0x001a) plen 6
>     bdaddr 00:16:CF:E1:C7:D7
> 
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> ---
>  include/net/bluetooth/hci.h      |    3 +++
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_core.c         |   22 ++++++++++++++++------
>  net/bluetooth/hci_event.c        |    6 ++++++
>  4 files changed, 26 insertions(+), 7 deletions(-)

Applied to bluetooth-next, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
