Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <31158844.FpJplVcR4q@leonov>
References: <1401886448-28463-1-git-send-email-marcin.kraglak@tieto.com>
	<31158844.FpJplVcR4q@leonov>
Date: Wed, 4 Jun 2014 20:31:56 +0200
Message-ID: <CABD6X-KPBwXOc=SjMzG9rbSo4E5wH7o+CdeqXOKHn_CasvMmuA@mail.gmail.com>
Subject: Re: [PATCH] android/gatt: Set attrib MTU correctly
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 4 June 2014 19:38, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Marcin,
>
> On Wednesday 04 of June 2014 14:54:08 Marcin Kraglak wrote:
>> We should set g_attrib mtu with MIN of two values: Remote Rx MTU
>> and local Tx MTU. In previous solution once we set g_attrib mtu, we
>> could only reduce MTU (because we took previously set g_attrib MTU
>> and Remote Rx MTU). It affected cases when remote wanted to increase
>> MTU
>
> According to spec:
> section 3.4.2.1: "This [Exchange MTU] request shall only be sent once during a
> connection by the client."
> section 3.4.2.2: "A device's Exchange MTU Request shall contain the same MTU
> as the device's Exchange MTU Response (i.e. the MTU shall be symmetric)."
>
> So if I get the spec correctly it is illegal to increase (or decrease) MTU
> after it was exchanged (we should probably respond with error if client is
> sending request more than one).
>
> Please correct me if I'm wrong.
>

That is not the case. We set g_attrib MTU when g_attrib_new() is called,
and then it is set to default value - 23 (gattrib.c:499). While
exchanging MTU we
get MIN value of g_attrib MTU, which was previously set to 23 and remote MTU.
So it was set to 23 again. (It means that we always used default MTU).
Now we get remote MTU and local output MTU.

Increasing or decreasing MTU even if it was previously exchanged can be a point
of discussion, however PTS exchange it two times in test case TP/GAC/SR/BV-01-C.
We can create an issue for this case.

>> .
>> ---
>>  android/gatt.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/android/gatt.c b/android/gatt.c
>> index 429181f..5bf7694 100644
>> --- a/android/gatt.c
>> +++ b/android/gatt.c
>> @@ -4857,8 +4857,8 @@ static uint8_t read_request(const uint8_t *cmd,
>> uint16_t cmd_len, static uint8_t mtu_att_handle(const uint8_t *cmd,
>> uint16_t cmd_len, struct gatt_device *dev)
>>  {
>> -     uint16_t mtu, imtu;
>> -     size_t omtu;
>> +     uint16_t mtu, imtu, omtu;
>> +     size_t length;
>>       GIOChannel *io;
>>       GError *gerr = NULL;
>>       uint16_t len;
>> @@ -4877,6 +4877,7 @@ static uint8_t mtu_att_handle(const uint8_t *cmd,
>> uint16_t cmd_len,
>>
>>       bt_io_get(io, &gerr,
>>                       BT_IO_OPT_IMTU, &imtu,
>> +                     BT_IO_OPT_OMTU, &omtu,
>>                       BT_IO_OPT_INVALID);
>>       if (gerr) {
>>               error("bt_io_get: %s", gerr->message);
>> @@ -4884,10 +4885,10 @@ static uint8_t mtu_att_handle(const uint8_t *cmd,
>> uint16_t cmd_len, return ATT_ECODE_UNLIKELY;
>>       }
>>
>> -     rsp = g_attrib_get_buffer(dev->attrib, &omtu);
>> +     rsp = g_attrib_get_buffer(dev->attrib, &length);
>>
>>       /* Respond with our IMTU */
>> -     len = enc_mtu_resp(imtu, rsp, omtu);
>> +     len = enc_mtu_resp(imtu, rsp, length);
>>       if (!len)
>>               return ATT_ECODE_UNLIKELY;
>
> --
> BR
> Szymon Janc

BR
Marcin
