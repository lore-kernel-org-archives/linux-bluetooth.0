Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <D935BAF4-A459-4592-B804-3CDE7E617EE3@holtmann.org>
References: <1427252582-24814-1-git-send-email-armansito@chromium.org>
	<D935BAF4-A459-4592-B804-3CDE7E617EE3@holtmann.org>
Date: Wed, 25 Mar 2015 16:42:34 -0700
Message-ID: <CAHrH25QGQqXG5YSeEVBGDJnJc9nRampnaMks9tBHo56tLhNZ=A@mail.gmail.com>
Subject: Re: [PATCH 1/7] Bluetooth: Add macros for advertising instance flags
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> On Wed, Mar 25, 2015 at 9:21 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Arman,
>
>> This patch adds macro definitions for possible advertising instance
>> flags that can be passed to the "Add Advertising" command.
>>
>> Signed-off-by: Arman Uguray <armansito@chromium.org>
>> ---
>> include/net/bluetooth/mgmt.h | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>>
>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>> index 68abd4b..fc50cee 100644
>> --- a/include/net/bluetooth/mgmt.h
>> +++ b/include/net/bluetooth/mgmt.h
>> @@ -554,6 +554,14 @@ struct mgmt_rp_add_advertising {
>>       __u8    instance;
>> } __packed;
>>
>> +#define MGMT_ADV_FLAG_CONNECTABLE    (1 << 0)
>> +#define MGMT_ADV_FLAG_DISCOV         (1 << 1)
>> +#define MGMT_ADV_FLAG_LIMITED_DISCOV (1 << 2)
>> +#define MGMT_ADV_FLAG_MANAGED_FLAGS  (1 << 3)
>> +#define MGMT_ADV_FLAG_TX_POWER               (1 << 4)
>> +#define MGMT_ADV_FLAG_APPEARANCE     (1 << 5)
>> +#define MGMT_ADV_FLAG_LOCAL_NAME     (1 << 6)
>> +
>
> any reason to not use BIT(0) etc. here.
>

No reason at all, fixed for next patch set.

> Regards
>
> Marcel
>

Arman
