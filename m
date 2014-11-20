Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8xgTa7OBvSOX80sQDwYQzd6nOfNNodjqwD4Od8TMSUWJQ@mail.gmail.com>
References: <1416505902-29931-1-git-send-email-jpawlowski@google.com>
	<1416505902-29931-2-git-send-email-jpawlowski@google.com>
	<CAHrH25Q+RBVq3YD=Zrw_-S-rF8Gtsfoav1exRNTgO7qYMt=y=g@mail.gmail.com>
	<CAD0=r8xgTa7OBvSOX80sQDwYQzd6nOfNNodjqwD4Od8TMSUWJQ@mail.gmail.com>
Date: Thu, 20 Nov 2014 15:40:08 -0800
Message-ID: <CAHrH25RqFMp0vDXigNrwOfbQnk8V+DfQhc2+FrpA2440LvAedA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] Bluetooth: Extract generic start and stop discovery
From: Arman Uguray <armansito@chromium.org>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> On Thu, Nov 20, 2014 at 3:14 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> On Thu, Nov 20, 2014 at 2:14 PM, Arman Uguray <armansito@chromium.org> wrote:
>> Hi Jakub,
>>
>>> On Thu, Nov 20, 2014 at 9:51 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>>> This commit extract generic_start_discovery and generic_stop_discovery
>>> in preparation for start and stop service discovery. The reason behind
>>> that is that both functions will share big part of code, and it would
>>> be much easier to maintain just one generic method.
>>>
>>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>>> ---
>>>  net/bluetooth/mgmt.c | 147 ++++++++++++++++++++++++++++++---------------------
>>>  1 file changed, 86 insertions(+), 61 deletions(-)
>>>
>>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>>> index cbeef5f..f650d30 100644
>>> --- a/net/bluetooth/mgmt.c
>>> +++ b/net/bluetooth/mgmt.c
>>> @@ -3675,7 +3675,8 @@ done:
>>>         return err;
>>>  }
>>>
>>> -static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
>>> +static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status,
>>> +                                      uint16_t opcode)
>>>  {
>>>         struct pending_cmd *cmd;
>>>         u8 type;
>>> @@ -3683,7 +3684,7 @@ static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
>>>
>>>         hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>>>
>>> -       cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
>>> +       cmd = mgmt_pending_find(opcode, hdev);
>>>         if (!cmd)
>>>                 return -ENOENT;
>>>
>>> @@ -3696,7 +3697,8 @@ static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
>>>         return err;
>>>  }
>>>
>>> -static void start_discovery_complete(struct hci_dev *hdev, u8 status)
>>> +static void generic_start_discovery_complete(struct hci_dev *hdev, u8 status,
>>> +                                            uint16_t opcode)
>>
>> I'm not that big on calling these generic functions "generic_*". Let's
>> try to come up with something better.
>>
>>>  {
>>>         unsigned long timeout = 0;
>>>
>>> @@ -3704,7 +3706,7 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
>>>
>>>         if (status) {
>>>                 hci_dev_lock(hdev);
>>> -               mgmt_start_discovery_failed(hdev, status);
>>> +               mgmt_start_discovery_failed(hdev, status, opcode);
>>>                 hci_dev_unlock(hdev);
>>>                 return;
>>>         }
>>> @@ -3735,8 +3737,13 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
>>>         queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable, timeout);
>>>  }
>>>
>>> -static int start_discovery(struct sock *sk, struct hci_dev *hdev,
>>> -                          void *data, u16 len)
>>> +static void start_discovery_complete(struct hci_dev *hdev, u8 status)
>>> +{
>>> +       generic_start_discovery_complete(hdev, status, MGMT_OP_START_DISCOVERY);
>>> +}
>>> +
>>> +static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
>>> +                                  void *data, u16 len, uint16_t opcode)
>>>  {
>>>         struct mgmt_cp_start_discovery *cp = data;
>>>         struct pending_cmd *cmd;
>>> @@ -3746,41 +3753,41 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
>>>         struct hci_request req;
>>>         /* General inquiry access code (GIAC) */
>>>         u8 lap[3] = { 0x33, 0x8b, 0x9e };
>>> -       u8 status, own_addr_type;
>>> +       u8 status, own_addr_type, type;
>>>         int err;
>>>
>>>         BT_DBG("%s", hdev->name);
>>>
>>> +       type = cp->type;
>>> +
>>
>> I don't see the point of this local variable & assignment. Why not
>> just leave it as it is, "cp->type" isn't that wordy.
>
> So this patch is preparation for next patch which will have if/else
> statement here that would pick proper type for different cases.
> The next patch is already big so I wanted to make this change from
> cp->type to  type in this one. If that's a bad idea I'll move that to
> next patch.
>

Yeah, from here it just looks like a random refactor. I would just put
it into the next patch. Or if you think that the next patch is too
big, maybe think about how you can make it smaller by separating the
logical steps?

>>
>>>         hci_dev_lock(hdev);
>>>
>>>         if (!hdev_is_powered(hdev)) {
>>> -               err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
>>> -                                  MGMT_STATUS_NOT_POWERED,
>>> -                                  &cp->type, sizeof(cp->type));
>>> +               err = cmd_complete(sk, hdev->id, opcode,
>>> +                                  MGMT_STATUS_NOT_POWERED, &type,
>>> +                                  sizeof(type));
>>>                 goto failed;
>>>         }
>>>
>>>         if (test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
>>> -               err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
>>> -                                  MGMT_STATUS_BUSY, &cp->type,
>>> -                                  sizeof(cp->type));
>>> +               err = cmd_complete(sk, hdev->id, opcode,
>>> +                                  MGMT_STATUS_BUSY, &type, sizeof(type));
>>>                 goto failed;
>>>         }
>>>
>>>         if (hdev->discovery.state != DISCOVERY_STOPPED) {
>>> -               err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
>>> -                                  MGMT_STATUS_BUSY, &cp->type,
>>> -                                  sizeof(cp->type));
>>> +               err = cmd_complete(sk, hdev->id, opcode,
>>> +                                  MGMT_STATUS_BUSY, &type, sizeof(type));
>>>                 goto failed;
>>>         }
>>>
>>> -       cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, hdev, NULL, 0);
>>> +       cmd = mgmt_pending_add(sk, opcode, hdev, NULL, 0);
>>>         if (!cmd) {
>>>                 err = -ENOMEM;
>>>                 goto failed;
>>>         }
>>>
>>> -       hdev->discovery.type = cp->type;
>>> +       hdev->discovery.type = type;
>>>
>>>         hci_req_init(&req, hdev);
>>>
>>> @@ -3788,18 +3795,16 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
>>>         case DISCOV_TYPE_BREDR:
>>>                 status = mgmt_bredr_support(hdev);
>>>                 if (status) {
>>> -                       err = cmd_complete(sk, hdev->id,
>>> -                                          MGMT_OP_START_DISCOVERY, status,
>>> -                                          &cp->type, sizeof(cp->type));
>>> +                       err = cmd_complete(sk, hdev->id, opcode, status, &type,
>>> +                                          sizeof(type));
>>>                         mgmt_pending_remove(cmd);
>>>                         goto failed;
>>>                 }
>>>
>>>                 if (test_bit(HCI_INQUIRY, &hdev->flags)) {
>>> -                       err = cmd_complete(sk, hdev->id,
>>> -                                          MGMT_OP_START_DISCOVERY,
>>> -                                          MGMT_STATUS_BUSY, &cp->type,
>>> -                                          sizeof(cp->type));
>>> +                       err = cmd_complete(sk, hdev->id, opcode,
>>> +                                          MGMT_STATUS_BUSY, &type,
>>> +                                          sizeof(type));
>>>                         mgmt_pending_remove(cmd);
>>>                         goto failed;
>>>                 }
>>> @@ -3816,19 +3821,17 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
>>>         case DISCOV_TYPE_INTERLEAVED:
>>>                 status = mgmt_le_support(hdev);
>>>                 if (status) {
>>> -                       err = cmd_complete(sk, hdev->id,
>>> -                                          MGMT_OP_START_DISCOVERY, status,
>>> -                                          &cp->type, sizeof(cp->type));
>>> +                       err = cmd_complete(sk, hdev->id, opcode, status, &type,
>>> +                                          sizeof(type));
>>>                         mgmt_pending_remove(cmd);
>>>                         goto failed;
>>>                 }
>>>
>>>                 if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
>>>                     !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
>>> -                       err = cmd_complete(sk, hdev->id,
>>> -                                          MGMT_OP_START_DISCOVERY,
>>> -                                          MGMT_STATUS_NOT_SUPPORTED,
>>> -                                          &cp->type, sizeof(cp->type));
>>> +                       err = cmd_complete(sk, hdev->id, opcode,
>>> +                                          MGMT_STATUS_NOT_SUPPORTED, &type,
>>> +                                          sizeof(type));
>>>                         mgmt_pending_remove(cmd);
>>>                         goto failed;
>>>                 }
>>> @@ -3840,11 +3843,9 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
>>>                          */
>>>                         if (hci_conn_hash_lookup_state(hdev, LE_LINK,
>>>                                                        BT_CONNECT)) {
>>> -                               err = cmd_complete(sk, hdev->id,
>>> -                                                  MGMT_OP_START_DISCOVERY,
>>> -                                                  MGMT_STATUS_REJECTED,
>>> -                                                  &cp->type,
>>> -                                                  sizeof(cp->type));
>>> +                               err = cmd_complete(sk, hdev->id, opcode,
>>> +                                                  MGMT_STATUS_REJECTED, &type,
>>> +                                                  sizeof(type));
>>>                                 mgmt_pending_remove(cmd);
>>>                                 goto failed;
>>>                         }
>>> @@ -3867,10 +3868,9 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
>>>                  */
>>>                 err = hci_update_random_address(&req, true, &own_addr_type);
>>>                 if (err < 0) {
>>> -                       err = cmd_complete(sk, hdev->id,
>>> -                                          MGMT_OP_START_DISCOVERY,
>>> -                                          MGMT_STATUS_FAILED,
>>> -                                          &cp->type, sizeof(cp->type));
>>> +                       err = cmd_complete(sk, hdev->id, opcode,
>>> +                                          MGMT_STATUS_FAILED, &type,
>>> +                                          sizeof(type));
>>>                         mgmt_pending_remove(cmd);
>>>                         goto failed;
>>>                 }
>>> @@ -3890,14 +3890,15 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
>>>                 break;
>>>
>>>         default:
>>> -               err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
>>> -                                  MGMT_STATUS_INVALID_PARAMS,
>>> -                                  &cp->type, sizeof(cp->type));
>>> +               err = cmd_complete(sk, hdev->id, opcode,
>>> +                                  MGMT_STATUS_INVALID_PARAMS, &type,
>>> +                                  sizeof(type));
>>>                 mgmt_pending_remove(cmd);
>>>                 goto failed;
>>>         }
>>>
>>>         err = hci_req_run(&req, start_discovery_complete);
>>> +
>>>         if (err < 0)
>>>                 mgmt_pending_remove(cmd);
>>>         else
>>> @@ -3908,12 +3909,20 @@ failed:
>>>         return err;
>>>  }
>>>
>>> -static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
>>> +static int start_discovery(struct sock *sk, struct hci_dev *hdev,
>>> +                          void *data, u16 len)
>>> +{
>>> +       return generic_start_discovery(sk, hdev, data, len,
>>> +                                      MGMT_OP_START_DISCOVERY);
>>> +}
>>> +
>>> +static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status,
>>> +                                     uint16_t opcode)
>>>  {
>>>         struct pending_cmd *cmd;
>>>         int err;
>>>
>>> -       cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
>>> +       cmd = mgmt_pending_find(opcode, hdev);
>>>         if (!cmd)
>>>                 return -ENOENT;
>>>
>>> @@ -3924,14 +3933,15 @@ static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
>>>         return err;
>>>  }
>>>
>>> -static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
>>> +static void generic_stop_discovery_complete(struct hci_dev *hdev, u8 status,
>>> +                                           uint16_t opcode)
>>>  {
>>>         BT_DBG("status %d", status);
>>>
>>>         hci_dev_lock(hdev);
>>>
>>>         if (status) {
>>> -               mgmt_stop_discovery_failed(hdev, status);
>>> +               mgmt_stop_discovery_failed(hdev, status, opcode);
>>>                 goto unlock;
>>>         }
>>>
>>> @@ -3941,33 +3951,40 @@ unlock:
>>>         hci_dev_unlock(hdev);
>>>  }
>>>
>>> -static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
>>> -                         u16 len)
>>> +static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
>>> +{
>>> +       generic_stop_discovery_complete(hdev, status, MGMT_OP_STOP_DISCOVERY);
>>> +}
>>> +
>>> +static int generic_stop_discovery(struct sock *sk, struct hci_dev *hdev,
>>> +                                 void *data, u16 len, uint16_t opcode)
>>>  {
>>> -       struct mgmt_cp_stop_discovery *mgmt_cp = data;
>>>         struct pending_cmd *cmd;
>>>         struct hci_request req;
>>> +       struct mgmt_cp_stop_discovery *mgmt_cp = data;
>>
>> Why move this?
>
> I'll fix that
>>
>>>         int err;
>>> +       u8 type;
>>>
>>
>> Again, there's no need for this variable.
>
> same as aboce - this patch is preparation for next patch which will
> have if/else statement here that would pick proper type for different
> cases.
>
>>
>>>         BT_DBG("%s", hdev->name);
>>>
>>> +       type = mgmt_cp->type;
>>> +
>>>         hci_dev_lock(hdev);
>>>
>>>         if (!hci_discovery_active(hdev)) {
>>> -               err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
>>> -                                  MGMT_STATUS_REJECTED, &mgmt_cp->type,
>>> -                                  sizeof(mgmt_cp->type));
>>> +               err = cmd_complete(sk, hdev->id, opcode,
>>> +                                  MGMT_STATUS_REJECTED, &type, sizeof(type));
>>>                 goto unlock;
>>>         }
>>>
>>> -       if (hdev->discovery.type != mgmt_cp->type) {
>>> -               err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
>>> -                                  MGMT_STATUS_INVALID_PARAMS, &mgmt_cp->type,
>>> -                                  sizeof(mgmt_cp->type));
>>> +       if (hdev->discovery.type != type) {
>>> +               err = cmd_complete(sk, hdev->id, opcode,
>>> +                                  MGMT_STATUS_INVALID_PARAMS, &type,
>>> +                                  sizeof(type));
>>>                 goto unlock;
>>>         }
>>>
>>> -       cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, NULL, 0);
>>> +       cmd = mgmt_pending_add(sk, opcode, hdev, NULL, 0);
>>>         if (!cmd) {
>>>                 err = -ENOMEM;
>>>                 goto unlock;
>>> @@ -3978,6 +3995,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
>>>         hci_stop_discovery(&req);
>>>
>>>         err = hci_req_run(&req, stop_discovery_complete);
>>> +
>>>         if (!err) {
>>>                 hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
>>>                 goto unlock;
>>> @@ -3987,8 +4005,8 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
>>>
>>>         /* If no HCI commands were sent we're done */
>>>         if (err == -ENODATA) {
>>> -               err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY, 0,
>>> -                                  &mgmt_cp->type, sizeof(mgmt_cp->type));
>>> +               err = cmd_complete(sk, hdev->id, opcode, 0,
>>> +                                  &type, sizeof(type));
>>>                 hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>>>         }
>>>
>>> @@ -3997,6 +4015,13 @@ unlock:
>>>         return err;
>>>  }
>>>
>>> +static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
>>> +                         u16 len)
>>> +{
>>> +       return generic_stop_discovery(sk, hdev, data, len,
>>> +                                     MGMT_OP_STOP_DISCOVERY);
>>> +}
>>> +
>>>  static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
>>>                         u16 len)
>>>  {
>>> --
>>> 2.1.0.rc2.206.gedb03e5
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> Overall I think this patch looks good, except for a few nits that I
>> commented on above.
>>
>> Thanks,
>> Arman

Thanks,
Arman
