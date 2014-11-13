Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: "Urbani, Edmund" <edmund.urbani@lilandit.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: hcitool lescan scripting question...
Date: Thu, 13 Nov 2014 17:56:21 +0100
Message-ID: <1744955.ySyCBhVlDQ@uw000953>
In-Reply-To: <5461EEC6.8070706@LilandIT.com>
References: <5461EEC6.8070706@LilandIT.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Edmund,

On Tuesday 11 of November 2014 12:11:02 Urbani, Edmund wrote:
> 
> Hello,
> 
> now this may seem like a silly question, but I have been trying to do some 
> simple shell scripting with hcitool's LE scan and redirected its out and err 
> streams. The result is not quite what I am expecting:
> 
> hcitool lescan --duplicates > /tmp/lescan.out
> 
> This will create the output file immediately, but it remains empty until the 
> hcitool process terminates. Only then does the entire output get flushed. Any 
> idea why the output does not get written immediately? Ie. why I can't "tail -f 
> /tmp/lescan.out"?
> 
> My intention was to pipe the output through a shell script to add a timestamp to 
> each line, so I get a simple log during testing. I did not want to modify 
> hcitool/write my own C program just for this purpose.

This is due to stdout buffering. Try with stdbuf:
stdbuf -oL hcitool lescan --duplicates > /tmp/lescan.out

-- 
Best regards, 
Szymon Janc
