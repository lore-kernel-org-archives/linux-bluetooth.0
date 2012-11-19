Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] bluetooth: Increase HCI command tx timeout
Date: Mon, 19 Nov 2012 10:46:25 +0100
Message-ID: <1370568.JbBC3GLxi1@uw000953>
In-Reply-To: <1352714465-17015-1-git-send-email-szymon.janc@tieto.com>
References: <1352714465-17015-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 12 of November 2012 12:01:05 Janc Szymon wrote:
> Read Local OOB Data command can take more than 1 second on some chips.
> e.g. on CSR 0a12:0001 first call to Read Local OOB Data after reset
> takes about 1300ms resulting in tx timeout error.
> 
> [27698.368655] Bluetooth: hci0 command 0x0c57 tx timeout
> 
> 2012-10-31 15:53:36.178585 < HCI Command: Read Local OOB Data (0x03|0x0057) plen 0
> 2012-10-31 15:53:37.496996 > HCI Event: Command Complete (0x0e) plen 36
>     Read Local OOB Data (0x03|0x0057) ncmd 1
>     status 0x00
>     hash 0x92219d9b447f2aa9dc12dda2ae7bae6a
>     randomizer 0xb1948d0febe4ea38ce85c4e66313beba
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
> 
> Spec doesn't seem to be posing any restrictions on how fast should HCI response...
> I've increased timeout to 2 secs as this seems to fix this for me, but maybe this
> could be increased to something more, like 5 secs or sth to minimize tx timeout
> chance for other slow chips?  If chip doesn't response for command it is FUBAR
> anyway and having longer timeout would not make things that much worse (and
> could even improve things on slow chips..).
> 
> 
>  include/net/bluetooth/hci.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 4bbabd8..45eee08 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -154,7 +154,7 @@ enum {
>  #define HCI_DISCONN_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
>  #define HCI_PAIRING_TIMEOUT	msecs_to_jiffies(60000)	/* 60 seconds */
>  #define HCI_INIT_TIMEOUT	msecs_to_jiffies(10000)	/* 10 seconds */
> -#define HCI_CMD_TIMEOUT		msecs_to_jiffies(1000)	/* 1 second */
> +#define HCI_CMD_TIMEOUT		msecs_to_jiffies(2000)	/* 2 seconds */
>  #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
>  #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
>  
> 

ping
