Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Jan 2009 14:23:16 -0500 (EST)
From: Jim Faulkner <jfaulkne@ccs.neu.edu>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Sony BD Remote pairing problems with new distributions
In-Reply-To: <alpine.GSO.2.00.0901131907350.14823@denali.ccs.neu.edu>
Message-ID: <alpine.GSO.2.00.0901151411450.9769@denali.ccs.neu.edu>
References: <alpine.GSO.2.00.0901131907350.14823@denali.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Tue, 13 Jan 2009, Jim Faulkner wrote:

> My sony BD remote (aka PS3 remote) requires a convoluted process to get it 
> working each and every time my computer boots.

I just wanted to follow up on this.  I have managed to get my BD remote 
permanently paired with my computer.  I no longer need to to go through 
the process of pairing it each time the computer boots.

The problem is, I'm not sure exactly how I got it working.  I had resigned 
myself to the fact that it wasn't going to automatically pair at boot 
time, so I was playing around with "hidd --connect" and the cakemote.py 
script, seeing which would work best to pair the device at each boot.

I tried running "hidd --connect (hardware address)" to get the remote 
paired.  It said that it successfully paired, and "hidd --show" showed the 
BD remote device, however I wasn't able to get any output from the 
bdremoted daemon when pressing keys on the remote.

So, I tried pairing it with cakemote.py, but got a "connection refused" 
error, presumably because the bluetooth stack thought it was already 
paired.  I then ran "hidd --killall", then cakemote.py, ctrl-cing out once 
the device was paired.

And since then, the remote is working fine without out any need to pair 
again.  I'm not sure exactly what I did... I have used cakemote.py to pair 
the device many times before without this result.  But its nice to have it 
working.

Jim

