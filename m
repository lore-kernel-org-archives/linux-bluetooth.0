Return-Path: <cyrus@holtmann.org>
From: "Zhang, Jingke" <jingke.zhang@intel.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Bluez/Obexd upstream test result_20120515
Date: Tue, 15 May 2012 07:35:39 +0000
Message-ID: <8C91AD8ED4077A4786B34154085899251024A3E1@SHSMSX102.ccr.corp.intel.com>
References: <8C91AD8ED4077A4786B34154085899251024A31C@SHSMSX102.ccr.corp.intel.com>
 <20120515072805.GB31087@aemeltch-MOBL1>
In-Reply-To: <20120515072805.GB31087@aemeltch-MOBL1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,
No, that kernel is not my test target. I just intended to get a machine as OBEX Server. At that time, the machine is with 3.0.27, and then kernel panic happened. 
I feel the bug is to say obexd-server is somewhat not compatible with some old kernel (e.g. 3.0.27). 

Detail panic picture was took and attached in the bug, do you have any idea of it? 

-----Original Message-----
From: Andrei Emeltchenko [mailto:andrei.emeltchenko.news@gmail.com] 
Sent: Tuesday, May 15, 2012 3:28 PM
To: Zhang, Jingke
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez/Obexd upstream test result_20120515

Hi Jingke,

On Tue, May 15, 2012 at 03:17:52AM +0000, Zhang, Jingke wrote:
> Hi all, This is test report for bluez-4.99.138.ga521540 and 
> obexd-0.45.40.g0f25314.

...

> Obexd-server-0.45 (server daemon) will cause old kernel (3.0.27) panic

Are you testing against this kernel?

Best regards
Andrei Emeltchenko 

