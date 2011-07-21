Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: Szymon Janc <szymon@janc.net.pl>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 21 Jul 2011 12:14:43 -0400
Subject: Re: [PATCH] Bluetooth: Increase command tx timeout
Message-ID: <1311264883.17476.65.camel@THOR>
References: <1311189131-8592-1-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1311189131-8592-1-git-send-email-szymon@janc.net.pl>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, 2011-07-20 at 15:12 -0400, Szymon Janc wrote:
> Some CSR chips require more time for HCI reset command to complete.
> Too short timeout caused next command being sent before reset
> complete event resulting in
> [23101.792031] hci_cmd_timer: hci0 command tx timeout
> [23102.792046] hci_cmd_timer: hci0 command tx timeout
> after pluging in dongle and non functional bt.
> 
> Signed-off-by: Szymon Janc <szymon@janc.net.pl>
> ---
>  include/net/bluetooth/hci.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index be30aab..12a527c 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -121,7 +121,7 @@ enum {
>  #define HCI_PAIRING_TIMEOUT	(60000)	/* 60 seconds */
>  #define HCI_IDLE_TIMEOUT	(6000)	/* 6 seconds */
>  #define HCI_INIT_TIMEOUT	(10000)	/* 10 seconds */
> -#define HCI_CMD_TIMEOUT		(1000)	/* 1 seconds */
> +#define HCI_CMD_TIMEOUT		(3000)	/* 3 seconds */
>  
>  /* HCI data types */
>  #define HCI_COMMAND_PKT		0x01

Respectfully, I disagree that this is the correct fix for this problem.

After an HCI_Reset, *no* hci commands should be issued until after the
*successful* Command Complete is received. IMHO, the current code
suffers two defects:
  - it doesn't wait for Command Complete after the Reset command is sent
  - it ignores the result code from that Command Complete

I believe the proper fix is to _loop_ over the HCI_Reset until a
successful Command Complete is received.

Regards,
Peter

 
