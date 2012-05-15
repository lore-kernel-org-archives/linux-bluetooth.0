Return-Path: <cyrus@holtmann.org>
From: "Zhang, Jingke" <jingke.zhang@intel.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Bluez/Obexd upstream test result_20120515
Date: Tue, 15 May 2012 08:17:32 +0000
Message-ID: <8C91AD8ED4077A4786B34154085899251024A463@SHSMSX102.ccr.corp.intel.com>
References: <8C91AD8ED4077A4786B34154085899251024A31C@SHSMSX102.ccr.corp.intel.com>
 <20120515075406.GC31087@aemeltch-MOBL1>
 <8C91AD8ED4077A4786B34154085899251024A42C@SHSMSX102.ccr.corp.intel.com>
 <20120515081247.GD31087@aemeltch-MOBL1>
In-Reply-To: <20120515081247.GD31087@aemeltch-MOBL1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Well, I can understand only the kernel panic picture is not enough, however, it is also hard to get call trace from my testing machine because there is no serial port. :(

But it is interesting that, same environment has no same panic if I used obexd-0.44. So, I have to notify 0.45 potential issue. I saw something related to timer.c, but I am not sure where bug is. 

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Andrei Emeltchenko
Sent: Tuesday, May 15, 2012 4:13 PM
To: Zhang, Jingke
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez/Obexd upstream test result_20120515

Hi Jingke,

On Tue, May 15, 2012 at 08:05:00AM +0000, Zhang, Jingke wrote:
> https://bugs.meego.com/show_bug.cgi?id=25107 [obexd-server] timer_softirq cause kernel panic after FTP file transfer.
> Obexd-server-0.45 (server daemon) will cause old kernel (3.0.27) panic after one file transferred, while obexd-0.44 server could work smoothly with same environment. 

The bug does not have good log to analyze.

Best regards
Andrei Emeltchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
