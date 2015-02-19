Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJLTA8hHfXjX3bigc5QDsnDeMs9ED_Qz0=3EkSy_f6pxYsGVyg@mail.gmail.com>
References: <1417786152-19742-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CAN_7+YZ78YgyHFgXXUaKbxZo6CeiNV+Pc=1bNGZ3qcPdWwc0nA@mail.gmail.com>
	<CAJLTA8hHfXjX3bigc5QDsnDeMs9ED_Qz0=3EkSy_f6pxYsGVyg@mail.gmail.com>
Date: Thu, 19 Feb 2015 13:02:56 +0100
Message-ID: <CAN_7+Yb93AidXHUavMPU+9N8125G3Ogm4bA_MMWfu5BvDWBK7A@mail.gmail.com>
Subject: Re: [PATCH] doc/mgmt-api: Add support to add/remove advertising data instance
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Michael Janssen <jamuraa@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Wed, Feb 18, 2015 at 8:40 PM, Michael Janssen <jamuraa@google.com> wrote:
> Hi Lukasz,
>
> On Wed, Feb 18, 2015 at 12:53 AM, Lukasz Rymanowski
> <lukasz.rymanowski@gmail.com> wrote:
>> Hi,
>>
>> On Fri, Dec 5, 2014 at 2:29 PM, Lukasz Rymanowski
>> <lukasz.rymanowski@tieto.com> wrote:
>>> Multi advertising is design for embedded devices having multiple GATT
>>> application running on it. Since Advertising data are size limited there
>>> is a need to have a way to make sure that each application will be
>>> advertised and in the same time visible for GATT Client application.
>>>
>>> It has been noticed that there is many GATT clients doing filtering on
>>> Service UUIDs contained in advertising data.
>>>
>>> Since this command is design for embedded devices, we allow to choose
>>> whether given data element shall be in advertising data or scan
>>> response.
>>>
>>> This patch also enhance supported settings with multi advertising bit
>>> which indicates to user space that kernel supports that.
>>> ---
>>>  doc/mgmt-api.txt | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 72 insertions(+)
>>>
>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>>> index fed41a9..8a947f1 100644
>>> --- a/doc/mgmt-api.txt
>>> +++ b/doc/mgmt-api.txt
>>> @@ -267,6 +267,7 @@ Read Controller Information Command
>>>                 12      Debug Keys
>>>                 13      Privacy
>>>                 14      Controller Configuration
>>> +               15      Multi Advertising
>>>
>>>         This command generates a Command Complete event on success or
>>>         a Command Status event on failure.
>>> @@ -2214,6 +2215,77 @@ Start Service Discovery Command
>>>                                 Invalid Index
>>>
>>>
>>> +Add Advertising Data Instance
>>> +=============================
>>> +
>>> +       Command Code:           0x003b
>>> +       Controller Index:       <controller id>
>>> +       Command Parameters:
>>> +                               Flags (4 Octet)
>>> +                               Num_Of_Data_Elements (1 Octet)
>>> +                               Data_Element_1 {
>>> +                                       Flags (4 Octet)
>>> +                                       Type (1 Octet)
>>> +                                       Value_Length (1 Octet)
>>> +                                       Value (Variable)
>>> +                               }
>>> +                               Data_Element_2 { }
>>> +                               ...
>
> I'd rather just have the API user set the advertising data octets
> manually than have a complicated structure like this. Having TX power
> complicates things a little but you could still have the flag and then
> just have the kernel add TX power on the end of the data.  Short Name
> I think can be set by the upper layers too which would be more
> flexible.
>

It's not that complicated, it is just TLV.
We considered to use just raw bytes but as you noticed, kernel already
has some data to put there like tx power/ name. Not sure if we want
upper layer to play with a name.
Also connectable and discoverable flags is something kernel already
have but on IRC I saw that actually we could allow application to
control that (?)
Also when using raw bytes in that API, Kernel has no control on data
correctness in AD unless it would parse received data. In this case
having TLV makes things easier.
But it all depends on how big control we want to add user space in
terms of AD. Let's wait for more comments.

>>> +
>>> +       Return Parameters:      Advertising_Instance_ID (2 Octets)
>>> +
>>> +       This command allows to set User Advertising Data Instance which are advertised
>>> +       in such manner so each element has its own advertising time slice then it
>>> +       expires and next item gets its advertising time slice.
>>> +
>>> +       Note that kernel has own instance which always gets its advertising time
>>> +       slice.
>>> +
>>> +       Note that maximum length of Advertising Data and Scan Response is
>>> +       specified to 31 bytes each.
>>> +
>>> +       Possible values Flags parameter are a bit-wise or of the following bits:
>>> +               0       Include Short Name
>>> +               1       Include TX Power
>>> +
>>> +       Possible values for Data Element Flags are a bit-wise or of the following
>>> +       bits:
>>> +               0       Force include into advertising data
>>> +               1       Force include into scan response
>>> +
>>> +       Possible values for the Type parameter are specified by Bluetooth SIG and can
>>> +       be found in Assigned Number section for Generic Access Profile.
>>> +
>>> +       This command can be used when the controller is not powered and
>>> +       all settings will be programmed once powered and advertising is enabled.
>>> +
>>> +       Provided advertising data instances are persistent over power down/up toggles.
>>> +
>>> +       Possible errors:        Not Supported
>>> +                               Invalid Parameters
>>> +                               Invalid Index
>>> +
>>> +
>>> +Remove Advertising Data Instance
>>> +================================
>>> +
>>> +       Command Code:           0x003c
>>> +       Controller Index:       <controller id>
>>> +       Command Parameters:     Advertising_Instance_ID (1 Octet)
>
> Should be 2 Octets to match above.

Yes, realized that once I sent it :)

 Need to rebase too, the next
> available command codes are 0x003d now.

True, but we need to wait for more comments I guess, so will not
rebase till then.

\Lukasz
>
>>> +       Return Parameters:
>>> +
>>> +       This command is use to remove user advertising instance created with
>>> +       Add User Advertising Instance
>>> +
>>> +       This command generates a Command Complete event on success or a
>>> +       Command Status event on failure.
>>> +
>>> +
>>> +       Possible errors:        Not Supported
>>> +                               Invalid Parameters
>>> +                               Invalid Index
>>> +
>>> +
>>>  Command Complete Event
>>>  ======================
>>
>> ping
>>
>>>
>>> --
>>> 1.8.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> Michael Janssen
