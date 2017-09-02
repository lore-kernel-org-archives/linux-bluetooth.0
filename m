Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1504353762.2859.12.camel@iki.fi>
Subject: Re: Two guids for Headset HS role?
From: Tanu Kaskinen <tanuk@iki.fi>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sat, 02 Sep 2017 15:02:42 +0300
In-Reply-To: <1504352305.2859.10.camel@iki.fi>
References: <1504352305.2859.10.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2017-09-02 at 14:38 +0300, Tanu Kaskinen wrote:
> PulseAudio currently assumes that HSP HS is identified by guid
> 00001108-0000-1000-8000-00805f9b34fb, but it seems[1] that the Samsung
> HS6000 headset uses guid
> 00001131-0000-1000-8000-00805f9b34fb for the HSP profile. Does anyone
> know why there are two guids for HSP HS. Should PulseAudio just assume
> that the two guids mean the same thing?
> 
> [1] https://bugs.freedesktop.org/show_bug.cgi?id=93898#c13

I should have done a bit of research into the specification docs before
sending... It seems that the two uuids are indeed the same thing,
except that 0x1108 is used both as a service class and profile
identifier, while 0x1131 is only a service class identifier.

-- 
Tanu

https://www.patreon.com/tanuk
