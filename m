Return-Path: <cyrus@holtmann.org>
Message-ID: <4D5C202B.5030403@signal11.us>
Date: Wed, 16 Feb 2011 14:06:19 -0500
From: Alan Ott <alan@signal11.us>
MIME-Version: 1.0
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jkosina@suse.cz,
	ospite@studenti.unina.it, linux-input@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, bgood@velocity.net
Subject: Re: [PATCH v4 1/2] HID: Documentation for hidraw
References: <1297829209-10511-1-git-send-email-alan@signal11.us>	<1297829209-10511-2-git-send-email-alan@signal11.us> <20110216071200.02ccdaa5@bike.lwn.net>
In-Reply-To: <20110216071200.02ccdaa5@bike.lwn.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 02/16/2011 09:12 AM, Jonathan Corbet wrote:
>>   Documentation/hid/Makefile      |    8 ++
>>   Documentation/hid/hid-example.c |  167 +++++++++++++++++++++++++++++++++++++++
>>      
> I believe we're trying to get code - especially runnable code - out of the
> Documentation tree.  Should this go under samples/ or, if it's useful
> enough, under tools/?
>    

Hi Jon,

Not a problem. I'd say samples/ over tools/ for this stuff. I'll re-spin 
and re-submit.

Alan.


