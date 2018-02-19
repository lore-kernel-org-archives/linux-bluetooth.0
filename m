Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+MMgCo2m-3bgdq6Ww3vb5w3pCKgubrvjryu4b1SPwJEA@mail.gmail.com>
References: <1511938373-22396-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1511938373-22396-3-git-send-email-jaganathx.kanakkassery@intel.com>
 <CAJzH+bpA-QXMCZLdDABDDZA6R1F4R+nTttKFx41JFAGnrOfaFw@mail.gmail.com>
 <CABBYNZJfov2M5egFaokJuYdrTZAqU48Xy7rE4Zv21=j8fw0FJg@mail.gmail.com>
 <CAJzH+brcoCP1BpKL=VDmfvNk-7ZK8heVjvOaVyN4xiW3K6ChGw@mail.gmail.com>
 <CAExxLLCUc0W7n6w-Beh7e5dOd7aGOAvG5Dcw4fEozCAX7nBMyw@mail.gmail.com>
 <CAJzH+bok8hZ5y3VjTS3Hx9gqPYMJ3_9bcuqZJr9-agD3tqCOTg@mail.gmail.com> <CABBYNZ+MMgCo2m-3bgdq6Ww3vb5w3pCKgubrvjryu4b1SPwJEA@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Date: Mon, 19 Feb 2018 12:07:57 +0100
Message-ID: <CAExxLLCOBc5=_XG9g5fTqD_fuSLDHLj=62wXxwZtPAo_7J__Ww@mail.gmail.com>
Subject: Re: [PATCH 2/4 v4] doc/mgmt-api: Add support for Set Phy
 Configuration command
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jaganath K <jaganath.k.os@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz, Jaganath

On 19 February 2018 at 11:31, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jaganath,
>
> On Mon, Feb 19, 2018 at 12:09 PM, Jaganath K <jaganath.k.os@gmail.com> wr=
ote:
>> Hi Lukasz,
>>
>> On Mon, Feb 19, 2018 at 3:28 PM, =C5=81ukasz Rymanowski
>> <lukasz.rymanowski@codecoup.pl> wrote:
>>> Hi Jaganath,
>>>
>>> On 19 February 2018 at 10:25, Jaganath K <jaganath.k.os@gmail.com> wrot=
e:
>>>> Hi Luiz,
>>>>
>>>>
>>>> On Mon, Feb 19, 2018 at 2:17 PM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> Hi Jaganath,
>>>>>
>>>>> On Fri, Feb 16, 2018 at 5:40 AM, Jaganath K <jaganath.k.os@gmail.com>=
 wrote:
>>>>>> Hi Marcel,
>>>>>>
>>>>>>
>>>>>> On Wed, Nov 29, 2017 at 12:22 PM, Jaganath Kanakkassery
>>>>>> <jaganath.k.os@gmail.com> wrote:
>>>>>>> This also adds PHY Configuration Changed Event.
>>>>>>> ---
>>>>>>>  doc/mgmt-api.txt | 52 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>>>>>>  1 file changed, 52 insertions(+)
>>>>>>>
>>>>>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>>>>>>> index c07c48c..628ff18 100644
>>>>>>> --- a/doc/mgmt-api.txt
>>>>>>> +++ b/doc/mgmt-api.txt
>>>>>>> @@ -2940,9 +2940,46 @@ Get PHY Configuration Command
>>>>>>>         LE 1M TX and LE 1M RX would be supported by default.
>>>>>>>
>>>>>>>         This command is only available for LE capable controllers.
>>>>>>> +        It will return Not Supported otherwise.
>>>>>>> +
>>>>>>> +        Possible errors:        Not Supported
>>>>>>> +                               Invalid Index
>>>>>>> +
>>>>>>> +Set PHY Configuration Command
>>>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>>>>> +
>>>>>>> +       Command Code:           0x0044
>>>>>>> +       Controller Index:       <controller id>
>>>>>>> +       Command Parameters:     Default_phys (2 Octet)
>>>>>>> +       Return Parameters:
>>>>>>> +
>>>>>>> +       This command is used to set the default phy to the controll=
er.
>>>>>>> +
>>>>>>> +       This will be stored and used for all the subsequent scannin=
g
>>>>>>> +       and connection initiation.
>>>>>>> +
>>>>>>> +       The list of supported PHYs can be retrieved via the
>>>>>>> +       Get PHY Configuration command. Selecting unsupported PHYs w=
ill
>>>>>>> +       result in an Invalid Parameters error.
>>>>>>> +
>>>>>>> +       This can be called at any point to change the preferred PHY=
s.
>>>>>>> +
>>>>>>> +       Default_phy is a bitmask with the following bits.
>>>>>>> +               0       LE 1M TX
>>>>>>> +               1       LE 1M RX
>>>>>>> +               2       LE 2M TX
>>>>>>> +               3       LE 2M RX
>>>>>>> +               4       LE CODED TX
>>>>>>> +               5       LE CODED RX
>>>>>>> +
>>>>>>> +       This command generates a Command Complete event on success
>>>>>>> +       or a Command Status event on failure.
>>>>>>> +
>>>>>>> +       This command is only available for LE capable controllers.
>>>>>>>         It will return Not Supported otherwise.
>>>>>>>
>>>>>>>         Possible errors:        Not Supported
>>>>>>> +                               Invalid Parameters
>>>>>>>                                 Invalid Index
>>>>>>>
>>>>>>
>>>>>> I think there is a limitation with current API proposal, user cannot=
 do extended
>>>>>> scanning in only 1M (to scan secondary channel in 1M) since with 1M =
we will
>>>>>> switch to legacy scanning.
>>>>>
>>>>> Why do we have to switch to legacy scanning for 1M? It seems it would
>>>>> be possible to use extended scanning whenever it is supported
>>>>> regardless of the PHY, or perhaps the spec imposes limitations to
>>>>> certain PHYs? Coded perhaps?
>>>>>
>>>>
>>>> The idea is to enable application to use legacy scanning even if
>>>> controller supports
>>>> extended. (ie if application dont want extended features to be used)
>>>> and unlike advertising
>>>> legacy scanning can not be emulated using extended scanning.
>>>
>>> Bluetooth controller which is doing extended scanning will report legac=
y
>>> advertisings as well. It will just use Extended Advertising Report
>>> Event for this purpose and Linux Kernel should handle it.
>>>
>>
>> Yes, but the idea here is more on perspective of power savings
>> where in application dont want to scan on secondary channels itself and
>> API should support it.

Then maybe there should not be dependence between this command and scan/con=
nect.
Actually I do not understand why we have it, need to check previous
conversation.

>
> I would agree if this affects passive scanning, but in that case we
> can probably program the scan type when adding a device or only really
> scan on primary channel since the purpose is to connect it doesn't
> really matter what is on the secondary channels, for active scanning I
> don't think we would be saving that much power since that should be
> short-lived so Im not sure we should bother with it.

In extended advertising there is no such thing as connectable and
scannable at the same time
When device is connectable, then address and optionally advertising
data is in the aux ptr (secondary channel)

Please also remember that it is up to controller to connect / scan on
secondary PHY based on primary PHY provided by host.
Meaning, host controls primary channel only, which can be 1M or Coded.
Rest is up to controller and data in AUX_PTR of ADV_EXT_IND

>
> --
> Luiz Augusto von Dentz

=C5=81ukasz
