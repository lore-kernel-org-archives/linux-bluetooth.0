Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3B53A9C2-0FA3-4C0C-BC44-9DF2798BFDF8@holtmann.org>
References: <1396959747-19848-1-git-send-email-szymon.janc@tieto.com>
	<3B53A9C2-0FA3-4C0C-BC44-9DF2798BFDF8@holtmann.org>
Date: Thu, 10 Apr 2014 12:57:00 +0300
Message-ID: <CABBYNZKt0=Tpn=R1NcctOXARhqED4Q4WORsXrwbkDy=gQWHVRw@mail.gmail.com>
Subject: Re: [PATCH] android/hidhost: Fix hex string to buffer convertion
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Apr 9, 2014 at 11:49 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Szymon,
>
>> Due to missing limit specifier buffer was always filled with last hex
>> value in string.
>> ---
>> android/hidhost.c | 23 ++++++++++++++---------
>> 1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/android/hidhost.c b/android/hidhost.c
>> index 5ea7c5a..124d710 100644
>> --- a/android/hidhost.c
>> +++ b/android/hidhost.c
>> @@ -162,10 +162,18 @@ static void hid_device_remove(struct hid_device *dev)
>>       hid_device_free(dev);
>> }
>>
>> +static void hex2buf(const uint8_t *hex, uint8_t *buf, int num)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < num; i++)
>> +             sscanf((const char *)(hex + (i * 2)), "%02hhX", &buf[i]);
>> +}
>
> can we please build a cheaper version of this that does not require to use sscanf. Small hint is to look into src/util.c from oFono.

I also wonder why we are doing this? All the HAL does is to
memcpy(cmd->data, data, cmd->len) or is it because the string itself
is hexadecimal encoded? If that is the case someone probably deserves
a medal...


-- 
Luiz Augusto von Dentz
