Return-Path: <cyrus@holtmann.org>
Message-id: <124E43A676044D2D8CAE8E93A72BBD6C@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Syam Sidhardhan <syamsidhardh@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1322144076-1913-1-git-send-email-s.syam@samsung.com>
 <20111202111510.GA15891@x220.ger.corp.intel.com> <4EDA85AA.3060400@gmail.com>
 <20111204205541.GA3918@fusion.localdomain>
Subject: Re: [PATCH 1/3] Fix dbus reply memory leak
Date: Mon, 05 Dec 2011 20:50:06 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

----- Original Message ----- 
From: "Johan Hedberg" <johan.hedberg@gmail.com>
To: "Syam Sidhardhan" <syamsidhardh@gmail.com>
Cc: "Syam Sidhardhan" <s.syam@samsung.com>; 
<linux-bluetooth@vger.kernel.org>
Sent: Monday, December 05, 2011 2:25 AM
Subject: Re: [PATCH 1/3] Fix dbus reply memory leak


> Hi Syam,
>
> On Sun, Dec 04, 2011, Syam Sidhardhan wrote:
>> >Your commit message uses the word leak in singular form but there are
>> >multiple fixes in this patch, i.e. the commit message is misleading. In
>> >this case I'd split the patch into four separate ones:
>> >
>> >telephony-maemo5: Fix D-Bus reply memory leaks
>> >cups: Fix D-Bus reply memory leaks
>> >agent: Fix D-Bus reply memory leaks
>> >mpris-player: Fix D-Bus reply memory leaks
>> >
>> >Johan
>>
>> Yes, you are correct. You can split it into multiple patches.
>> Thanks in advance.
>
> Maybe I was a bit unclear: I'm expecting *you* to do this split and
> resend the patches. Thanks :)
>
> Johan

Ok :-),
I'll split it and send.

Regadrs,
Syam 

