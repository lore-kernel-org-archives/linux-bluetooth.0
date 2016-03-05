Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 5 Mar 2016 22:15:52 +0100
From: Alexander Aring <alex.aring@gmail.com>
To: Patrik Flykt <patrik.flykt@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/5] bluetooth: Merge Bluetooth 6lowpan functionality to
 bluetooth module
Message-ID: <20160305211551.GA8911@omega>
References: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com>
 <1457091644-21536-2-git-send-email-patrik.flykt@linux.intel.com>
 <20160305210644.GA1853@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160305210644.GA1853@omega>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Mar 05, 2016 at 10:06:44PM +0100, Alexander Aring wrote:
> Hi,
> 
> tried that patch out and it fails:
> 
> net/bluetooth/af_bluetooth.c:32:35: fatal error:
> net/bluetooth/6lowpan.h: No such file or directory #include <net/bluetooth/6lowpan.h>
> 
> There is some missing file. :-)
> 
> Actually while review I tried to find the prototypes for init/exit
> functionality. So this file is missing somehow but I think it should include:
> 
> #ifdef CONFIG_BT_6LOWPAN
> ... prototypes ...
> #else
> static inline empty files of prototypes

s/files/functions/

Also if the above is true to put the prototypes there, why putting it
into a "global" header file. Use some local header #include "6lowpan.h"
or something else. :-)

Maybe I oversight something here and there are good arguments to put it
into a global header.

- Alex
