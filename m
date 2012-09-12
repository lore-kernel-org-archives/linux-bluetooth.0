Return-Path: <cyrus@holtmann.org>
Message-ID: <5050E7D0.9000904@jeffhansen.com>
Date: Wed, 12 Sep 2012 13:51:44 -0600
From: Jeff Hansen <x@jeffhansen.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@intel.com>
Subject: Re: Removal of fakehid support
References: <5050E143.4010400@jeffhansen.com> <CABBYNZL8r5EM4FpkUMLzMfuD3AtQqmu5LEwCbXTu=h+sxEntmQ@mail.gmail.com>
In-Reply-To: <CABBYNZL8r5EM4FpkUMLzMfuD3AtQqmu5LEwCbXTu=h+sxEntmQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sure, I can for now, but please don't release 4.102 until the kernel
driver is ready !!  I don't want any distros picking up a bluez with
*less* functionality than before (as you can imagine)!

-Jeff

On 09/12/2012 01:45 PM, Luiz Augusto von Dentz wrote:
> Hi Jeff,
>
> On Wed, Sep 12, 2012 at 10:23 PM, Jeff Hansen <x@jeffhansen.com> wrote:
>> Johan,
>>
>> AFAICT there is no actual implementation for the PS3 remote in the
>> kernel.  How can I use my PS3 remote now that fakehid has been removed?
> Check the thread about logitech armony, we will have to write the
> driver. While we are doing that can't you use some older version of
> BlueZ?
>
>
>


-- 
---------------------------------------------------
"If someone's gotta do it, it might as well be me."
                x@jeffhansen.com

