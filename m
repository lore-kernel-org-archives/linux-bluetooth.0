Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADAkoF4Fn_CYXOpps0vkDyxQQvgC5OB-PNcb2=PW3Ws3-jJUhw@mail.gmail.com>
References: <1508324716-3041-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1508324716-3041-2-git-send-email-jaganathx.kanakkassery@intel.com>
 <CABBYNZLDn-K+oB7wNHJDB8svfsVwyk-VcAyNYMVqUZa2Q_fZqA@mail.gmail.com>
 <CAJzH+bpD0WqNC8WJpNcQ-6+8Rv60MNM54GQkWNg2r0qXvroNMg@mail.gmail.com>
 <CABBYNZLsGe+iXScst-N1EQPN1UAn9RewNSPghSD4PO5bhu+L4Q@mail.gmail.com>
 <CAJzH+bqs7TPWh+rHUS5MYNsYHqVwKOjA-vM3CWrV-Km9vj5org@mail.gmail.com> <CADAkoF4Fn_CYXOpps0vkDyxQQvgC5OB-PNcb2=PW3Ws3-jJUhw@mail.gmail.com>
From: Emil Lenngren <emil.lenngren@gmail.com>
Date: Mon, 23 Oct 2017 15:11:57 +0200
Message-ID: <CAO1O6sfgBU+R3cncHavdRaKWOBzLUFJda7=R+PQwH1jQ_bcL_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Implement extended LE Connection
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Cc: Jaganath K <jaganath.k.os@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2017-10-23 15:00 GMT+02:00 Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>:
>> >>> Is there any point in using extended version if we can only do
>> >>> 1Mbit/s, is there any practical difference? Is there any reason we are
>> >>> not trying 2 Mbit/s phy as well?
>> >>>
>> >>
>> >> The idea is to first implement the extended version with no functionality
>> >> change (ie with PHY as 1M). We are planning to expose kernel
>> >> interface so that user can select the PHY for the connection. We can add
>> >> other PHYs accordingly during the implementation of the interfaces.
>> >
>> > There is nothing here suggesting what sort of interface we will use
>> > for switching between 1-2 MBit/s,
>>
>> I am planning to raise separate patch for the interfaces.
>>
>> > usually, for BR/EDR we choose the
>> > best possible (or let the controller do so) we will continue with the
>> > same logic the phy policy will reside in the kernel anyway. Are there
>> > any reasons why we cannot request 2MBit/s?
>>
>> My thinking was to select 1M, 2M or LR based on the user selection.
>> Whether we need 2M or LR would be based on the usecase i think.
>> But i understand your point that we can have 2M instead of 1M if both
>> controller supports. But i am not sure whether any power consumption
>> issues (i may be dumb here) will be there wherein some use cases 1M is
>> preferred over 2M (Usecases where data rate is not relevant). But otherwise
>> as you said we can add 2M also in the PHYs by default.
>
> We cannot just have 2M instead of 1M since scanning on primary
> advertising channels in only possible on 1M or LR - so 1M is perfectly
> fine here.
> The only reason to include 2M here is to specify default connection
> parameters in case connection is established on 2M (which is still
> possible) and we want them to be different than for 1M (which are used
> if 2M is not specified).
>
> IMO having 1M only is just fine until we have proper support for other
> PHYs in place.
>

2 MBit/s consumes around half the energy since it does everything in
half the time with the same radio power consumption. But I wouldn't be
surprised if the range is worse compared to 1 MBit/s.

/Emil
