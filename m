Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH 1/3] build: Enable BIND_NOW
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
References: <20170824182824.8465-1-hadess@hadess.net>
 <1503599405.12938.1.camel@hadess.net>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <65ef0555-edc1-3fea-3b4b-8a849f78e05a@redhat.com>
Date: Mon, 18 Sep 2017 16:41:11 +0200
MIME-Version: 1.0
In-Reply-To: <1503599405.12938.1.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/24/2017 08:30 PM, Bastien Nocera wrote:
> On Thu, 2017-08-24 at 20:28 +0200, Bastien Nocera wrote:
>> From: Florian Weimer <fweimer@redhat.com>
>>
>> Partial RELRO means that the object is GNU_RELRO but not
>> BIND_NOW.  This
>> reduces the effectiveness of RELRO.  bluez triggers this because it
>> enables PIE during the build, and rpmdiff takes this as an indicator
>> that the best possible hardening is desired.
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=983161
> 
> Florian made the comments, I made the patch and sent it. Feel free to
> remove the internal Bugzilla reference before pushing.

It might be simpler to just pass through any CC/CFLAGS/LDFLAGS settings 
the build environment is using, without trying to second-guess what the 
user is doing.

Thanks,
Florian
