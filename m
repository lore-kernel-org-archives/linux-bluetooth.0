Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <002f01cfb07a$2502c170$6f084450$@samsung.com>
References: <001301cfafc0$ef11b350$cd3519f0$@samsung.com>
	<CABBYNZKfvD271JoWqCW=Lupu-22scZRAJ0D8ksG8bXfUP8gBkg@mail.gmail.com>
	<002f01cfb07a$2502c170$6f084450$@samsung.com>
Date: Tue, 5 Aug 2014 11:01:49 +0300
Message-ID: <CABBYNZLfh7gQHriCxU4KggpWYYyS37Z85ZCsjSLKnxU1+BoPOg@mail.gmail.com>
Subject: Re: AVCTP and AVRCP packet decoder file structure in btmon
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikrampal,

I do like to test patches individually so please make sure they
compile and in general we don't allow commits that do not compile
because they can break bisect.

On Tue, Aug 5, 2014 at 9:54 AM, Vikrampal <vikram.pal@samsung.com> wrote:
> Sure Luiz!
>
> However, I've one more small doubt. If I'm submitting a series of patches
> Such as 1/4, 2/4, 3/4, 4/4... I guess in such scenarios no need to ensure that
> the patches separately compiles. What we need to ensure is that all the patches together
> gets compiled properly. Am I mistaken?
>
>> -----Original Message-----
>> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>> Sent: Monday, August 04, 2014 4:15 PM
>> To: Vikrampal
>> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin
>> Subject: Re: AVCTP and AVRCP packet decoder file structure in btmon
>>
>> Hi Vikrampal,
>>
>> We can start by reusing avctp.c to place AV/C and AVRCP decoders, later on
>> we can review if it is the case of splitting. Also please note that
>> android/Android.mk needs updating if we change anything on the build of
>> btmon.
>>
>> On Mon, Aug 4, 2014 at 11:48 AM, Vikrampal <vikram.pal@samsung.com>
>> wrote:
>> > Hi,
>> >
>> > I'm working on AVRCP packet decoder for Bluetooth monitor module.
>> > There's a separate file avctp.c/h for AVCTP packet decoder.
>> >
>> > The file avctp.c is not a big file as such. So, I'm thinking whether
>> > or not I should include AVRCP decoder in this file itself.
>> >
>> > Shall I create a separate file for AVRCP decoding?
>> >
>> > If both AVCTP & AVRCP go in the same file then what should be the
>> > appropriate name of the file or shall I create a separate file for
>> > AVRCP as well.
>> >
>> > Please advise me. Thanks!
>> >
>> > Regards,
>> > Vikram
>> >
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
> Regards,
> Vikram
>



-- 
Luiz Augusto von Dentz
