Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2944887.ToNmaQstia@athlon>
References: <1418238948-30800-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1418238948-30800-5-git-send-email-lukasz.rymanowski@tieto.com>
	<2944887.ToNmaQstia@athlon>
Date: Tue, 16 Dec 2014 23:11:17 +0100
Message-ID: <CAN_7+YYx-AyqaL7zA6Dda-nqgjoMWG0yiN1b3DGUGDwCJa1Y1Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] android/bluetooth: Enable LE privacy mode on BfA startup
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Dec 16, 2014 at 10:37 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> Hi Łukasz,
>
> On Wednesday 10 December 2014 20:15:48 Lukasz Rymanowski wrote:
>> Lets follow Android Lollipop behaviour and enable privacy on
>> startup.
>> ---
>>  android/bluetooth.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/android/bluetooth.c b/android/bluetooth.c
>> index 4c359d0..54e3d97 100644
>> --- a/android/bluetooth.c
>> +++ b/android/bluetooth.c
>> @@ -3423,6 +3423,32 @@ static void clear_auto_connect_list(void)
>>       error("Could not clear auto connect list");
>>  }
>>
>> +static void set_privacy_complete(uint8_t status, uint16_t length,
>> +                                     const void *param, void *user_data)
>> +{
>> +     if (status != MGMT_STATUS_SUCCESS)
>> +             error("Failed to set privacy mode: %s (0x%02x)",
>> +                                             mgmt_errstr(status), status);
>> +}
>> +
>> +static void set_privacy(void)
>> +{
>> +     struct mgmt_cp_set_privacy cp;
>> +
>> +     if (!local_irk_is_valid())
>> +             goto failed;
>> +
>> +     cp.privacy = 0x01;
>> +     memcpy(cp.irk, adapter.irk, sizeof(adapter.irk));
>> +
>> +     if (mgmt_send(mgmt_if, MGMT_OP_SET_PRIVACY, adapter.index, sizeof(cp),
>> +                             &cp, set_privacy_complete, NULL, NULL) > 0)
>> +             return;
>> +
>> +failed:
>> +     error("Could not set privacy mode");
>> +}
>> +
>>  static void read_info_complete(uint8_t status, uint16_t length,
>>                                       const void *param, void *user_data)
>>  {
>> @@ -3497,6 +3523,9 @@ static void read_info_complete(uint8_t status,
>> uint16_t length, if (missing_settings & MGMT_SETTING_BONDABLE)
>>               set_mode(MGMT_OP_SET_BONDABLE, 0x01);
>>
>> +     if (missing_settings & MGMT_SETTING_PRIVACY)
>> +             set_privacy();
>> +
>>       load_devices_info(cb);
>>       load_devices_cache();
>
> Shouldn't we first configure a static random address?

Why?

\Lukasz
>
> --
> Szymon K. Janc
> szymon.janc@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
