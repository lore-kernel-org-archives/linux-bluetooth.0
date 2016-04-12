Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <570D1D9A.6030808@redhat.com>
Date: Tue, 12 Apr 2016 18:08:58 +0200
From: Denys Vlasenko <dvlasenk@redhat.com>
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>,
	Johan Hedberg <johan.hedberg@intel.com>
CC: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Deinline large functions
References: <1460399665-19626-1-git-send-email-dvlasenk@redhat.com> <1460433018.2507.1.camel@perches.com>
In-Reply-To: <1460433018.2507.1.camel@perches.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/12/2016 05:50 AM, Joe Perches wrote:
> On Mon, 2016-04-11 at 20:34 +0200, Denys Vlasenko wrote:
>> Fastest existing Bluetooth standard's top speed is 2.4 MB/s.
>> It is way off from being CPU limited, no need to squeeze
>> last few cycles by excessive inlining.
>>
>> Size reduction is about 40k:
>>
>>     text     data      bss       dec     hex filename
>> 95943139 20860256 35991552 152794947 91b7743 vmlinux_before
>> 95903714 20860256 35991552 152755522 91add42 vmlinux
> 
> defconfig?

In defconfig, CONFIG_BT is not set, so there will be no change
