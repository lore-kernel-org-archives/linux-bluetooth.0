Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1374780864-8529-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1374776057-2618-1-git-send-email-claudio.takahasi@openbossa.org>
	<1374780864-8529-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Thu, 25 Jul 2013 17:27:17 -0300
Message-ID: <CAKT1EBeGHzSTZEPr6Ap=h2u5TyGy2wGxyXP2FfUCT2dKQQpK8Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix removing Long Term Key
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Vinicius Gomes <vcgomes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius:

On Thu, Jul 25, 2013 at 4:34 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> This patch fixes authentication failure on LE link re-connection when
> BlueZ acts as slave (peripheral). LTK is removed from the internal list
> after its first use causing PIN or Key missing reply when re-connecting
> the link. The LE Long Term Key Request event indicates that the master
> is attempting to encrypt or re-encrypt the link.
>
> Pre-condition: BlueZ host paired and running as slave.
> How to reproduce(master):
>   1) Establish an ACL LE encrypted link
>   2) Disconnect the link
>   3) Try to re-establish the ACL LE encrypted link (fails)
>
>> HCI Event: LE Meta Event (0x3e) plen 19
>       LE Connection Complete (0x01)
>         Status: Success (0x00)
>         Handle: 64
>         Role: Slave (0x01)
> ...
> @ Device Connected: 00:02:72:DC:29:C9 (1) flags 0x0000
>> HCI Event: LE Meta Event (0x3e) plen 13
>       LE Long Term Key Request (0x05)
>         Handle: 64
>         Random number: 875be18439d9aa37
>         Encryption diversifier: 0x76ed
> < HCI Command: LE Long Term Key Request Reply (0x08|0x001a) plen 18
>         Handle: 64
>         Long term key: 2aa531db2fce9f00a0569c7d23d17409
>> HCI Event: Command Complete (0x0e) plen 6
>       LE Long Term Key Request Reply (0x08|0x001a) ncmd 1
>         Status: Success (0x00)
>         Handle: 64
>> HCI Event: Encryption Change (0x08) plen 4
>         Status: Success (0x00)
>         Handle: 64
>         Encryption: Enabled with AES-CCM (0x01)
> ...
> @ Device Disconnected: 00:02:72:DC:29:C9 (1) reason 3
> < HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
>         Advertising: Enabled (0x01)
>> HCI Event: Command Complete (0x0e) plen 4
>       LE Set Advertise Enable (0x08|0x000a) ncmd 1
>         Status: Success (0x00)
>> HCI Event: LE Meta Event (0x3e) plen 19
>       LE Connection Complete (0x01)
>         Status: Success (0x00)
>         Handle: 64
>         Role: Slave (0x01)
> ...
> @ Device Connected: 00:02:72:DC:29:C9 (1) flags 0x0000
>> HCI Event: LE Meta Event (0x3e) plen 13
>       LE Long Term Key Request (0x05)
>         Handle: 64
>         Random number: 875be18439d9aa37
>         Encryption diversifier: 0x76ed
> < HCI Command: LE Long Term Key Request Neg Reply (0x08|0x001b) plen 2
>         Handle: 64
>> HCI Event: Command Complete (0x0e) plen 6
>       LE Long Term Key Request Neg Reply (0x08|0x001b) ncmd 1
>         Status: Success (0x00)
>         Handle: 64
>> HCI Event: Disconnect Complete (0x05) plen 4
>         Status: Success (0x00)
>         Handle: 64
>         Reason: Authentication Failure (0x05)
> @ Device Disconnected: 00:02:72:DC:29:C9 (1) reason 0
>
> Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index ae78738..124a5e2 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3558,7 +3558,13 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>
>         hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
>
> -       if (ltk->type & HCI_SMP_STK) {
> +       /*
> +        * Ref. Bluetooth Core SPEC pages 1975 and 2004. STK is a temporary
> +        * key used to encrypt a connection following pairing. It is used
> +        * during the Encrypted Session Setup to distribute the keys. Later,
> +        * security can be re-established using a distributed LTK.
> +        */
> +       if (ltk->type == HCI_SMP_STK_SLAVE) {
>                 list_del(&ltk->list);
>                 kfree(ltk);
>         }
> --
> 1.7.11.7
>

Do you see another alternative?
Is it feasible to avoid adding the STK in the list without adding a
complex logic?

Regards,
Claudio
