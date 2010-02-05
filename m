Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Kernel panic when SCO connection
Date: Fri, 5 Feb 2010 21:45:53 +0800
Message-ID: <C408AA84F077D5498977E4A236357B2206C1E8FB@ZMY16EXM67.ds.mot.com>
In-Reply-To: <f97b2b971002042041icdafbfaq4382eb631d5c34bf@mail.gmail.com>
References: <912bb79a1002020858lda468aci6fef3e73fac07bd6@mail.gmail.com> <20100202171612.GA7034@vigoh> <912bb79a1002022051o1faf229en95605084fa0e380b@mail.gmail.com> <C408AA84F077D5498977E4A236357B2206C1E687@ZMY16EXM67.ds.mot.com> <f97b2b971002042037j5397ef4j7ceb0521ef12e082@mail.gmail.com> <f97b2b971002042041icdafbfaq4382eb631d5c34bf@mail.gmail.com>
From: "SINGH DEVENDRA-DHGW76" <DevSingh@motorola.com>
To: "Ahmed Ragab" <elmasri.ahmed@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ahmed,

Yes you are right.

Regards,
Dev

-----Original Message-----
From: Ahmed Ragab [mailto:elmasri.ahmed@gmail.com] 
Sent: Friday, February 05, 2010 10:12 AM
To: SINGH DEVENDRA-DHGW76
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Kernel panic when SCO connection

I think we where writing at the same time

> Hi dev,
>
> Thanks for your suggestions i followed it , however i am have problem 
> with step  3.
>

 In step 3

>> int len = (urb->iso_frame_desc[i].actual_length >
>> urb->iso_frame_desc[i].length)?
>>             urb->iso_frame_desc[i].length:
>>             urb->iso_frame_desc[i].actual_length;
>>
>> __recv_frame(husb,
>>                 _urb->type,
>>                urb->transfer_buffer + urb->iso_frame_desc[i].offset,
>>                len);
>
where in the below snapshot from hci_usb.c should we make this work around
>
>        for (i=0; i < urb->number_of_packets; i++) {
>                        BT_DBG("desc %d status %d offset %d len %d", i,
>                                        urb->iso_frame_desc[i].status,
>                                        urb->iso_frame_desc[i].offset,
>                                        
> urb->iso_frame_desc[i].actual_length);
>
>                        if (!urb->iso_frame_desc[i].status) {
>                                husb->hdev->stat.byte_rx += 
> urb->iso_frame_desc[i].actual_length;
>                                hci_recv_fragment(husb->hdev, 
> _urb->type,
>                                        urb->transfer_buffer + 
> urb->iso_frame_desc[i].offset,
>                                        
> urb->iso_frame_desc[i].actual_length);
>                        }
>                }
> #else
>                ;
> #endif
>        } else {
>                husb->hdev->stat.byte_rx += count;
>                err = hci_recv_fragment(husb->hdev, _urb->type, 
> urb->transfer_buffer, count);
>                if (err < 0) {
>                        BT_ERR("%s corrupted packet: type %d count %d",
>                                        husb->hdev->name, _urb->type, 
> count);
>                        hdev->stat.err_rx++;
>                }
>        }
>
>
 Thanks

