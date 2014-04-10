Return-Path: <cyrus@holtmann.org>
Message-ID: <534677F4.9020504@linux.intel.com>
Date: Thu, 10 Apr 2014 13:52:36 +0300
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] android/hidhost: Fix hex string to buffer convertion
References: <1396959747-19848-1-git-send-email-szymon.janc@tieto.com> <3B53A9C2-0FA3-4C0C-BC44-9DF2798BFDF8@holtmann.org> <CABBYNZKt0=Tpn=R1NcctOXARhqED4Q4WORsXrwbkDy=gQWHVRw@mail.gmail.com> <36770231.qit3PSfJSc@uw000953>
In-Reply-To: <36770231.qit3PSfJSc@uw000953>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 04/10/2014 01:32 PM, Szymon Janc wrote:
> Hi Luiz,
>
> On Thursday 10 of April 2014 12:57:00 Luiz Augusto von Dentz wrote:
>> Hi,
>>
>> On Wed, Apr 9, 2014 at 11:49 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>> Hi Szymon,
>>>
>>>> Due to missing limit specifier buffer was always filled with last hex
>>>> value in string.
>>>> ---
>>>> android/hidhost.c | 23 ++++++++++++++---------
>>>> 1 file changed, 14 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/android/hidhost.c b/android/hidhost.c
>>>> index 5ea7c5a..124d710 100644
>>>> --- a/android/hidhost.c
>>>> +++ b/android/hidhost.c
>>>> @@ -162,10 +162,18 @@ static void hid_device_remove(struct hid_device *dev)
>>>>        hid_device_free(dev);
>>>> }
>>>>
>>>> +static void hex2buf(const uint8_t *hex, uint8_t *buf, int num)
>>>> +{
>>>> +     int i;
>>>> +
>>>> +     for (i = 0; i < num; i++)
>>>> +             sscanf((const char *)(hex + (i * 2)), "%02hhX", &buf[i]);
>>>> +}
>>> can we please build a cheaper version of this that does not require to use sscanf. Small hint is to look into src/util.c from oFono.
>> I also wonder why we are doing this? All the HAL does is to
>> memcpy(cmd->data, data, cmd->len) or is it because the string itself
>> is hexadecimal encoded? If that is the case someone probably deserves
>> a medal...
> Yeap, Java is passing string to send_data() and set_report() calls (those have no
> size parameter).
>
> In JNI you can see:
>   const char *c_report = env->GetStringUTFChars(report, NULL);
>      if ( (status = sBluetoothHidInterface->send_data((bt_bdaddr_t *) addr, (char*) c_report)) !=
>               BT_STATUS_SUCCESS) {
>
> Those are test commands so not that important. But I wonder why this is done
> also in handle_uhid_output()...   Ravi, could you comment on that?
   Could not recall exactly, probably done similar to set_report due to
   req[0] = HID_MSG_SET_REPORT | output->rtype;

Regards,
Ravi.
