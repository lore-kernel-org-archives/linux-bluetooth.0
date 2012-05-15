Return-Path: <cyrus@holtmann.org>
From: "Zhang, Jingke" <jingke.zhang@intel.com>
To: "Hedberg, Johan" <johan.hedberg@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Bluez/Obexd upstream test result_20120515
Date: Tue, 15 May 2012 08:07:13 +0000
Message-ID: <8C91AD8ED4077A4786B34154085899251024A43E@SHSMSX102.ccr.corp.intel.com>
References: <8C91AD8ED4077A4786B34154085899251024A31C@SHSMSX102.ccr.corp.intel.com>
 <20120515073840.GA19367@x220>
In-Reply-To: <20120515073840.GA19367@x220>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,
Thanks for your information. I will remove VDP cases from my list. 

-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@intel.com] 
Sent: Tuesday, May 15, 2012 3:39 PM
To: Zhang, Jingke
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez/Obexd upstream test result_20120515

Hi Jingke,

On Tue, May 15, 2012, Zhang, Jingke wrote:
> https://bugs.meego.com/show_bug.cgi?id=25111 upstream bluez configure 
> parameter needs VDP profile enabled Does upstream bluez support VDP 
> profile?

BlueZ doesn't support VDP so this bug doesn't seem valid, and even if it did support it configure script options and config file settings are a packaging issue, i.e. not upstream related.

Johan
