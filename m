Return-Path: <cyrus@holtmann.org>
Message-ID: <4C6B6E03.7080600@Atheros.com>
Date: Wed, 18 Aug 2010 10:52:11 +0530
From: Suraj <suraj@Atheros.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>,
	<Jothikumar.Mothilal@Atheros.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: host level Support for Atheros AR300x
 device
References: <1281681408-27376-1-git-send-email-suraj@atheros.com> <1281681408-27376-2-git-send-email-suraj@atheros.com> <20100817143236.GB19862@jh-x301>
In-Reply-To: <20100817143236.GB19862@jh-x301>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 8/17/2010 8:02 PM, Johan Hedberg wrote:
> Hi,
>
> On Fri, Aug 13, 2010, Suraj Sumangala wrote:
>> Implements support for Atheros AR300x Bluetooth chip in
>> hciattach application. Supports configuration download
>> and power management configure feature.
>> ---
>>   Makefile.tools         |    7 +-
>>   tools/hciattach.8      |    3 +
>>   tools/hciattach.c      |  105 ++++++
>>   tools/hciattach.h      |    3 +
>>   tools/hciattach_ar3k.c |  859 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 974 insertions(+), 3 deletions(-)
>>   create mode 100644 tools/hciattach_ar3k.c
>
> This patch produces several errors:
>
> tools/hciattach_ar3k.c: In function ‘write_ps_cmd’:
> tools/hciattach_ar3k.c:196: error: comparison between signed and unsigned integer expressions
> tools/hciattach_ar3k.c: In function ‘get_ps_file_name’:
> tools/hciattach_ar3k.c:536: error: comparison between signed and unsigned integer expressions
> tools/hciattach_ar3k.c: In function ‘get_patch_file_name’:
> tools/hciattach_ar3k.c:552: error: comparison between signed and unsigned integer expressions
> tools/hciattach_ar3k.c:552: error: comparison between signed and unsigned integer expressions
> make[1]: *** [tools/hciattach_ar3k.o] Error 1
>
> Please fix those and always check that your patches compile cleanly with
> ./bootstrap-configure before sending them upstream. Thanks.
>
> Johan

Sorry about that,

I did do a fresh

./bootstrap-configure
./configure
make

and strangely my compiler did not catch anyone of these and it compiled 
without any warning.

Is there any flag I have to enable for this?

My gcc version says,

gcc 4.4.3

Regards
Suraj

