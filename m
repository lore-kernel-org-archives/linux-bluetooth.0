Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <508e92ca0907020657o561effbeg1911f8f84af27f37@mail.gmail.com>
References: <508e92ca0907020657o561effbeg1911f8f84af27f37@mail.gmail.com>
Date: Fri, 14 Aug 2009 16:44:36 +0300
Message-ID: <508e92ca0908140644vb3e6d80k9db0a15a74881cc7@mail.gmail.com>
Subject: Re: [PATCH] SSP double paring fix: init auth_type with
	HCI_AT_GENERAL_BONDING
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Could you check the patch below? We found that it helps with Vista
initiated BT 2.1 paring as well.

Regards,
Andrei


On Thu, Jul 2, 2009 at 4:57 PM, Andrei
Emeltchenko<andrei.emeltchenko.news@gmail.com> wrote:
> Hi,
> I have a simple patch which fixes issues with SSP mentioned below.
>
> ---
>  net/bluetooth/hci_conn.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index fa47d5d..d863bda 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -211,6 +211,7 @@ struct hci_conn *hci_conn_add(struct hci_dev
> *hdev, int type, bdaddr_t *dst)
>        conn->type  = type;
>        conn->mode  = HCI_CM_ACTIVE;
>        conn->state = BT_OPEN;
> +       conn->auth_type = HCI_AT_GENERAL_BONDING;
>
>        conn->power_save = 1;
>        conn->disc_timeout = HCI_DISCONN_TIMEOUT;
> --
> 1.6.0.4
>
> Regards,
> Andrei
>
> On Wed, Jun 17, 2009 at 3:03 PM, Andrei
> Emeltchenko<andrei.emeltchenko.news@gmail.com> wrote:
>> Hi,
>>
>> We have error with SSP paring. Originally we could not connect some
>> devices and the problem was reproduced on my PC with 2 USB Bluetooth
>> adapters.
>>
>> bluez asks user paring confirmation 2 times.
>>
>> Test:
>>
>> hci1:   Type: USB
>>        BD Address: 00:02:72:16:4E:D5 ACL MTU: 1021:8 SCO MTU: 64:1
>>        UP RUNNING PSCAN
>>        RX bytes:12122 acl:78 sco:0 events:449 errors:0
>>        TX bytes:22547 acl:82 sco:0 commands:294 errors:0
>>
>> hci2:   Type: USB
>>        BD Address: 00:02:72:16:19:39 ACL MTU: 1021:8 SCO MTU: 64:1
>>        UP RUNNING PSCAN
>>        RX bytes:12593 acl:82 sco:0 events:475 errors:0
>>        TX bytes:28404 acl:78 sco:0 commands:329 errors:0
>>
>>
>> hci1:
>> sudo ./l2test -i hci1 -r -E -S   # server
>>
>> hci2:
>> sudo ./l2test -i hci2 -n 00:02:72:16:4E:D5 -b 10 -N 1 -E -S -s   # client
>>
>>  ./simple-agent hci1
>> Agent registered
>> RequestConfirmation (/org/bluez/6255/hci1/dev_00_02_72_16_19_39, 533464)
>> Confirm passkey (yes/no): yes
>> RequestConfirmation (/org/bluez/6255/hci1/dev_00_02_72_16_19_39, 152200)
>> Confirm passkey (yes/no): yes
>>
>>
>> ./simple-agent hci2
>> Agent registered
>> RequestConfirmation (/org/bluez/6255/hci2/dev_00_02_72_16_4E_D5, 533464)
>> Confirm passkey (yes/no): yes
>> RequestConfirmation (/org/bluez/6255/hci2/dev_00_02_72_16_4E_D5, 152200)
>> Confirm passkey (yes/no): yes
>>
>> For the single connection passkey is asked 2 times.
>>
>> The reason looks to be because bluetoothd does not store link keys
>> since ioctl  HCIGETAUTHINFO returns 0.
>> Kernel in function hci_get_auth_info returns "conn->auth_type" which
>> is 0 at this stage. As I understood
>> "auth_type" initialized later when "l2cap_connect_req" comes in
>> "l2cap_check_security".
>>
>> What is the best way to solv this? In kernel or in user-space? Is it an error?
>>
>> Regards,
>> Andrei
>>
>
