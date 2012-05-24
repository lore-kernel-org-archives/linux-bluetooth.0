Return-Path: <cyrus@holtmann.org>
Message-ID: <4FBE37AF.9000801@monom.org>
Date: Thu, 24 May 2012 15:29:19 +0200
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1 3/3] device: Ignore DUN if PAN is present
References: <1337853618-7261-1-git-send-email-wagi@monom.org> <1337853618-7261-4-git-send-email-wagi@monom.org> <20120524102120.GC23856@x220>
In-Reply-To: <20120524102120.GC23856@x220>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 24.05.2012 12:21, Johan Hedberg wrote:
> Hi Daniel,
> 
> On Thu, May 24, 2012, Daniel Wagner wrote:
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -63,6 +63,8 @@
>>  #include "btio.h"
>>  #include "attrib-server.h"
>>  #include "attrib/client.h"
>> +#include "network/common.h"
>> +#include "serial/common.h"
> 
> I don't really like the idea of creating dependencies from the core
> daemon (src/*) to plugin or profile directories. Any other (clean) way
> we could avoid this?

Okay, good point.

I see that update_sevice() already uses PNP_UUID which happens to be
defined in src/storage.h. Maybe we could move all *_UUID into one header
file into the core? Would that be an option?

cheers,
daniel
