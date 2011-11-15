Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC1D53D.4030500@codeaurora.org>
Date: Mon, 14 Nov 2011 18:58:05 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Antonio Ospite <ospite@studenti.unina.it>,
 linux-bluetooth@vger.kernel.org
Subject: Re: Building master on Debian systems fails at linking "check".
References: <20111114155620.4fc2987fad25c9ccd724f68a@studenti.unina.it>		 <4EC15A27.90305@codeaurora.org>		 <20111114225100.c75e709827f4b22fa83e0327@studenti.unina.it>	 <1321323919.15441.475.camel@aeonflux> <4EC1CEEB.2000702@codeaurora.org> <1321325610.15441.479.camel@aeonflux>
In-Reply-To: <1321325610.15441.479.camel@aeonflux>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 11/14/2011 6:53 PM, Marcel Holtmann wrote:
>> I believe it is more likely an X86-64 issue.  And support for libcheck
>> is checked (and is there), but for some reason fails in this instance.
>
> So what does "pkg-config --libs check" actually tells you?


$ pkg-config --libs check
-lcheck


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
