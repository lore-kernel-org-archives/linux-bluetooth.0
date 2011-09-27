Return-Path: <cyrus@holtmann.org>
Message-ID: <4E81B7AA.7040108@start.ca>
Date: Tue, 27 Sep 2011 07:46:50 -0400
From: Colin Beckingham <colbec@start.ca>
MIME-Version: 1.0
To: Hendrik Sattler <post@hendrik-sattler.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Installation from git did not proceed cleanly?
References: <4E81AA25.6090907@start.ca> <20110927132332.23237dubrv7x0k08@mail.hendrik-sattler.de>
In-Reply-To: <20110927132332.23237dubrv7x0k08@mail.hendrik-sattler.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On 09/27/2011 07:23 AM, Hendrik Sattler wrote:
> Zitat von Colin Beckingham <colbec@start.ca>:
>
>> Hi, a few observations on installation from git repository on a
>> reasonably fresh install of OpenSUSE 11.4. (Previous installations
>> from tar.gz have all run correctly first time.)
>>
>> 1. Fetching the clone from the temporary repo not a problem
>> 2. ./configure instruction from README/INSTALL did not work, no
>> configure found
>
> That one is called boot-strapping and is the same for many projects
> using autoconf. For convenience reasons, it's done before creating
> tarballs. That's probably the reason you are not used to it.
>
> So to create the configure script (and other files), either run "chmod
> +x bootstrap; ./bootstrap" or just "autoreconf -f -i".
>

Thanks for this advice. Works no problem.

In an earlier thread "Permission denied (13) on Samsung WEP475 headset?" 
I reported an issue. I see that in this latest version it is still 
necessary to issue an

hciconfig 0 sspmode 0

before the unit will connect. Not a problem. If this is unexpected 
behaviour from the programme I can provide more feedback.

Colin Beckingham
