Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 3/3 v2] doc/mgmt-api: Add advertising phys support to
 flags
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJzH+bqbM4CqXvr-VoS=S=fwJAKS8ptKq=N3kyP+qWBGeLVEDQ@mail.gmail.com>
Date: Tue, 28 Nov 2017 11:22:30 +0100
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <BFD0F6B9-43BA-4036-978B-EEEB1B6D5289@holtmann.org>
References: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1511173617-25442-4-git-send-email-jaganathx.kanakkassery@intel.com>
 <2F81056C-FD07-43DB-AF9E-A767061341FD@holtmann.org>
 <CAJzH+bqbM4CqXvr-VoS=S=fwJAKS8ptKq=N3kyP+qWBGeLVEDQ@mail.gmail.com>
To: Jaganath K <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

>>> ---
>>> doc/mgmt-api.txt | 22 ++++++++++++++++++++++
>>> 1 file changed, 22 insertions(+)
>>> 
>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>>> index b59bf0c..c138f47 100644
>>> --- a/doc/mgmt-api.txt
>>> +++ b/doc/mgmt-api.txt
>>> @@ -2504,6 +2504,9 @@ Read Advertising Features Command
>>>              4       Add TX Power field to Adv_Data
>>>              5       Add Appearance field to Scan_Rsp
>>>              6       Add Local Name in Scan_Rsp
>>> +             7       Secondary Channel with LE 1M
>>> +             8       Secondary Channel with LE 2M
>>> +             9       Secondary Channel with LE Coded
>>> 
>>>      The Flags bit 0 indicates support for connectable advertising
>>>      and for switching to connectable advertising independent of the
>>> @@ -2553,6 +2556,15 @@ Read Advertising Features Command
>>>      space is limited a short version or no name information. The
>>>      Local Name will be added at the end of the scan response data.
>>> 
>>> +     The Flags bit 7 indicates support for advertising in secondary
>>> +     channel in LE 1M PHY.
>>> +
>>> +     The Flags bit 8 indicates support for advertising in secondary
>>> +     channel in LE 2M PHY. Primary channel would be on 1M.
>>> +
>>> +     The Flags bit 9 indicates support for advertising in secondary
>>> +     channel in LE CODED PHY.
>>> +
>>>      The valid range for Instance identifiers is 1-254. The value 0
>>>      is reserved for internal use and the value 255 is reserved for
>>>      future extensions. However the Max_Instances value for indicating
>>> @@ -2613,6 +2625,9 @@ Add Advertising Command
>>>              4       Add TX Power field to Adv_Data
>>>              5       Add Appearance field to Scan_Rsp
>>>              6       Add Local Name in Scan_Rsp
>>> +             7       Secondary Channel with LE 1M
>>> +             8       Secondary Channel with LE 2M
>>> +             9       Secondary Channel with LE Coded
>>> 
>>>      When the connectable flag is set, then the controller will use
>>>      undirected connectable advertising. The value of the connectable
>>> @@ -2640,6 +2655,13 @@ Add Advertising Command
>>>      supported to provide less air traffic for devices implementing
>>>      broadcaster role.
>>> 
>>> +     Secondary channel flags can be used to advertise in secondary
>>> +     channel with the corresponding PHYs. In case of 2M, the primary
>>> +     channel used would be 1M. If none of them are set then secondary
>>> +     channel advertising would be disabled for this instance which is as
>>> +     good as legacy advertising. Combining the sets would result in
>>> +     multiple advertising sets being created.
>>> +
>> 
>> I changed my mind here. The behind the scenes creating multiple advertising sets is a bad idea. That is something the application should handle and not the kernel do in the background.
>> 
>> So we should mark these bits as mutually exclusive and note that specifying more than one will result in an invalid params error. In addition we need to note that choosing LE 1M and LE 2M will result in using extended advertising with the primary channel being 1M. And choosing LE Coded will result in extended advertising with both primary and secondary channel in coded. This should be in the text description. Choosing none of these flags will result in legacy advertising.
>> 
>> This just needs a bit of wordsmithing and then it should be fine.
>> 
> 
> I will make the suggested documentation in the next patch
> 
> I think we have left out two points related to extended advertising
> with respect to current mgmt API
> 
> First thing is, Extended advertising HCI command does not have
> duration parameter of mgmt API.
> (It does have a duration param but it actually corresponds to timeout
> parameter of mgmt API).
> So shall we document that in case of extended advertising "duration"
> parameter of mgmt API will
> be ignored and controller will take care of scheduling?
> 
> Second point is current mgmt API adv_len and scan_rsp_len is only 1
> octet. So basically
> we cannot support user to send data more that 255 bytes length and
> then kernel fragment it
> based on the controllers supported data length.
> 
> We have two options here.
> 
> We can have a new Ext Advertising mgmt API which does not have
> duration parameter and adv / scan_rsp len as 2 octets. So we can
> remove PHYs also in the
> legacy adv mgmt API.
> 
> Second option is to let user does the fragmentation and add extra
> flags for that.
> But in this case also we might need new mechanism to inform user about
> maximum extended
> data length since in "Read Advertising Features" Max_Adv_Data_Len is
> also 1 octet
> 
> Please let us know your opinion on the above points.

I would currently limit it to 255 octets in length and see how that goes. Frankly any longer advertising is costing the receiver and large advertising should be avoided if not really needed. At this point, the proposed API might be enough to get started and refine it later. Adding an extra mgmt command later is not really a problem and can be done easily.

Regards

Marcel

