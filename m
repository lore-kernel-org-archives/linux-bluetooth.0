Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJz1xqmeZY39Zi7=iZ73_dm+f5K+00rqfTHgJmsqSao4A@mail.gmail.com>
References: <1410347494-22084-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1410347494-22084-2-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZJz1xqmeZY39Zi7=iZ73_dm+f5K+00rqfTHgJmsqSao4A@mail.gmail.com>
Date: Thu, 11 Sep 2014 15:58:13 +0200
Message-ID: <CAMudyAtQJUm-VHWxF4EOxRFgnWk_ouHt_sNyJeoSDbrB00K_Yw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] android/hal-ipc-api: Use 2 bytes for location in
 dial memory
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 11 September 2014 14:08, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Wed, Sep 10, 2014 at 2:11 PM, Lukasz Rymanowski
> <lukasz.rymanowski@tieto.com> wrote:
>> ---
>>  android/hal-ipc-api.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
>> index ca41cff..26e777e 100644
>> --- a/android/hal-ipc-api.txt
>> +++ b/android/hal-ipc-api.txt
>> @@ -2162,7 +2162,7 @@ Commands and response:
>>
>>         Opcode 0x09 - Dial Memory command/response
>>
>> -               Command parameters: Location (1 octet)
>> +               Command parameters: Location (2 octet)
>>                 Response parameters: <none>
>>
>>                 In case of an error, the error response will be returned.
>> --
>> 1.8.4
>
> I guess we need a little bit more info here, does the spec limit this
> to 2 octets because it seems the callback actually takes an int:
>
> bt_status_t (*dial_memory) (int location);
>
Yup, but in the end we are doing string out of this number
and this is why I thought that 65535 is enough for number location.

But we can fix it if necessary to be consistent.

\Łukasz

> Btw, I guess this is subject to change since it does not take the
> address this would limit such callbacks to only one phone, in fact
> many callback have this limitation which is kind of weird as both
> connect/disconnect and connect_audio/disconnect_audio have the
> address.
>
>
> --
> Luiz Augusto von Dentz
