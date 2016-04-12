Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <570D22DD.2010109@redhat.com>
Date: Tue, 12 Apr 2016 18:31:25 +0200
From: Denys Vlasenko <dvlasenk@redhat.com>
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>,
	Johan Hedberg <johan.hedberg@intel.com>
CC: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Deinline large functions
References: <1460399665-19626-1-git-send-email-dvlasenk@redhat.com>	 <1460433018.2507.1.camel@perches.com> <570D1D9A.6030808@redhat.com> <1460477690.2507.5.camel@perches.com>
In-Reply-To: <1460477690.2507.5.camel@perches.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/12/2016 06:14 PM, Joe Perches wrote:
> On Tue, 2016-04-12 at 18:08 +0200, Denys Vlasenko wrote:
>> On 04/12/2016 05:50 AM, Joe Perches wrote:
>>>
>>> On Mon, 2016-04-11 at 20:34 +0200, Denys Vlasenko wrote:
>>>>
>>>> Fastest existing Bluetooth standard's top speed is 2.4 MB/s.
>>>> It is way off from being CPU limited, no need to squeeze
>>>> last few cycles by excessive inlining.
>>>>
>>>> Size reduction is about 40k:
>>>>
>>>>     text     data      bss       dec     hex filename
>>>> 95943139 20860256 35991552 152794947 91b7743 vmlinux_before
>>>> 95903714 20860256 35991552 152755522 91add42 vmlinux
>>> defconfig?
>> In defconfig, CONFIG_BT is not set, so there will be no change
> 
> Which is why I set it in the defconfig size I sent.

I deleted "# CONFIG_BT is not set" in my .config,
then reran "make oldconfig" and answered "yes" to all questions.

The result is:

    text    data     bss      dec    hex filename
10587382 4369552 1097728 16054662 f4f986 vmlinux_before
10575926 4369552 1097728 16043206 f4ccc6 vmlinux

> Also, you haven't responded at all to any performance decrease
> by uninline for low power/low frequency SOC embedded uses.

I think the performance will be the same, since BT
is a quite slow protocol as it is, it is unlikely to be CPU bound
(or more precisely, you'd need something like 10 MHz CPU
to be CPU bound with BT).

The lowest power device with BT I have is a smartphone,
a Samsung S5 mini with quad-core 1.4 GHz Exynos 3 CPU.
It will be 2 years old soon.
This is what passes for "low power devices" these days.
