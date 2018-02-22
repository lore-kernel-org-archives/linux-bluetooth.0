Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1731980.7kiFeXdM4S@ix>
References: <1511938373-22396-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <CAExxLLCOBc5=_XG9g5fTqD_fuSLDHLj=62wXxwZtPAo_7J__Ww@mail.gmail.com>
 <CAJzH+boewxsR-3mBwL1Tn6-u4MotqLeww2FXiw4NKe7QJViizQ@mail.gmail.com> <1731980.7kiFeXdM4S@ix>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Thu, 22 Feb 2018 11:19:14 +0530
Message-ID: <CAJzH+boM4OiqSUSWctkHL=KfMc5PgTt8jBpeOrU0ceAo+6x9Mw@mail.gmail.com>
Subject: Re: [PATCH 2/4 v4] doc/mgmt-api: Add support for Set Phy
 Configuration command
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Feb 21, 2018 at 1:17 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> Hi,
>
> On Wednesday, 21 February 2018 07:09:49 CET Jaganath K wrote:
>> >>>>>>> I think there is a limitation with current API proposal, user cannot
>> >>>>>>> do extended scanning in only 1M (to scan secondary channel in 1M)
>> >>>>>>> since with 1M we will switch to legacy scanning.
>> >>>>>>
>> >>>>>> Why do we have to switch to legacy scanning for 1M? It seems it would
>> >>>>>> be possible to use extended scanning whenever it is supported
>> >>>>>> regardless of the PHY, or perhaps the spec imposes limitations to
>> >>>>>> certain PHYs? Coded perhaps?
>> >>>>>
>> >>>>> The idea is to enable application to use legacy scanning even if
>> >>>>> controller supports
>> >>>>> extended. (ie if application dont want extended features to be used)
>> >>>>> and unlike advertising
>> >>>>> legacy scanning can not be emulated using extended scanning.
>> >>>>
>> >>>> Bluetooth controller which is doing extended scanning will report
>> >>>> legacy
>> >>>> advertisings as well. It will just use Extended Advertising Report
>> >>>> Event for this purpose and Linux Kernel should handle it.
>> >>>
>> >>> Yes, but the idea here is more on perspective of power savings
>> >>> where in application dont want to scan on secondary channels itself and
>> >>> API should support it.
>> >
>> > Then maybe there should not be dependence between this command and
>> > scan/connect. Actually I do not understand why we have it, need to check
>> > previous conversation.
>> >
>> >> I would agree if this affects passive scanning, but in that case we
>> >> can probably program the scan type when adding a device or only really
>> >> scan on primary channel since the purpose is to connect it doesn't
>> >> really matter what is on the secondary channels, for active scanning I
>> >> don't think we would be saving that much power since that should be
>> >> short-lived so Im not sure we should bother with it.
>> >
>> > In extended advertising there is no such thing as connectable and
>> > scannable at the same time
>> > When device is connectable, then address and optionally advertising
>> > data is in the aux ptr (secondary channel)
>> >
>> > Please also remember that it is up to controller to connect / scan on
>> > secondary PHY based on primary PHY provided by host.
>> > Meaning, host controls primary channel only, which can be 1M or Coded.
>> > Rest is up to controller and data in AUX_PTR of ADV_EXT_IND
>>
>> I would wait for Marcel's comments here.
>
> FWIW Apache Mynewt (master, soon to be released 1.4) has full support for
> Extended Advertising and Scanning including all PHYs (on nRF52840) and data
> fragmentation. You can build blehci app and use it with BlueZ for testing.
>

It looks like we have to use Extended scanning always if supported
(even though i could
not find this restriction in core spec), the test is there in HCI TS spec -
HCI/GEV/BV-03-C [Disallow Mixing Legacy and Extended Scanning
Commands].

Actually in my first patch sets, it was done like this (use extended
features always if supported),
So i will rebase it and resent it for review.

Thanks,
Jaganath
