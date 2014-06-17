Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jun 2014 15:45:46 +0300
From: 'Andrei Emeltchenko' <andrei.emeltchenko.news@gmail.com>
To: Vikrampal <vikram.pal@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
Subject: Re: Android AOSP source tree downloading fails
Message-ID: <20140617124544.GC621@aemeltch-MOBL1>
References: <014f01cf8a1f$6b1c74c0$41555e40$@samsung.com>
 <20140617114548.GB621@aemeltch-MOBL1>
 <015801cf8a29$8660b250$932216f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <015801cf8a29$8660b250$932216f0$@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Tue, Jun 17, 2014 at 06:11:29PM +0530, Vikrampal wrote:
> Hi Andrei,
> 
> >-----Original Message-----
> >From: Andrei Emeltchenko [mailto:andrei.emeltchenko.news@gmail.com] 
> >Sent: Tuesday, June 17, 2014 5:16 PM
> >To: Vikrampal
> >Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> >Subject: Re: Android AOSP source tree downloading fails
> >
> >Hi Vikram,
> >
> >On Tue, Jun 17, 2014 at 04:59:28PM +0530, Vikrampal wrote:
> >> Hi,
> >> 
> >> I'm trying to download full Android AOSP source tree. I tried 2 methods:
> >> 1) repo init -u https://code.google.com/p/aosp-bluez.platform-manifest 
> >> -b kitkat
> >>      repo sync
> >> error: Exited sync due to fetch errors
> >
> >Which project it cannot fetch?
> >
> >Best regards
> >Andrei Emeltchenko 
> 
> platform/packages/apps/PackageInstaller
> 

Something wrong with proxies?

$ repo sync platform/packages/apps/PackageInstaller
Fetching project platform/packages/apps/PackageInstaller
Fetching projects: 100% (1/1), done.  

Best regards 
Andrei Emeltchenko 
