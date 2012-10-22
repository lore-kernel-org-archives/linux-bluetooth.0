Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Oct 2012 13:08:47 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5 v2] Bluetooth: Add initial support for LE-only
 controllers
Message-ID: <20121022100845.GA14263@aemeltch-MOBL1>
References: <1350669469-7719-1-git-send-email-johan.hedberg@gmail.com>
 <1350669469-7719-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350669469-7719-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Oct 19, 2012 at 08:57:45PM +0300, Johan Hedberg wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch splits off most the HCI init sequence commands from a fixed
> set into a conditional one that is sent once the HCI_Read_Local_Features
> and HCI_Read_Local_Version_Information commands complete. This is
> necessary since many of the current fixed commands are not allowed for
> LE-only controllers.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c  |   47 ------------------------------------
>  net/bluetooth/hci_event.c |   58 +++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 53 insertions(+), 52 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 0ec776a..dd05ed0 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -178,48 +178,13 @@ static void hci_reset_req(struct hci_dev *hdev, unsigned long opt)
>  
>  static void bredr_init(struct hci_dev *hdev)
>  {
> -	struct hci_cp_delete_stored_link_key cp;
> -	__le16 param;
> -	__u8 flt_type;
> -

...

> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 0383635..f4f0b8b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c

...

> +static void bredr_init(struct hci_dev *hdev)
> +{

Is this a good idea to have two functions with the same names? Even static
ones.

Best regards 
Andrei Emeltchenko 
