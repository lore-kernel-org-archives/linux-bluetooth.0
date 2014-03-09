Return-Path: <cyrus@holtmann.org>
Date: Sat, 8 Mar 2014 22:25:50 -0800 (PST)
From: Terry Hardie <terryh@orcas.net>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer
 Overflow"
In-Reply-To: <alpine.DEB.2.02.1403072307490.21384@orcas.net>
Message-ID: <alpine.DEB.2.02.1403082225030.21384@orcas.net>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org> <alpine.DEB.2.02.1403072307490.21384@orcas.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 7 Mar 2014, Terry Hardie wrote:

> I'm having something similar to what Adam is reporting. I'm running on a 
> BeagleBone Black, which uses a TI MUSB controller (I think it's different to 
> the Raspberry Pi USB controller?).

I have just found switching the USB 2 hub for a USB 1.1 hub makes the 
problem go away... Not sure what that proves though...

