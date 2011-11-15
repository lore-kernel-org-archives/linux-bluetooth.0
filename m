Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC1CEEB.2000702@codeaurora.org>
Date: Mon, 14 Nov 2011 18:31:07 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Antonio Ospite <ospite@studenti.unina.it>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Building master on Debian systems fails at linking "check".
References: <20111114155620.4fc2987fad25c9ccd724f68a@studenti.unina.it>	 <4EC15A27.90305@codeaurora.org>	 <20111114225100.c75e709827f4b22fa83e0327@studenti.unina.it> <1321323919.15441.475.camel@aeonflux>
In-Reply-To: <1321323919.15441.475.camel@aeonflux>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 11/14/2011 6:25 PM, Marcel Holtmann wrote:
> Hi Antonio,

>> I think using a “libcheck_pic aware” m4 macro is the way to go, ideally
>> this should be provided in the check package itself, I'll try asking the
>> Debian maintainers if there is no interest for a solution in BlueZ.
>
> why on earth does Debian has to do everything different than any other
> distribution. I am getting pretty sick of that :(
>
> The easiest way is to just disable any kind of unit testing when the
> check support is not found. Simple as that. I am not bothering to make
> this work on Debian.

This is *not* a Debian issue, as it also happens on Ubuntu.

I believe it is more likely an X86-64 issue.  And support for libcheck 
is checked (and is there), but for some reason fails in this instance.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
