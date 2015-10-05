Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20151005082147.GA10556@t440s.lan>
References: <1441216275-2954-1-git-send-email-jpawlowski@google.com>
	<1441216275-2954-3-git-send-email-jpawlowski@google.com>
	<20151005082147.GA10556@t440s.lan>
Date: Mon, 5 Oct 2015 11:28:26 -0700
Message-ID: <CAD0=r8xOoGfC91TaJnJDVg3-j0hFRgp=qNvWxxTbKQO2Zy3njg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] emulator: add BT_HCI_CMD_LE_CREATE_CONN_CANCEL handling
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 5, 2015 at 1:21 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jakub,
>
> On Wed, Sep 02, 2015, Jakub Pawlowski wrote:
>> This patch adds handling of BT_HCI_CMD_LE_CREATE_CONN_CANCEL command.
>>
>> If btdev_set_le_noresp_conn_request is called on btdev, other devices that
>> try to connect to it will stuck on BT_HCI_CMD_LE_CREATE_CONN, by not
>> sending bt_hci_evt_le_conn_complete event back. Thanks to that,
>> BT_HCI_CMD_LE_CREATE_CONN_CANCEL can be triggered to cancel connect
>> attempt.
>> ---
>>  emulator/btdev.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  emulator/btdev.h  |  2 ++
>>  emulator/hciemu.c |  8 ++++++++
>>  emulator/hciemu.h |  3 +++
>>  4 files changed, 58 insertions(+)
>>
>> diff --git a/emulator/btdev.c b/emulator/btdev.c
>> index 60e8e8c..1645776 100644
>> --- a/emulator/btdev.c
>> +++ b/emulator/btdev.c
>> @@ -145,6 +145,11 @@ struct btdev {
>>       uint16_t sync_train_interval;
>>       uint32_t sync_train_timeout;
>>       uint8_t  sync_train_service_data;
>> +
>> +     bool     le_noresp_conn_request;
>> +     bool     pending_le_conn;
>> +     uint8_t  pending_le_conn_addr[6];
>> +     uint8_t  pending_le_conn_addr_type;
>>  };
>>
>>  struct inquiry_data {
>> @@ -674,6 +679,11 @@ bool btdev_is_le_scan_enabled(struct btdev *btdev)
>>       return btdev->le_scan_enable;
>>  }
>>
>> +void btdev_set_le_noresp_conn_request(struct btdev *btdev, bool value)
>> +{
>> +     btdev->le_noresp_conn_request = value;
>> +}
>> +
>>  static bool use_ssp(struct btdev *btdev1, struct btdev *btdev2)
>>  {
>>       if (btdev1->auth_enable || btdev2->auth_enable)
>> @@ -1134,6 +1144,9 @@ static void le_conn_complete(struct btdev *btdev,
>>               cc->handle = cpu_to_le16(42);
>>       }
>>
>> +     if (btdev->pending_le_conn)
>> +             btdev->pending_le_conn = false;
>> +
>>       cc->status = status;
>>       cc->peer_addr_type = bdaddr_type;
>>       memcpy(cc->peer_addr, bdaddr, 6);
>> @@ -1183,6 +1196,13 @@ static void le_conn_request(struct btdev *btdev, const uint8_t *bdaddr,
>>  {
>>       struct btdev *remote = find_btdev_by_bdaddr_type(bdaddr, bdaddr_type);
>>
>> +     if (remote && remote->le_noresp_conn_request) {
>> +             btdev->pending_le_conn = true;
>> +             memcpy(btdev->pending_le_conn_addr, bdaddr, 6);
>> +             btdev->pending_le_conn_addr_type = bdaddr_type;
>> +             return;
>> +     }
>
> btdev.c has a hooks mechanism to avoid adding test-specific complexity
> from creeping in by letting the exception handling be in the test code
> itself. In this case, couldn't you use command hooks to deal with the
> le_create_conn & le_create_conn_cancel commands in the tester and
> prevent the default handlers for them from running in btdev.c (by
> returning 'false' from the hook callback)?

Thanks for pointing me to hooks. It actually made this code shorter.

>
> Johan
