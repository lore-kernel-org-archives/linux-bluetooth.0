Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [RFC v2] doc: Add Management Interface network API definitions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJhzxWTG27c3X_cp=wAMq7vdUpt6hzaxsrEN69etSaiPQ@mail.gmail.com>
Date: Wed, 2 Mar 2016 07:24:40 -0800
Cc: Patrik Flykt <Patrik.Flykt@linux.intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <575ED13A-E92D-485D-9CD5-7F5357CE7D67@holtmann.org>
References: <1456484926-978-1-git-send-email-patrik.flykt@linux.intel.com> <EBF2E6B2-2086-4573-ACAF-75B7F8768F76@holtmann.org> <CABBYNZK_c-NZFELMq8s7BoQypBV7UQ34-yXU8Kv+zhiaxDn=bg@mail.gmail.com> <DBC0A7E1-0279-4787-B17D-2EBC7251AD1C@holtmann.org> <CABBYNZJhzxWTG27c3X_cp=wAMq7vdUpt6hzaxsrEN69etSaiPQ@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>>>> To make the commands more generic, IPSP has been renamed Network. In order
>>>>> to be more generic, a network role has been added to the commands rather
>>>>> than have a specific command for role setting. With this more networking
>>>>> than just 6LowPAN can be handled in the future; whether 1 octet is enough
>>>>> to handle possible future roles OR'ed together remains to be seen and
>>>>> comments on the subject are appreciated.
>>>>> 
>>>>> Handling incoming connection authorization is another topic to discuss
>>>>> with an initial proposal already on the mailing list. I'd be glad to update
>>>>> this RFC with the outcome of that discussion.
>>>>> 
>>>>> 
>>>>>   Patrik
>>>>> 
>>>>> doc/doc.txt      |   0
>>>>> doc/mgmt-api.txt | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>> 2 files changed, 172 insertions(+)
>>>>> create mode 100644 doc/doc.txt
>>>>> 
>>>>> diff --git a/doc/doc.txt b/doc/doc.txt
>>>>> new file mode 100644
>>>>> index 0000000..e69de29
>>>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>>>>> index 731a088..060b751 100644
>>>>> --- a/doc/mgmt-api.txt
>>>>> +++ b/doc/mgmt-api.txt
>>>>> @@ -2801,6 +2801,127 @@ Start Limited Discovery Command
>>>>>                             Invalid Index
>>>>> 
>>>>> 
>>>>> +Get Networks Command
>>>>> +====================
>>>>> +
>>>>> +     Command Code:           0x0042
>>>>> +     Controller Index:       <controller id>
>>>>> +     Command Parameters:
>>>>> +     Return Parameters:      Interface Index (4 Octets)
>>>>> +                             Connection_Count (2 Octets)
>>>>> +                             Address1 {
>>>>> +                                     Address (6 Octets)
>>>>> +                                     Address_Type (1 Octet)
>>>>> +                                     Network_Role (1 Octet)
>>>>> +                             }
>>>>> +                             Address2 { }
>>>>> +                             ...
>>>>> +
>>>> 
>>>> so if we want to extend this to BNEP eventually, then the interface index needs to be per Network block (and it is Network1 and not Address1).
>>>> 
>>>> I know that this means for multiple IPSP networks, the interface index would repeat since there is really only one, but I think that is something the application can easily figure out.
>>> 
>>> Actually with this concept it looks a lot like a bridge so I wonder if
>>> we really want to duplicate this functionality, the bridge actually
>>> already takes care of routing even though it seems unlikely that we
>>> will have multiple peer connected I suppose the router device can end
>>> up in a star topology, anyway with the current module it actually set
>>> the peer to peer flag which perhaps is not what we want in case of
>>> router.
>> 
>> you can not talk about bridges in the context of IPSP. They operate on different levels. BNEP is Ethernet and IPSP is pure IPv6.
>> 
>>>>> +     This command is used to retrieve a list of BTLE network
>>>>> +     connections. A pre-requisite is that LE is already
>>>>> +     enabled, otherwise this command will return a "rejected"
>>>>> +     response.
>>>>> +
>>>>> +     Possible values for the Address_Type parameter:
>>>>> +             0       Reserved
>>>>> +             1       LE Public
>>>>> +             2       LE Random
>>>>> +
>>>>> +     Possible values for the Network_Role parameter:
>>>>> +             0       Reserved
>>>>> +             1       6LoWPAN Node
>>>>> +             2       6LoWPAN Router
>>>> 
>>>> I wonder if here we actually want to call it IPSP Node instead. I only dislike IPSP in the command name. In parameters it seems fine.
>>>> 
>>>> And do we need to differentiate between Node and Router here. I think that at some point Johan and discussed that the application (aka bluetoothd) is responsible for adding advertising instances. I wonder if we consider this more like Add Device were we punch a whole for allowing incoming connections. Keep in mind there is an extra thread ongoing about adding Add Device Type == 0x03 for exactly that case.
>>> 
>>> In that case why not make Type 0x03 as "Trust this device", this would
>>> make a lot of things simpler including not sending L2CAP responses
>>> with authorization pending when the device is trusted saving some time
>>> in the process.
>> 
>> Add Device Type == 0x03 is for allowing incoming connections and allowing us to use whitelist for efficient processing on the link layer. I have no idea what L2CAP has to do with that here.
> 
> I though you were suggesting using it instead of regular
> authorization, in that case we will need to authorize peers connecting
> in some other means which is might be necessary for the
> node/peripheral.

that is pretty much the question here. Does adding it means an implicit Add Device internally. Or does it mean that the application has to do it all by itself. Same argument can be made for Add Advertising.

Regards

Marcel

