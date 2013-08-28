Return-Path: <cyrus@holtmann.org>
Message-ID: <521E0AAA.10309@richardneill.org>
Date: Wed, 28 Aug 2013 15:35:22 +0100
From: Richard Neill <rn214@richardneill.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: How to test/debug bluetooth advertising [with hciconfig]?
References: <521DCF49.5020807@richardneill.org> <20130828103920.GD15469@aemeltch-MOBL1> <521DDAB3.2050407@richardneill.org> <20130828115343.GE15469@aemeltch-MOBL1>
In-Reply-To: <20130828115343.GE15469@aemeltch-MOBL1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Andrei,

Thanks for your help.

>>
>> However, before I delve into this in great detail, I wonder whether
>> I am about to "re-invent the wheel".  For example, if I wanted to
>> use "ping" in a shell-script, I wouldn't normally begin by poking
>> registers in the ethernet card.
>
> Then you should not use "hcitool cmd". Better use high level API.

I'd love to use a high level API. But where can I find it? There doesn't 
seem to be any documentation, or any example code for Bluetooth Low 
Energy on Linux.

BTLE documentation only seem to be documented for Windows, iOS, or 
Android. I'm sorry if I seem to be being dense, but while I can find 
lots of references to 2007-era bluetooth tutorials, lots of information 
on how wonderful BTLE is, and a lot of questions on eg stackexchange 
asking *how* to do this, there doesn't seem to be any starting point for 
actually doing it.

hciconfig looks to be the natural place to start (it has the commands to 
enable and disable LE advertising, but appears to have omit the command 
to set the advertising data itself).

Regards,

Richard
