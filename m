Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <86206570.650879.1534433068088.JavaMail.jboss@ep1ml504>
Mime-Version: 1.0
Subject: RE: Re: Not able to set Default PHY configuration
Reply-To: anupam.r@samsung.com
From: Anupam Roy <anupam.r@samsung.com>
To: Jaganath K <jaganath.k.os@gmail.com>
CC: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        SACHIN DEV SHARMA <sachin.dev@samsung.com>
In-Reply-To: <CAJzH+bpXfDxmS4hZSi8836HUhWOTnwP9hG0Y6Qfyb89DKRPqOQ@mail.gmail.com>
Date: Fri, 17 Aug 2018 00:24:28 +0900
Content-Type: multipart/mixed;
        boundary="----=_Part_650878_178355981.1534433068088"
References: <CAJzH+bpXfDxmS4hZSi8836HUhWOTnwP9hG0Y6Qfyb89DKRPqOQ@mail.gmail.com>
        <1533912735-3878-1-git-send-email-anupam.r@samsung.com>
        <CGME20180810145329epcas2p28873946a2150bb9949f8877119ba4d3a@epcms5p7>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

------=_Part_650878_178355981.1534433068088
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"

Hi Jaganath,

>--------- Original Message ---------
>Sender : Jaganath K <jaganath.k.os@gmail.com>
>Date   : 2018-08-11 17:50 (GMT+9)
>Title  : Re: Not able to set Default PHY configuration
> 
>Hi Anupam,
>
>>On Fri, Aug 10, 2018, 8:26 PM Anupam Roy <anupam.r@samsung.com> wrote:
>>Hello list,
>>
>> Regarding the Set PHY configuration management command, I have a following observation during my test with a BT 5.0 LE Only controller
>>
>>I am encountering error on SET PHY (2MTX) MGMT command from btmgmt.
>>
>>
>>[hci1]# phy
>>
>>Supported phys: [0x7e00] [1MTX 1MRX 2MTX 2MRX CODEDTX CODEDRX ]
>>
>>Configurable phys: [0x7800] [2MTX 2MRX CODEDTX CODEDRX ]
>>
>>Selected phys: [0x600] [1MTX 1MRX ]
>>
>>
>>@ MGMT Command: Get PHY Configuration (0x0044) plen 0    
>>
>>@ MGMT Event: Command Complete (0x0001) plen 15  
>>
>>      Get PHY Configuration (0x0044) plen 12
>>
>>        Status: Success (0x00)
>>
>>        Supported PHYs: 0x7e00
>>
>>          LE 1M TX
>>
>>          LE 1M RX
>>
>>          LE 2M TX
>>
>>          LE 2M RX
>>
>>          LE CODED TX
>>
>>          LE CODED RX
>>
>>        Configurable PHYs: 0x7800
>>
>>          LE 2M TX
>>
>>          LE 2M RX
>>
>>          LE CODED TX
>>
>>          LE CODED RX
>>
>>        Selected PHYs: 0x0600
>>
>>          LE 1M TX
>>
>>          LE 1M RX
>>
>>
>>
>>[hci1]# phy 2MTX
>>
>>Could not set PHY Configuration with status 0x0d (Invalid Parameters)
>>
>>
>> MGMT Command: Set PHY Configuration (0x0045) plen 4 
>>
>>        Selected PHYs: 0x0800
>>
>>          LE 2M TX
>>
>>@ MGMT Event: Command Status (0x0002) plen 3 
>>
>>      Set PHY Configuration (0x0045)
>>
>>        Status: Invalid Parameters (0x0d)
>>
>>
>>
>>As per https://kernel.googlesource.com/pub/scm/linux/kernel/git/bluetooth/bluetooth-next/+/master/net/bluetooth/mgmt.c#3412
>>
>>
>>if ((selected_phys & unconfigure_phys) != unconfigure_phys)
>>
>>        return mgmt_cmd_status(INVALID_PARAMS)
>>
>>
>>In my case, unconfigurable PHY is 0x600(1MTX and 1MRX) [supported_phys(0x7e00) &  ~configure_phys (0x7FF) = 0x600]
>>
>>If from btmgmt, user wants to select 2MTX (0x800), then the above condition returns error to user, 
>>
>>whereas I think, out intention here is to allow kernel to set preference of 2MTX to controller, as 2MTX is a configurable PHY? Am I missing something here?
>>
>>
>>Actually, I am not sure if unconfigure_phys logic is added to prevent user to select one of the unconfigureable PHY's.
>>
>>If above is the case, then will not be the following logic correct?
>>
>>
>>
>>   + if (selected_phys & unconfigure_phys)
>>
>>   +            return ERROR
>>
>>   + else
>>
>>   +            proceed
>>
>>
>>which will basically mean if any of the bits in the user's selected bit field matches with that of the unconfigurable PHY's bits, then we may return error to user, otherwise proceed normally?
>>
>>Please share your opinion. Thank you very much!
>>
>>
>>BR,
>>
>>-Anupam Roy
>
>Currently LE 1M TX and LE 1M RX is unconfigurable meaning it shall not be deselected.

Ok, got it, Much thanks for the clarification!

>
>So if you want to select 2M TX, then the command should be
>phy LE_1M_TX LE_2M_TX LE_1M_RX

Although, btmgmt is currently not supported to accept more than one PHY as input option, I enabled it for my test and managed to verify the Default PHY Set command. 
Further to this, I will raise changes for btmgmt to accept more than one PHY option.

>
>Thanks,
>Jaganath
> 
>>BR,
>>-Anupam Roy

BR,
-Anupam Roy

------=_Part_650878_178355981.1534433068088
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="rcptInfo.txt"
Content-Transfer-Encoding: base64

DQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIFN1YmplY3QgICAgOiBSZTogTm90IGFibGUgdG8g
c2V0IERlZmF1bHQgUEhZIGNvbmZpZ3VyYXRpb24NCiAgICAgIEZyb20gICAgICAgOiBudWxsDQog
ICAgICBTZW50IERhdGUgIDogMjAxOC0wOC0xMSAxNzo1MCAgR01UKzkNCiAgID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KICAgICAgICAgICAgICAgICAgTmFtZSAgICAgICAgICAgICAgICBUeXBlICAgICAgICAg
IEpvYiBUaXRsZSAgICAgICAgICAgICAgICAgICAgICAgRGVwdC4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQ29tcGFueSAgICAgICAgICAgICAgICANCiAgID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
ICAgICAgQW51cGFtIFJveSAgICAgICAgICAgICAgICAgICAgIFRPICAgICAgICAgU3RhZmYgRW5n
aW5lZXIgICAgICAgICAgICAgQWR2YW5jZWQgU1cgVGVhbSAvU1JJLURlbGhpICAgICAgICAgICAg
ICAgU2Ftc3VuZyBFbGVjdHJvbmljcw0KICAgICAgbGludXgtYmx1ZXRvb3RoQHZnZXIua2Vybi4u
LiAgIENDDQogICAgICBTQUNISU4gREVWIFNIQVJNQSAgICAgICAgICAgICAgQ0MgICAgICAgICBQ
cmluY2lwYWwgUHJvZmVzc2lvbmEuLi4gICBBZHZhbmNlZCBTVyBUZWFtIC9TUkktRGVsaGkgICAg
ICAgICAgICAgICBTYW1zdW5nwqBFbGVjdHJvbmljcw0KICAgPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo=

------=_Part_650878_178355981.1534433068088--
