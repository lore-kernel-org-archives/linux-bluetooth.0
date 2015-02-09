Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ0jqD2v5AinPztFDkV7nb4GARkdg1wMNZLGk87r4VVzQ@mail.gmail.com>
References: <1418850810-31655-1-git-send-email-jpawlowski@google.com>
	<CAD0=r8xZVpW0mEwuAORpw06Ki-aqZBZ=ybwwgKb2J1uJ6BaVCA@mail.gmail.com>
	<CABBYNZJ0jqD2v5AinPztFDkV7nb4GARkdg1wMNZLGk87r4VVzQ@mail.gmail.com>
Date: Mon, 9 Feb 2015 10:12:17 -0800
Message-ID: <CAD0=r8z_o_8mXL_4W_0vBeMOVh_6WgE3-9tEH7_C+RsRtfTPww@mail.gmail.com>
Subject: Re: [PATCH v4] doc/adapter-api.txt: StartFilteredDiscovery method.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Feb 9, 2015 at 2:25 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jakub,
>
> On Sat, Feb 7, 2015 at 1:08 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> Hi,
>>
>> Since there are no more comments for this proposal, can we please submit
>> this doc ?
>> I'll send implementation for review today.
>
> I just take a look and there some things it might be worth discussing,
> see the comments bellow.
>
>> Regards,
>> Jakub
>>
>> On Wed, Dec 17, 2014 at 1:13 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>>> This patch proposes new method, StartFilteredDiscovery to D-Bus Adapter
>>> API for desktop bluetoothd. It will allow for rapid discovery of nearby
>>> devices that advertise services.
>>>
>>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>>> ---
>>>  doc/adapter-api.txt | 40 ++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 40 insertions(+)
>>>
>>> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
>>> index 74d235a..e07c74c 100644
>>> --- a/doc/adapter-api.txt
>>> +++ b/doc/adapter-api.txt
>>> @@ -22,6 +22,46 @@ Methods              void StartDiscovery()
>>>                         Possible errors: org.bluez.Error.NotReady
>>>                                          org.bluez.Error.Failed
>>>
>>> +               void StartFilteredDiscovery(dict filter, string transport)
>>> +
>>> +                       This method starts the device discovery session with
>>> +                       filtering by uuids, and rssi or pathloss value. Use
>>> +                       StopDiscovery to release the sessions acquired.
>>> +
>>> +                       transport parameter:
>>> +                               "auto"  - interleaved scan, default value. It
>>> +                                         will cause a BR/EDR & LE interleaved
>>> +                                         scan on dual-mode controllers, on
>>> +                                         single-mode (LE-only/BREDR-only)
>>> +                                         controllers it will work on whatever
>>> +                                         the controller supports.
>>> +                               "bredr" - br/edr inquiry
>>> +                               "le"    - le only scan
>
> I think we can move the transport to the filters and make it optional
> assuming auto by default, this would mean the signature is just a
> dictionary. Btw, tere is no explanation what would happen if another
> process call StartDiscovery? Id say they could coexist but the
> implementation gets a bit trickier since that means we need to
> overwrite the transport.
>

So the thing with transport is tricky:
"le" is useful , using "bredr", or  "auto" doesn't have sense right
now. Internally we parse only LE advertisements, I left the transport
field because in future there might be some implementation for other
transports (very, very unlikely, as there is no info about services in
BT classic advertisement),

The main reason why I created this method is that I needed to quickly
discover LE devices that have particular UUID in advertisement, and
get updates about how their RSSI change over time. Using "auto"
internally does interleaved scan, so I get information about LE
devices for few seconds, and then for few seconds we get nothing
(which is very bad and kills my use case).

That makes 'transport' parameter kind of special, and I decided to
leave it outside the dicttionary, but I might put it into dictionary
if you preffer it this way.

There are also few reasons why filtered discovery can't coexist with
regular StartDiscovery:
- StartDiscovery does scan using interleaved transport, or whatever is
avaliable on controller, StartFilteredDiscovery must use what it gets
as parameter, changing transport for filtered discovery makes it
unusable.
- StartDiscovery return all found devices, and don't send updates
about RSSI changes under 8dB, StartFilteredDiscovery send updates
about each, even small RSSI changes, and filter all devices not
matching filter.
- Right now both methods do very different things on kernel level, and
there is proposal to add a separate controller level command that
would implement filtered discovery, so in far future both methods
would do very different things even on controller level.

When you try to run StartFilteredDiscovery and StartDiscovery
together, whichever was the last call wins, but I'm open to any
suggestions there. Returning "Busy" in error when other scan method is
running also seemed like good idea. I intentionally left this
unspecified, as this might change later (I hope that this kind of
detail might change in experimental API?). There are few projects that
will use this FilteredDiscovery, I want to gather the feedback first,
and then specify exact behaviour.


>>> +                       Parameters that can be set in filter dictionary include
>>> +                       the following:
>>> +
>>> +                       array{string} UUIDs : filtered service UUIDs (required)
>>> +                       int16 RSSI      : RSSI threshold value (optional)
>>> +                       uint16 pathloss : Pathloss threshold value (optional)
>>> +
>>> +                       When a device is found that advertise any UUID from
>>> +                       UUIDs, it will be reported if:
>>> +                       - pathloss and RSSI are both empty,
>>> +                       - only pathloss param is set, device advertise TX pwer,
>>> +                         and computed pathloss is less than pathloss param,
>>> +                       - only RSSI param is set, and received RSSI is higher
>>> +                         than RSSI param,
>>> +
>>> +                       This process will start creating Device objects as new
>>> +                       devices matching criteria are discovered. It will also
>>> +                       emit PropertiesChanged signal for already existing
>>> +                       Device objects, with updated RSSI value.
>>> +
>>> +                       Possible errors: org.bluez.Error.NotReady
>>> +                                        org.bluez.Error.Failed
>>> +                                        org.bluez.Error.InvalidArguments
>>> +
>>>                 void StopDiscovery()
>>>
>>>                         This method will cancel any previous StartDiscovery
>>> --
>>> 2.1.0
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
