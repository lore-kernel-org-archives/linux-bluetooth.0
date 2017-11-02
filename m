Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZL_5UWaMuCHTAMPrfk_pDi+DRC7YXW8MZthLOScHed1uA@mail.gmail.com>
References: <CAOVXEJJirxBj+Pb203j2orSBhTxv5tzdvAqKcuhzO1W_2bhpFQ@mail.gmail.com>
 <CABBYNZJBUqbMijwCqB=4xQa3sq1qL1YdZ710-o8WVEDL7rR27Q@mail.gmail.com>
 <CABBYNZ+cj0UpcGYX42+wiW4FKYDYGf7Njg=wQQXwW8jn3gY05A@mail.gmail.com>
 <CAOVXEJKMume3RUBzqYpWWPjhP1jwSsDGGBDwqRaOs-nQqC08iw@mail.gmail.com>
 <CABBYNZ+oz352RvGP1V2pfMi3DrLNVQyvUDmNaSHqyu-_Ph+OvQ@mail.gmail.com>
 <CAOVXEJL75fO7Jk7uhFFymz2ce05nis=o=hb4Ce25_hHiQUc2hg@mail.gmail.com> <CABBYNZL_5UWaMuCHTAMPrfk_pDi+DRC7YXW8MZthLOScHed1uA@mail.gmail.com>
From: Sathish Narasimman <nsathish41@gmail.com>
Date: Thu, 2 Nov 2017 10:31:16 +0530
Message-ID: <CAOVXEJJTKongEg1AG9FNu5ubUWN3bb0ja+_3OwE1tp0gvSdDZQ@mail.gmail.com>
Subject: Re: How to change default MTU for Obex over L2CAP
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 31, 2017 at 7:09 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Sathish,
>
> On Tue, Oct 31, 2017 at 3:24 PM, Sathish Narasimman
> <nsathish41@gmail.com> wrote:
>> Hi Luiz,
>>
>> On Tue, Oct 31, 2017 at 3:03 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Sathish,
>>>
>>> On Tue, Oct 31, 2017 at 11:27 AM, Sathish Narasimman
>>> <nsathish41@gmail.com> wrote:
>>>> Hi Luiz,
>>>>
>>>> On Tue, Oct 31, 2017 at 12:53 PM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> Hi Sathish,
>>>>>
>>>>> On Tue, Oct 31, 2017 at 9:05 AM, Luiz Augusto von Dentz
>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>> Hi Sathish,
>>>>>>
>>>>>> On Tue, Oct 31, 2017 at 5:30 AM, Sathish Narasimman
>>>>>> <nsathish41@gmail.com> wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I am trying to do an OPP transfer between 2 Linux bluez system.
>>>>>>> It is always selecting the 672 MTU size during configuration.
>>>>>>>
>>>>>>> May I please know how to change the MTU size.
>>>>>>
>>>>>> It looks like for L2CAP we don't set the MTU properly but for RFCOMM we do:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/obexd/client/bluetooth.c#n129
>>>>>>
>>>>>> I will send a patch in a moment.
>>>>>
>>>>> Actually, it is the other way around, the RFCOMM don't actually
>>>>> support setting the MTU since it is a stream, though we should
>>>>> probably adjust the socket buffer size since we are using 32k for
>>>>> OBEX.
>>>>
>>>> Though I was trying to change the value for OBEX over L2CAP
>>>>
>>>> Does this have the effect of OBEX maximum packet length?
>>>> In which the maximum packet length parameter is always 672.
>>>>
>>>> Here the Default 32K omtu is changed to 672 at this point
>>>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/obexd/client/bluetooth.c#n468
>>>
>>> That should never be reached in case of RFCOMM since it is not packet
>>> based, or are you really using OBEX over L2CAP aka. GOEP 2.0, that
>>> should be using 32K but we should check the HCI traces if that is
>>> actually what is negotiated.
>>>
>> Yes I am using OBEX over L2CAP(where trying to send file to another
>> Linux system using obexctl tool it uses GOEP)
>>
>> 1. Please let me know how to change the OBEX maximum packet length
>> when receiving file (i.e In OBEX response code: Success, Maximum
>> packet length is 672 - Logs)
>> btmon Log: https://pastebin.com/BvVERsfq
>> 2. How to change the Default L2CAP MTU. In logs for configure
>> response, the MTU is 672.
>> 3. I am not able to see any logs in obexd when File is received.
>
> It is requesting 32K:
>
> < ACL Data TX: Handle 256 flags 0x00 dlen 27
>             [hci0] 43.021610
>       L2CAP: Configure Request (0x04) ident 7 len 19
>         Destination CID: 64
>         Flags: 0x0000
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 32767
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced retransmission (0x03)
>           TX window size: 63
>           Max transmit: 3
>           Retransmission timeout: 2000
>           Monitor timeout: 12000
>           Maximum PDU size: 1009
>> ACL Data RX: Handle 256 flags 0x02 dlen 23                                       [hci0] 43.023856
>       L2CAP: Configure Request (0x04) ident 4 len 15
>         Destination CID: 65
>         Flags: 0x0000
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced retransmission (0x03)
>           TX window size: 63
>           Max transmit: 3
>           Retransmission timeout: 2000
>           Monitor timeout: 12000
>           Maximum PDU size: 1009
>
> I guess because there is no MTU in the remote request we respond with 672:
>
> < ACL Data TX: Handle 256 flags 0x00 dlen 29
>             [hci0] 43.023870
>       L2CAP: Configure Response (0x05) ident 4 len 21
>         Source CID: 64
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 672
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced retransmission (0x03)
>           TX window size: 63
>           Max transmit: 3
>           Retransmission timeout: 2000
>           Monitor timeout: 12000
>           Maximum PDU size: 1009
>> ACL Data RX: Handle 256 flags 0x02 dlen 29                                       [hci0] 43.028883
>       L2CAP: Configure Response (0x05) ident 7 len 21
>         Source CID: 65
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 32767
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced retransmission (0x03)
>           TX window size: 63
>           Max transmit: 3
>           Retransmission timeout: 2000
>           Monitor timeout: 12000
>           Maximum PDU size: 1009
>
> I guess this will result in 32K omtu and 672 imtu, though Im not sure
> if the PDU size are correct either. Have tried transfering anything to
> see what is the actual payload we can carry over this channel. Btw
> keep in mind OBEX channel is using ERTM the other channels like SDP
> will have their own MTU, most likely 672.
>
Hi Luiz,

Yes, the the omtu is 32k and imtu is still 672.
I can see logs printed in obexd during TX. When running the obexd with
"sudo GOBEX_DEBUG=all ./obexd/src/obexd"
But why I am not able to see any logs for RX i.e Input files received.
May I know where the receive RX is handled?



>> Thanks,
>> Sathish N
>>
>>>>
>>>>>https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/obexd/client/bluetooth.c#n457
>>>>> --
>>>>> Luiz Augusto von Dentz
>>>
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
