Return-Path: <cyrus@holtmann.org>
Message-ID: <4E9C50DF.5020703@linux.intel.com>
Date: Mon, 17 Oct 2011 17:59:27 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] fix build
References: <1318848980-569-1-git-send-email-frederic.danis@linux.intel.com> <20111017111035.GA19306@fusion.localdomain> <4E9C27BE.10006@linux.intel.com>
In-Reply-To: <4E9C27BE.10006@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

>>
>> I'd push the patch upstream but it fails to apply:
>>
>> fatal: cannot convert from UTF-8utf-8 to UTF-8
>>
>> I suspect that's because of the double Content-Type header in your
>> email. Could you try to fix it?
>
> I will send new version removing double Content-Type header

I finally found that ‘ generates this behavior, replacing it by ' remove 
the "cannot convert from UTF-8utf-8" problem.

Sent a v3 patch.

Fred

-- 
Frederic Danis                            Open Source Technology Centre
frederic.danis@intel.com                              Intel Corporation

