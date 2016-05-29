Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: denk <denk@post.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Name and Class in main.conf ignored
Date: Sun, 29 May 2016 11:30:24 +0200
Message-ID: <1881831.AdeVxpHkvy@ix>
In-Reply-To: <286937503.150813787.1464432672488.JavaMail.zimbra@dkadioglu.de>
References: <286937503.150813787.1464432672488.JavaMail.zimbra@dkadioglu.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
