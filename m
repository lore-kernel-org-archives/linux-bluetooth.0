Return-Path: <linux-wpan-owner@vger.kernel.org>
Date: Sat, 14 Nov 2015 10:20:42 +0100
From: Alexander Aring <alex.aring@gmail.com>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	kernel@pengutronix.de, lukasz.duda@nordicsemi.no,
	martin.gergeleit@hs-rm.de
Subject: Re: [RFC bluetooth-next 4/4] 6lowpan: iphc: add support for stateful
 compression
Message-ID: <20151114092040.GA1652@omega>
References: <1447262079-2509-1-git-send-email-alex.aring@gmail.com>
 <1447262079-2509-5-git-send-email-alex.aring@gmail.com>
 <26774.1447438082@sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <26774.1447438082@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Fri, Nov 13, 2015 at 01:08:02PM -0500, Michael Richardson wrote:
> 
> These patches are very nice to have, I will attempt to test them out.
> I am waiting for a JTAG programmer to unwedge my openmote, and then I'll
> put RIOT on that, but in the meantime I'll be testing against Contiki
> on Econotag.
> 

ok, thanks.

> One thing that I wanted to add was a counter per type of HC header decoded.
> I seemed to recall that the was some RCU-ish way to do lock-less 64-bit
> counters, but I haven't tracked down the right reference.
> 

Do you want to have this per interface or overall? We could make both.
For the lock-less part a per-cpu counter would be fit here, it will
summarize then all counters per-cpu if they will be requested.

- Alex
