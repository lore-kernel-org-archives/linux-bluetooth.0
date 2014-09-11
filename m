Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJmMLnyOe682Oi7NuFtEiED3Y-epks-nJBBqMaNPS2KcA@mail.gmail.com>
References: <1410347494-22084-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1410347494-22084-4-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZJmMLnyOe682Oi7NuFtEiED3Y-epks-nJBBqMaNPS2KcA@mail.gmail.com>
Date: Thu, 11 Sep 2014 15:59:15 +0200
Message-ID: <CAMudyAuaFA1gUVE3o7d5t1DROfVfZjTibcpAJKGF0p5W=UPXcg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] android/hal-ipc-api: Add missing peer features parameter
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 11 September 2014 14:14, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Wed, Sep 10, 2014 at 2:11 PM, Lukasz Rymanowski
> <lukasz.rymanowski@tieto.com> wrote:
>> ---
>>  android/hal-ipc-api.txt | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
>> index 326fa21..0948af2 100644
>> --- a/android/hal-ipc-api.txt
>> +++ b/android/hal-ipc-api.txt
>> @@ -2228,7 +2228,8 @@ Notifications:
>>         Opcode 0x81 - Connection State Changed notification
>>
>>                 Notification parameters: State (1 octet)
>> -                                        Peer Features (1 octet)
>> +                                        Peer Features (2 octets)
>> +                                        CHLD Features (2 octets)
>>                                          Address (6 octets)
>>
>>                 Valid State values: 0x00 = Disconnected
>> --
>> 1.8.4
>
> You should probably document what are the possible values for CHLD.
>
True, I missed that.
\Łukasz
>
> --
> Luiz Augusto von Dentz
