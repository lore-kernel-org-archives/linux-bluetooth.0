Return-Path: <cyrus@holtmann.org>
Message-ID: <521DDAB3.2050407@richardneill.org>
Date: Wed, 28 Aug 2013 12:10:43 +0100
From: Richard Neill <rn214@richardneill.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: How to test/debug bluetooth advertising [with hciconfig]?
References: <521DCF49.5020807@richardneill.org> <20130828103920.GD15469@aemeltch-MOBL1>
In-Reply-To: <20130828103920.GD15469@aemeltch-MOBL1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On Wed, Aug 28, 2013 at 11:22:01AM +0100, Richard Neill wrote:
>> Dear All,
>>
>> I'm trying to get "hello world" working from the shell between 2
>> Bluetooth 4 dongles, in LE advertising mode. I wonder whether I
>> could ask for some pointers?
>
> Check ogf and ocf from the Bluetooth Specification.

Dear Andrei,

Thanks for your reply. That was actually very helpful: by searching 
specifically for "ogf ocf Bluetooth specification", I was able to locate 
the right part of the relevant document (a 600 page PDF of Bluetooth 4.0 
core).

However, before I delve into this in great detail, I wonder whether I am 
about to "re-invent the wheel".  For example, if I wanted to use "ping" 
in a shell-script, I wouldn't normally begin by poking registers in the 
ethernet card.

If nobody else has written the utility, I'm happy to do so, (and I'll 
publish the results), but I wonder whether it has already been done?

Best wishes,

Richard


P.S. I sent a patch to hciconfig yesterday: was it sufficient to just 
post it to this list, or is there anything else I should do in order to 
get feedback and to have it considered for acceptance into bluez ?

