Return-Path: <cyrus@holtmann.org>
From: "Mohanan, Rajmohan" <rajmohan.mohanan@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] LMP transaction collision at Set encryption
Date: Tue, 14 Feb 2012 13:16:00 +0000
Message-ID: <E74476E55D15D942BA0FF3CDAD73606F043032@FMSMSX102.amr.corp.intel.com>
References: <1329209821-2783-1-git-send-email-rajmohan.mohanan@intel.com>
 <CABBYNZJHnunfidU5Un_cvYaZt-RrQYm_MzMXZypdRTHHVj4oyQ@mail.gmail.com>
In-Reply-To: <CABBYNZJHnunfidU5Un_cvYaZt-RrQYm_MzMXZypdRTHHVj4oyQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
      I could not really get what is the point " No need to duplicate code of hci_conn_encrypt, you can just call it ".Could you please explain ?
I will change the function name as you suggested and will remove the delete timer.

> +static void hci_conn_encryption(unsigned long arg) {
> +       struct hci_conn *conn = (void *) arg;
> +
> +       BT_DBG("Encryption status check");
>
> +       if((conn) && 
> +(test_and_clear_bit(HCI_CONN_ENCRYPT_PEND,&conn->pend)))
> +       {
> +               struct hci_dev *hdev = conn->hdev;
> +               del_timer(&conn->encrypt_timer);
> +               struct hci_cp_set_conn_encrypt cp;
> +               cp.handle  = conn->handle;
> +               cp.encrypt = 0x01;
> +               hci_send_cmd(hdev, HCI_OP_SET_CONN_ENCRYPT,
> +                                       sizeof(cp), &cp);
> +       }
> +}

No need to duplicate code of hci_conn_encrypt, you can just call it, also I would call it hci_conn_encrypt_timeout to make clear this run on timer context and avoid confusion with hci_conn_encrypt. Btw I don't think you really need to use del_timer inside the callback since we don't use on other timeout handlers.

Regards
Rajmohan
-----Original Message-----
From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com] 
Sent: Tuesday, February 14, 2012 5:03 PM
To: Mohanan, Rajmohan
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] LMP transaction collision at Set encryption

Hi,

On Tue, Feb 14, 2012 at 10:57 AM,  <rajmohan.mohanan@intel.com> wrote:
> From: mohanan <rajmohan.mohanan@intel.com>
>
> ISSUE:
> 1. started pairing from my device(DUT) to a remote device (Lenovo 
> T500). After successful bonding bluez send device discovery in the same ACL connection createdprior to BONDING 2. Changed to DUT role as slave.
> 3. From Host ,sending Set Connection Encryption, getting LMP Error Transaction Collision as status of  encryption command sent by DUT(Slave).(Remote guy who is a master has also initiated Set encryption).
> 4. In between bluez has initiated SDP search after bonding process complete(device_bonding_complete()).
> 5. From the encryption change event (event status is 0x23(LMP transaction collision),Bluez disconnecting l2cap and then acl link.
> We are not able Find the services of remote device because application 
> written in spite of service discovery has initiated after bonding 
> process

This stack that you are running in Lenovo T500 is really weird, forcing master every time it connects and always starting sdp immediately will for sure cause problems with other stacks too, afaik even BITE tester does not like our reverse sdp which is not immediately (2 sec.).

Anyway the point of not disconnecting on collision seems valid, btw please start with "Bluetooth:..." when submitting patches to Linux kernel.

> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h 
> index 22ddaf3..e2eefdd 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -108,6 +108,7 @@ enum {
>  #define HCI_PAIRING_TIMEOUT    (60000) /* 60 seconds */
>  #define HCI_IDLE_TIMEOUT       (6000)  /* 6 seconds */
>  #define HCI_INIT_TIMEOUT       (10000) /* 10 seconds */
> +#define HCI_ENCRYPTION_TIMEOUT (1000) /*1 seconds*/
>
>  /* HCI data types */
>  #define HCI_COMMAND_PKT                0x01 diff --git 
> a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 7a1c03d..e426786 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -197,10 +197,11 @@ struct hci_conn {
>        __u16            pkt_type;
>        __u16            link_policy;
>        __u32            link_mode;
> -       __u8             auth_type;
> -       __u8             sec_level;
> -       __u8             power_save;
> -       __u16            disc_timeout;
> +       __u8         auth_type;
> +       __u8         sec_level;
> +       __u8         power_save;
> +       __u16        disc_timeout;
> +       __u16        encrypt_timeout;

It seems you are changing other lines instead of just adding encrypt_timeout, make sure you/your editor is not adding spaces instead of tabs for some reason.

>        unsigned long    pend;
>
>        unsigned int     sent;
> @@ -209,7 +210,7 @@ struct hci_conn {
>
>        struct timer_list disc_timer;
>        struct timer_list idle_timer;
> -
> +    struct timer_list encrypt_timer;
>        struct work_struct work_add;
>        struct work_struct work_del;

Grouping timer_list together but you don't need to remove the empty line that separate them to the work_struct.

> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c index 
> 2f4d30f..22a6df0 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -195,7 +195,23 @@ static void hci_conn_idle(unsigned long arg)
>
>        hci_conn_enter_sniff_mode(conn);
>  }
> +static void hci_conn_encryption(unsigned long arg) {
> +       struct hci_conn *conn = (void *) arg;
> +
> +       BT_DBG("Encryption status check");
>
> +       if((conn) && 
> +(test_and_clear_bit(HCI_CONN_ENCRYPT_PEND,&conn->pend)))
> +       {
> +               struct hci_dev *hdev = conn->hdev;
> +               del_timer(&conn->encrypt_timer);
> +               struct hci_cp_set_conn_encrypt cp;
> +               cp.handle  = conn->handle;
> +               cp.encrypt = 0x01;
> +               hci_send_cmd(hdev, HCI_OP_SET_CONN_ENCRYPT,
> +                                       sizeof(cp), &cp);
> +       }
> +}

No need to duplicate code of hci_conn_encrypt, you can just call it, also I would call it hci_conn_encrypt_timeout to make clear this run on timer context and avoid confusion with hci_conn_encrypt. Btw I don't think you really need to use del_timer inside the callback since we don't use on other timeout handlers.

> -   Copyright (C) 2012 Intel Mobile Communications GmbH

This is not upstream, it wont apply.

>    Copyright (C) 2000-2001 Qualcomm Incorporated
>
>    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com> @@ -21,9 
> +20,6 @@
>    ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
>    COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
>    SOFTWARE IS DISCLAIMED.
> -
> -notes:
> -   18-Jan-2012 Added handling for hci flowspec complete event.

Neither this.

> +          else if(ev->status == 0x23)
> +          {
> +                       BT_DBG("LMP transactioon collision happened, 
> + we need to wait");
> +                       timeo = 
> + msecs_to_jiffies(conn->encrypt_timeout);
> +                   mod_timer(&conn->encrypt_timer, jiffies + timeo);
> +                       goto done;
> +          }

Formatting here is wrong please check the coding style, also if the remote stack run the same code (BlueZ vs BlueZ) it is going to collide again after timer expire, so perhaps you should be checking if it is master resend immediately otherwise wait for master.

--
Luiz Augusto von Dentz
