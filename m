Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 31 May 2016 07:11:57 +0200 (CEST)
From: Dennis Kadioglu <denk@post.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <1116111592.162575276.1464671516930.JavaMail.zimbra@dkadioglu.de>
In-Reply-To: <1881831.AdeVxpHkvy@ix>
References: <286937503.150813787.1464432672488.JavaMail.zimbra@dkadioglu.de> <1881831.AdeVxpHkvy@ix>
Subject: Re: Name and Class in main.conf ignored
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

thanks for your immediate answer. Using -P hostname now and it works!
One question: Shouldn't the settings in the configuration file supersede otherwise configured settings? I want to change the class of my device but, on the other hand I don't want to change the hostname which is set by the hostname plugin, I can't do that now. Instead I have to disable the whole plugin by changing the bluetooth.service file and therefor I have to take care for the changed bluetooth.service file in case of updates. What are the reasons for the current implementation? Would it be possible to change the current implementation in a way, that settings in main.conf overwrite settings in other places?

----- Ursprüngliche Mail -----
Von: "Szymon Janc" <szymon.janc@codecoup.pl>
An: "denk" <denk@post.com>
CC: linux-bluetooth@vger.kernel.org
Gesendet: Sonntag, 29. Mai 2016 11:30:24
Betreff: Re: Name and Class in main.conf ignored

Hi,

On Saturday 28 May 2016 12:51:12 denk wrote:
> Hi,
> 
> I would like to configure the name and the class using the respective
> entries in /etc/bluetooth/main.conf. Unfortunately without success. Both
> values are ignored or overwritten, I don't know.
> 
> Any ideas why it doesn't work? Am I doing something wrong? Is there maybe an
> alternative way to achieve this?
> 
> Thanks in advance.
> 

This is probably due to hostname plugin. Try disabling it  (-P option) in 
command line.

-- 
pozdrawiam
Szymon Janc
