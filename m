Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25T1qZ1x1O2yKjmWNK7-xSXtw-sZAYHCcHEcJzEjkaGmtQ@mail.gmail.com>
References: <1430231734-26699-1-git-send-email-luiz.dentz@gmail.com>
	<1430231734-26699-4-git-send-email-luiz.dentz@gmail.com>
	<CAHrH25T1qZ1x1O2yKjmWNK7-xSXtw-sZAYHCcHEcJzEjkaGmtQ@mail.gmail.com>
Date: Wed, 29 Apr 2015 12:40:04 +0300
Message-ID: <CABBYNZ+ALd4QMJerokrpjd9Kegaw3p7wqEeg+ke_WxshNawZVw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/4] core/gatt: Auto retry if read/write fails
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Apr 29, 2015 at 12:28 AM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
>> On Tue, Apr 28, 2015 at 7:35 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This adds auto retry logic to ReadValue and WriteValue when a security
>> error happen, it will first attempt to elevate the security to match the
>> requirement and then retry sending the same operation.
>> ---
>>  src/gatt-client.c | 182 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 176 insertions(+), 6 deletions(-)
>>
>> diff --git a/src/gatt-client.c b/src/gatt-client.c
>> index 2e26ed7..7fd814c 100644
>> --- a/src/gatt-client.c
>> +++ b/src/gatt-client.c
>> @@ -223,6 +223,9 @@ static bool parse_value_arg(DBusMessage *msg, uint8_t **value,
>>         return true;
>>  }
>>
>> +struct async_dbus_op;
>> +
>> +typedef bool (*async_dbus_op_retry_t)(struct async_dbus_op *op, uint8_t ecode);
>>  typedef bool (*async_dbus_op_complete_t)(void *data);
>>
>>  struct async_dbus_op {
>> @@ -230,6 +233,7 @@ struct async_dbus_op {
>>         DBusMessage *msg;
>>         void *data;
>>         uint16_t offset;
>> +       async_dbus_op_retry_t retry;
>>         async_dbus_op_complete_t complete;
>>  };
>>
>> @@ -337,6 +341,23 @@ static void read_op_cb(struct gatt_db_attribute *attrib, int err,
>>         g_dbus_send_message(btd_get_dbus_connection(), reply);
>>  }
>>
>> +static bool check_security(struct bt_gatt_client *gatt, uint8_t ecode)
>> +{
>> +       int security;
>> +
>> +       security = bt_gatt_client_get_security(gatt);
>> +       if (ecode == BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION &&
>> +                                       security < BT_ATT_SECURITY_MEDIUM)
>> +               security = BT_ATT_SECURITY_MEDIUM;
>> +       else if (ecode == BT_ATT_ERROR_AUTHENTICATION &&
>> +                                       security < BT_ATT_SECURITY_HIGH)
>> +               security = BT_ATT_SECURITY_HIGH;
>> +       else
>> +               return false;
>> +
>> +       return bt_gatt_client_set_security(gatt, security);
>> +}
>
> This is mostly a nice to have but I wonder if we should try the same
> thing from within shared/gatt-client as well in some cases, for
> example when it fails to write to the CCC for a Service Changed
> characteristic due to permissions. Just a thought.

We can probably do that, I actually started with the idea that
bt_gatt_client itself would retry, the problem is that in Android this
is left for the upper layer to deal with so we would probably need
some means to disable this. Perhaps something like
bt_gatt_client_set_auto_retry, by default I think I would leave it to
false otherwise it might affect the unit tests.

-- 
Luiz Augusto von Dentz