Ahmed
>
>
>
> On 4 February 2010 06:36, SINGH DEVENDRA-DHGW76 <DevSingh@motorola.com> wrote:
>> Hi,
>>
>> I noticed the same problem when I was working with a embedded board 
>> with Broadcom chipset and Linux kernel 2.6.18 (I guess). Use case 
>> was, a Bluetooth based headset sends data to the CSR Bluetooth 
>> dongle(USB), which in turn provide data to the Application through bluez stack.
>>
>>
>> Following were my observation:
>>
>> 1. Board processor is not strong enough and so there was no URB in 
>> the queue and audio data was getting accumulated in the USB host controller.
>> There are only 2 Rx URBs (hci_usb.h: #define HCI_MAX_ISOC_RX 2).
>> 2. Actual length of data for data in the URB is reaching to the level 
>> of 1K bytes. (Max ISOC data length) however Bluetooth driver is 
>> expecting 10 packets of 64 bytes each. hci_usb_isoc_rx_submit 
>> function in hci_usb.c file.
>> 3. Completion routine copies data for actual length returned for 
>> packet that could be 1024 while limit for one packet is 64B only. (hci_usb.c:
>> hci_usb_rx_complete function).
>> 4. These "SCO packet for unknown connection handle" error logs 
>> further complicated the problem as this will further eat-up cpu time.
>>
>>
>> Cause:
>>
>> Max length of available transfer buffer could be 640 bytes (that's 
>> depend upon the buffer index) and copying big chunk of data was 
>> resulting into memory overrun and kernel memory was getting corrupted 
>> that results in un-expected behavior line connection break, lots of 
>> noise  and even kernel panic some times.
>>
>>
>> Following was the work around:
>>
>> 1. Increased number of Rx URBs to 6. (hci_usb.h: #define 
>> HCI_MAX_ISOC_RX 6).
>> 2. Increased transfer buffer size to 1.5K.
>> 3. Put a check in completion routine that in case actual length is 
>> more then frame length then copy only frame length size data as follows:
>>
>> int len = (urb->iso_frame_desc[i].actual_length >
>> urb->iso_frame_desc[i].length)?
>>             urb->iso_frame_desc[i].length:
>>             urb->iso_frame_desc[i].actual_length;
>>
>> __recv_frame(husb,
>>                 _urb->type,
>>                urb->transfer_buffer + urb->iso_frame_desc[i].offset,
>>                len);
>> 4. Logging "SCO packet for unknown connection handle" error only once 
>> for 100 errors. This will give more change to queue a URB as 
>> follows(hci_core.c:hci_scodata_packet function):
>> hdev->stat.err_rx++;
>> if(!(hdev->stat.err_rx % 100))
>> {
>>        BT_ERR("%s 100 SCO packets for unknown connection 
>> handles",hdev->name); }
>>
>>
>> I must say that I did not try with latest Linux kernel however I 
>> could not see any code change regarding this functionality. Hope this 
>> will help.
>>
>> Regards,
>> Dev
>>
>>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org
>> [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of nirav 
>> rabara
>> Sent: Wednesday, February 03, 2010 10:21 AM
>> To: Gustavo F. Padovan
>> Cc: linux-bluetooth@vger.kernel.org
>> Subject: Re: Kernel panic when SCO connection
>>
>> - Show quoted text -
>> On Tue, Feb 2, 2010 at 10:46 PM, Gustavo F. Padovan 
>> <padovan@profusion.mobi> wrote:
>>> Hi Nirav,
>>>
>>> * nirav rabara <niravrabara@gmail.com> [2010-02-02 22:28:53 +0530]:
>>>
>>>> Hi,
>>>> When I try to connect SCO socket, Kernel getting crash.
>>>> Linux kernel - 2.6.22
>>>> Bluez - 4.58
>>>
>>> Please try a 2.6.33 kernel and tell us if the bug still happens.
>>>
>>>>
>>>> error message,
>>>> __tx_submit:hci0 tx submit failed urb c0552c14 type 3 err -19
>>>>
>>>> sometimes in connection is showing error while connection as below, 
>>>> hci_acldata_packet:hci0 ACL packet data for unknown connection 
>>>> handler 2
>>>>
>>>> It would be really appreciable if  somebody put some on light on 
>>>> this
>>
>>>> issue, OR suggest me any patch or documentation.
>>>>
>>>> --
>>>> With Regards,
>>>> Nirav Rabara
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>> linux-bluetooth" in the body of a message to 
>>>> majordomo@vger.kernel.org More majordomo info at 
>>>> http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> Gustavo F. Padovan
>>> http://padovan.org
>>>
>>> ProFUSION embedded systems - http://profusion.mobi
>>>
>>
>> Hi Gustavo,
>>
>> Thanks for your suggestion, but I am using bluez 4.58 on ATMEL 
>> AT91SAM9263, no patch available for the newer kernel 2.6.33 . Patches 
>> related to my board only available up to 2.6.30.
>>
>> It would be a great help if suggest me any alternet for this issue. 
>> OR any patches for the same problem as i mentioned for 2.6.22.
>>
>>
>> --
>> With Regards,
>> Nirav Rabara
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-bluetooth" in the body of a message to 
>> majordomo@vger.kernel.org More majordomo info at  
>> http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-bluetooth" in the body of a message to 
>> majordomo@vger.kernel.org More majordomo info at  
>> http://vger.kernel.org/majordomo-info.html
>>
>
