Return-Path: <cyrus@holtmann.org>
From: "Zhang, Jingke" <jingke.zhang@intel.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Bluez/Obexd upstream test result_20120515
Date: Tue, 15 May 2012 08:05:00 +0000
Message-ID: <8C91AD8ED4077A4786B34154085899251024A42C@SHSMSX102.ccr.corp.intel.com>
References: <8C91AD8ED4077A4786B34154085899251024A31C@SHSMSX102.ccr.corp.intel.com>
 <20120515075406.GC31087@aemeltch-MOBL1>
In-Reply-To: <20120515075406.GC31087@aemeltch-MOBL1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,
It might be the typo from my copy/paste. I resend bug info:

New bugs (4):
==============================
https://bugs.meego.com/show_bug.cgi?id=25109 [Regression to 0.44] obexd-0.45 FTP-Server failed to accept file transfer request. 
Regression to obexd-0.44 (FTP Server). FTP/OPP failed. 

https://bugs.meego.com/show_bug.cgi?id=25107 [obexd-server] timer_softirq cause kernel panic after FTP file transfer.
Obexd-server-0.45 (server daemon) will cause old kernel (3.0.27) panic after one file transferred, while obexd-0.44 server could work smoothly with same environment. 

https://bugs.meego.com/show_bug.cgi?id=25114 MAP profile needs message engine.
Is there implementation plan for MCE notification and SMS upload/delete functions? 

https://bugs.meego.com/show_bug.cgi?id=25111 upstream bluez configure parameter needs VDP profile enabled. 
Does upstream bluez support VDP profile?
==============================

Thanks for your finding. 
To bug#25109 and bug#25107, they are not same issue. Since 3.0.27 is not available, I took another system with 2.6.32-38-generic-pae kernel as OBEX Server, and found bug#25109.  

-----Original Message-----
From: Andrei Emeltchenko [mailto:andrei.emeltchenko.news@gmail.com] 
Sent: Tuesday, May 15, 2012 3:54 PM
To: Zhang, Jingke
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez/Obexd upstream test result_20120515

Hi Jingke,

On Tue, May 15, 2012 at 03:17:52AM +0000, Zhang, Jingke wrote:
...
> New bugs (4): ===============================================
> https://bugs.meego.com/show_bug.cgi?id=25109 [Regression to 0.44]
> obexd-0.45 FTP-Server failed to accept file transfer request 
> Regression to obexd-0.44 (FTP Server). FTP/OPP failed.
> 
> https://bugs.meego.com/show_bug.cgi?id=25109 [obexd-server] 
> timer_softirq cause kernel panic after FTP file transfer

Are those the same bug 25109 ?

Best regards
Andrei Emeltchenko 

