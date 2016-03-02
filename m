Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+jSLy_YaK99Ov_E2M68yU0xZUxp9t+0cnUFp1sDEaKDA@mail.gmail.com>
References: <1456925319-16594-1-git-send-email-josephsih@chromium.org>
	<CABBYNZ+jSLy_YaK99Ov_E2M68yU0xZUxp9t+0cnUFp1sDEaKDA@mail.gmail.com>
Date: Wed, 2 Mar 2016 16:04:11 +0200
Message-ID: <CABBYNZ+eLxZXkMLuupfBGDthDmuLwKr5Z0tP+sXrmxnL6JTdUg@mail.gmail.com>
Subject: Re: [PATCH] shared/att: change security as needed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: josephsih@chromium.org
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joseph,

On Wed, Mar 2, 2016 at 3:55 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Joseph,
>
> On Wed, Mar 2, 2016 at 3:28 PM,  <josephsih@chromium.org> wrote:
>> From: Joseph Hwang <josephsih@chromium.org>
>>
>> When pairing with a BLE keyboard, bluetoothd suffers from
>> authentication errors as follows:
>>
>> ERR bluetoothd[1103]: Report Map read failed:
>>                     Attribute requires authentication before read/write
>> ERR bluetoothd[1103]: Protocol Mode characteristic read failed:
>>                     Attribute requires authentication before read/write
>> ERR bluetoothd[1103]: HID Information read failed:
>>                     Attribute requires authentication before read/write
>>
>> This is because the original security level is BT_ATT_SECURITY_LOW,
>> while BT_ATT_SECURITY_HIGH is required for pairing. This patch enables
>> the security elevation so that handle_error_rsp() could push the
>> operation back to request queue properly.
>>
>> ---
>>  src/shared/att.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/src/shared/att.c b/src/shared/att.c
>> index 3a84783..331fae7 100644
>> --- a/src/shared/att.c
>> +++ b/src/shared/att.c
>> @@ -574,9 +574,6 @@ static bool change_security(struct bt_att *att, uint8_t ecode)
>>         int security;
>>
>>         security = bt_att_get_security(att);
>> -       if (security != BT_ATT_SECURITY_AUTO)
>> -               return false;
>> -
>
> While this perhaps works it seems to be just a work around the
> problem, it seems to me that ATT security shall be set to
> BT_ATT_SECURITY_AUTO not to BT_ATT_SECURITY_LOW which is preventing
> security to be elevated.

Something like this should fix it:

index 14e850e..6bc44b6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4710,6 +4710,7 @@ bool device_attach_att(struct btd_device *dev,
GIOChannel *io)
        dev->att = g_attrib_get_att(attrib);

        bt_att_ref(dev->att);
+       bt_att_set_security(dev->att, BT_ATT_SECURITY_AUTO);

        dev->att_disconn_id = bt_att_register_disconnect(dev->att,
                                                att_disconnected_cb, dev, NULL);

-- 
Luiz Augusto von Dentz
