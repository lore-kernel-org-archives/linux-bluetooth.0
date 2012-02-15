Return-Path: <cyrus@holtmann.org>
Message-ID: <1329308999.28848.89.camel@aeonflux>
Subject: Re: [PATCH] LMP transaction collision at Set encryption
From: Marcel Holtmann <marcel@holtmann.org>
To: rajmohan.mohanan@intel.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 15 Feb 2012 13:29:59 +0100
In-Reply-To: <1329209821-2783-1-git-send-email-rajmohan.mohanan@intel.com>
References: <LMP Transaction collision>
	 <1329209821-2783-1-git-send-email-rajmohan.mohanan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rajmohan,

> ISSUE:
> 1. started pairing from my device(DUT) to a remote device (Lenovo T500). After successful bonding bluez send device discovery in the same ACL connection createdprior to BONDING
> 2. Changed to DUT role as slave.
> 3. From Host ,sending Set Connection Encryption, getting LMP Error Transaction Collision as status of  encryption command sent by DUT(Slave).(Remote guy who is a master has also initiated Set encryption).
> 4. In between bluez has initiated SDP search after bonding process complete(device_bonding_complete()).
> 5. From the encryption change event (event status is 0x23(LMP transaction collision),Bluez disconnecting l2cap and then acl link.
> We are not able Find the services of remote device because application written in spite of service discovery has initiated after bonding process

please reformat this to keep it under 72 characters per line. Mainly so
that a git log in a 80 char wide terminal stays readable.

> FIX:
> Made changes in hci_event.c  for solving LMP Transaction collision.
> 
> When we gets Encrypt change event with error code as LMP  transaction collision , Ignoring the change event because From Master Encrypt change event will process and will get encrypt change event with success second time.
> 
> If we are not getting Encrypt change event from master we are sending again Set encryption from slave( because we already sent a set encryption which result in to a collision) after 1 second delay.
> 
> If we getting a encrypt change event from master after collision event then we delete timer and process it normally.

Same here.

> 
> HCIDUMP:
> 
> HCI sniffer - Bluetooth packet analyzer ver 1.42
> 
> device: hci0 snap_len: 1028 filter: 0xffffffff
> 
> 2004-01-01 00:24:28.201531 < HCI Command: Create Connection (0x01|0x0005) plen 13
> 
>     bdaddr C4:17:FE:F5:74:DF ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
> 
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5

Please fix this up and remove the empty lines. I bet that you send this
through Exchange and one point and it messed it up for you, but it still
needs to be fixed.

> Signed-off-by: mohanan <rajmohan.mohanan@intel.com>

Please have a proper full name signed-off-by line. Same goes for From:.

> ---
>  include/net/bluetooth/hci.h      |    1 +
>  include/net/bluetooth/hci_core.h |   11 ++++++-----
>  net/bluetooth/hci_conn.c         |   22 +++++++++++++++++++++-
>  net/bluetooth/hci_event.c        |   16 ++++++++++------
>  4 files changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 22ddaf3..e2eefdd 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -108,6 +108,7 @@ enum {
>  #define HCI_PAIRING_TIMEOUT	(60000)	/* 60 seconds */
>  #define HCI_IDLE_TIMEOUT	(6000)	/* 6 seconds */
>  #define HCI_INIT_TIMEOUT	(10000)	/* 10 seconds */
> +#define HCI_ENCRYPTION_TIMEOUT (1000) /*1 seconds*/

Follow the coding style for comments. Example is right above.

>  
>  /* HCI data types */
>  #define HCI_COMMAND_PKT		0x01
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 7a1c03d..e426786 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -197,10 +197,11 @@ struct hci_conn {
>  	__u16            pkt_type;
>  	__u16            link_policy;
>  	__u32		 link_mode;
> -	__u8             auth_type;
> -	__u8             sec_level;
> -	__u8             power_save;
> -	__u16            disc_timeout;
> +	__u8         auth_type;
> +	__u8         sec_level;
> +	__u8         power_save;
> +	__u16        disc_timeout;
> +	__u16        encrypt_timeout;   

Follow our indentation and do not re-format things.

>  	unsigned long	 pend;
>  
>  	unsigned int	 sent;
> @@ -209,7 +210,7 @@ struct hci_conn {
>  
>  	struct timer_list disc_timer;
>  	struct timer_list idle_timer;
> -
> +    struct timer_list encrypt_timer;

I don't think this is against Johan's bluetooth-next tree. We converted
to workqueues.

>  	struct work_struct work_add;
>  	struct work_struct work_del;
>  
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 2f4d30f..22a6df0 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -195,7 +195,23 @@ static void hci_conn_idle(unsigned long arg)
>  
>  	hci_conn_enter_sniff_mode(conn);
>  }

Extra empty line here between functions. Please follow coding
convention.

> +static void hci_conn_encryption(unsigned long arg)
> +{
> +	struct hci_conn *conn = (void *) arg;
> +    
> +	BT_DBG("Encryption status check");
>  
> +	if((conn) && (test_and_clear_bit(HCI_CONN_ENCRYPT_PEND,&conn->pend)))

No (conn) and it is if<space>(. Please follow coding convention as you
see all through the code.

> +	{
> +		struct hci_dev *hdev = conn->hdev;
> +		del_timer(&conn->encrypt_timer);
> +		struct hci_cp_set_conn_encrypt cp;
> +		cp.handle  = conn->handle;
> +		cp.encrypt = 0x01;
> +		hci_send_cmd(hdev, HCI_OP_SET_CONN_ENCRYPT,
> +					sizeof(cp), &cp);
> +	}
> +}
>  struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type,
>  					__u16 pkt_type, bdaddr_t *dst)
>  {
> @@ -216,6 +232,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type,
>  
>  	conn->power_save = 1;
>  	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
> +	conn->encrypt_timeout = HCI_ENCRYPTION_TIMEOUT;

Why are we doing this? It makes no sense. The timeout is always the
same. The case of the disconnect timeout is different since it changes.
So please remove this.

>  
>  	switch (type) {
>  	case ACL_LINK:
> @@ -245,6 +262,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type,
>  
>  	setup_timer(&conn->disc_timer, hci_conn_timeout, (unsigned long)conn);
>  	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
> +	setup_timer(&conn->encrypt_timer, hci_conn_encryption, (unsigned long)conn);

This reminds me. Shortcut encryption to encrypt like we do everywhere
else.

>  
>  	atomic_set(&conn->refcnt, 0);
>  
> @@ -275,6 +293,8 @@ int hci_conn_del(struct hci_conn *conn)
>  
>  	del_timer(&conn->disc_timer);
>  
> +	del_timer(&conn->encrypt_timer);
> +
>  	if (conn->type == ACL_LINK) {
>  		struct hci_conn *sco = conn->link;
>  		if (sco)
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index f7229d2..75719b4 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1,6 +1,5 @@
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
> -   Copyright (C) 2012 Intel Mobile Communications GmbH
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>  
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> @@ -21,9 +20,6 @@
>     ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
>     COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
>     SOFTWARE IS DISCLAIMED.
> -
> -notes:
> -   18-Jan-2012 Added handling for hci flowspec complete event.
>  */

No idea where this comes from, but it is not upstream. Patch has to
apply cleanly against Johan's bluetooth-next tree.
 
>  /* Bluetooth HCI event handling. */
> @@ -1107,7 +1103,7 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
>  {
>  	struct hci_ev_encrypt_change *ev = (void *) skb->data;
>  	struct hci_conn *conn;
> -
> +    unsigned long timeo;
>  	BT_DBG("%s status %d", hdev->name, ev->status);

Please keep the coding style.

>  
>  	hci_dev_lock(hdev);
> @@ -1115,6 +1111,7 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
>  	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
>  	if (conn) {
>  		if (!ev->status) {
> +			del_timer(&conn->encrypt_timer);
>  			if (ev->encrypt) {
>  				/* Encryption implies authentication */
>  				conn->link_mode |= HCI_LM_AUTH;
> @@ -1122,6 +1119,13 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
>  			} else
>  				conn->link_mode &= ~HCI_LM_ENCRYPT;
>  		}
> +	   else if(ev->status == 0x23)
> +	   {

Please keep the coding style.

> +	   		BT_DBG("LMP transactioon collision happened, we need to wait");
> +			timeo = msecs_to_jiffies(conn->encrypt_timeout);
> +		    mod_timer(&conn->encrypt_timer, jiffies + timeo);

And once more.

> +			goto done;
> +	   }
>  
>  		clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend);
>  
> @@ -1134,7 +1138,7 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
>  		} else
>  			hci_encrypt_cfm(conn, ev->status, ev->encrypt);
>  	}
> -
> +done:
>  	hci_dev_unlock(hdev);
>  }
>  

Regards

Marcel


