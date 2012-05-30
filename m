Return-Path: <cyrus@holtmann.org>
Message-ID: <4FC5E94D.4040504@monom.org>
Date: Wed, 30 May 2012 11:33:01 +0200
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1 1/3] main: Add IngoreDUN configuration switch
References: <1337853618-7261-1-git-send-email-wagi@monom.org> <1337853618-7261-2-git-send-email-wagi@monom.org> <20120524174145.GC10754@samus>
In-Reply-To: <20120524174145.GC10754@samus>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

Sorry for the late response. Was away :)

On 24.05.2012 19:41, Vinicius Costa Gomes wrote:
>> +
>> +# If a device supports both DUN and PAN at the same time, ignore the
>> +# DUN profile. Only PAN will be exposed through the D-Bus API in this
>> +# case. The default is true
>> +IgnoreDUN = true
> 
> I would prefer if this would be called something like "PreferPAN" (or
> even "PreferPANoverDUN", but that sounds weird). I, at least, find it
> easier to understand.

Funny, the first version the flag was named "PreferPANoverDUN".

All other variables are kept short, that is why I used IgnoreDUN. If
"PreferPANoverDUN" is acceptable, I rather named this way.

"PreferPAN" is not really correct in my opinion, because PAN will be
always there just DUN will be filtered out.

> And I am still thinking if it would be worth considering something more
> complex, that would deal with cases like this in general. But as I don't
> have any concrete proposal, I will stop here.

Yep, I was also thinking on something more general for policing. But
without real use cases I would rather not try to solve something we
don't have a problem yet.

thanks,
daniel
