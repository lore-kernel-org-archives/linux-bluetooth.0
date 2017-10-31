Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+oz352RvGP1V2pfMi3DrLNVQyvUDmNaSHqyu-_Ph+OvQ@mail.gmail.com>
References: <CAOVXEJJirxBj+Pb203j2orSBhTxv5tzdvAqKcuhzO1W_2bhpFQ@mail.gmail.com>
 <CABBYNZJBUqbMijwCqB=4xQa3sq1qL1YdZ710-o8WVEDL7rR27Q@mail.gmail.com>
 <CABBYNZ+cj0UpcGYX42+wiW4FKYDYGf7Njg=wQQXwW8jn3gY05A@mail.gmail.com>
 <CAOVXEJKMume3RUBzqYpWWPjhP1jwSsDGGBDwqRaOs-nQqC08iw@mail.gmail.com> <CABBYNZ+oz352RvGP1V2pfMi3DrLNVQyvUDmNaSHqyu-_Ph+OvQ@mail.gmail.com>
From: Sathish Narasimman <nsathish41@gmail.com>
Date: Tue, 31 Oct 2017 18:54:09 +0530
Message-ID: <CAOVXEJL75fO7Jk7uhFFymz2ce05nis=o=hb4Ce25_hHiQUc2hg@mail.gmail.com>
Subject: Re: How to change default MTU for Obex over L2CAP
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Oct 31, 2017 at 3:03 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Sathish,
>
> On Tue, Oct 31, 2017 at 11:27 AM, Sathish Narasimman
> <nsathish41@gmail.com> wrote:
>> Hi Luiz,
>>
>> On Tue, Oct 31, 2017 at 12:53 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Sathish,
>>>
>>> On Tue, Oct 31, 2017 at 9:05 AM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi Sathish,
>>>>
>>>> On Tue, Oct 31, 2017 at 5:30 AM, Sathish Narasimman
>>>> <nsathish41@gmail.com> wrote:
>>>>> Hi,
>>>>>
>>>>> I am trying to do an OPP transfer between 2 Linux bluez system.
>>>>> It is always selecting the 672 MTU size during configuration.
>>>>>
>>>>> May I please know how to change the MTU size.
>>>>
>>>> It looks like for L2CAP we don't set the MTU properly but for RFCOMM we do:
>>>>
>>>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/obexd/client/bluetooth.c#n129
>>>>
>>>> I will send a patch in a moment.
>>>
>>> Actually, it is the other way around, the RFCOMM don't actually
>>> support setting the MTU since it is a stream, though we should
>>> probably adjust the socket buffer size since we are using 32k for
>>> OBEX.
>>
>> Though I was trying to change the value for OBEX over L2CAP
>>
>> Does this have the effect of OBEX maximum packet length?
>> In which the maximum packet length parameter is always 672.
>>
>> Here the Default 32K omtu is changed to 672 at this point
>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/obexd/client/bluetooth.c#n468
>
> That should never be reached in case of RFCOMM since it is not packet
> based, or are you really using OBEX over L2CAP aka. GOEP 2.0, that
> should be using 32K but we should check the HCI traces if that is
> actually what is negotiated.
>
Yes I am using OBEX over L2CAP(where trying to send file to another
Linux system using obexctl tool it uses GOEP)

1. Please let me know how to change the OBEX maximum packet length
when receiving file (i.e In OBEX response code: Success, Maximum
packet length is 672 - Logs)
btmon Log: https://pastebin.com/BvVERsfq
2. How to change the Default L2CAP MTU. In logs for configure
response, the MTU is 672.
3. I am not able to see any logs in obexd when File is received.

Thanks,
Sathish N

>>
>>>https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/obexd/client/bluetooth.c#n457
>>> --
>>> Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
