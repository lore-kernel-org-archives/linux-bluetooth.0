Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FA7A09BE-00AE-4406-B6E7-37D75BB5BC6D@holtmann.org>
References: <1395787575-26716-1-git-send-email-lukasz.rymanowski@tieto.com>
	<FA7A09BE-00AE-4406-B6E7-37D75BB5BC6D@holtmann.org>
Date: Wed, 26 Mar 2014 10:21:56 +0100
Message-ID: <CAMudyAseOpr3f_P4serFu_0N_h=J6=Su0n34idwoFcE5DYwh0A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add support for read remote rssi
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

On 26 March 2014 10:03, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lukasz,
>
>> This patch add support for read remote rssi.
>> This is needed for example for proximity scenarios.
>>
>> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
>> ---
>> include/net/bluetooth/hci.h      | 10 +++++
>> include/net/bluetooth/hci_core.h |  3 ++
>> include/net/bluetooth/mgmt.h     | 10 +++++
>> net/bluetooth/hci_event.c        | 24 ++++++++++++
>> net/bluetooth/mgmt.c             | 82 ++++++++++++++++++++++++++++++++++++++++
>> 5 files changed, 129 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 4261a67..2e023e8 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -1064,6 +1064,16 @@ struct hci_rp_read_page_scan_type {
>>       #define PAGE_SCAN_TYPE_STANDARD         0x00
>>       #define PAGE_SCAN_TYPE_INTERLACED       0x01
>>
>> +#define HCI_OP_READ_REMOTE_RSSI              0x1405
>> +struct hci_cp_read_remote_rssi {
>> +     __le16   handle;
>> +} __packed;
>> +struct hci_rp_read_remote_rssi {
>> +     __u8     status;
>> +     __le16   handle;
>> +     __s8     rssi;
>> +} __packed;
>> +
>> #define HCI_OP_READ_LOCAL_AMP_INFO    0x1409
>> struct hci_rp_read_local_amp_info {
>>       __u8     status;
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index abd38a2..95837b7 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1283,6 +1283,9 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
>>                  bool persistent);
>> void mgmt_reenable_advertising(struct hci_dev *hdev);
>> void mgmt_smp_complete(struct hci_conn *conn, bool complete);
>> +void mgmt_read_remote_rssi_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
>> +                                 u8 link_type, u8 addr_type, s8 rssi,
>> +                                 u8 status);
>>
>> /* HCI info for socket */
>> #define hci_pi(sk) ((struct hci_pinfo *) sk)
>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>> index d4b571c..16a0201 100644
>> --- a/include/net/bluetooth/mgmt.h
>> +++ b/include/net/bluetooth/mgmt.h
>> @@ -409,6 +409,16 @@ struct mgmt_cp_load_irks {
>> } __packed;
>> #define MGMT_LOAD_IRKS_SIZE           2
>>
>> +#define MGMT_OP_READ_REMOTE_RSSI     0x0031
>> +#define MGMT_READ_REMOTE_RSSI_SIZE   MGMT_ADDR_INFO_SIZE
>> +struct mgmt_cp_read_remote_rssi {
>> +     struct mgmt_addr_info addr;
>> +} __packed;
>> +struct mgmt_rp_read_remote_rssi {
>> +     struct mgmt_addr_info addr;
>> +     __s8 rssi;
>> +} __packed;
>
> I am not really in favor of doing it like this. Normally what you really want to do have is a mgmt function that can enable RSSI reporting based on a threshold that changes and a polling interval. So that the kernel will go on and poll the RSSI during the time of the connection and just report it back.
>
Maybe I could introduce mgmt API which, as you said, register for rssi
notification for given threshold but also allows one shot read.
In this way we will be ready for better solutions in the future but
also can handlle current Android approach
Since this readRssi api is exposed to the application we never know if
it will be called once or in some continuous manner.
What do you think?

BTW. I know there are controllers which allows you to register for
RSSI notification based on threshold - this is how it should work
right?:)

> So I say we hold off on this until we have solved all other Android implementation details and then we revisit what we need.
>
> Regards
>
> Marcel
>

\Lukasz
