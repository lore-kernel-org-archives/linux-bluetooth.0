Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Unable to Pair Bose QC35 with Bluez 5.43 or Bluez 5.39
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <45893082-1bae-cfce-5210-38cadd8cb993@nathanshearer.ca>
 <CABBYNZ+WteYE2boD8C4JJ6avPz3JxJTM_zzFAx72snY4HczMbw@mail.gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Nathan Shearer <mail@nathanshearer.ca>
Message-ID: <a2df48dd-ec1b-0cb5-2eef-5c3b515737a2@nathanshearer.ca>
Date: Wed, 4 Jan 2017 10:07:52 -0700
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+WteYE2boD8C4JJ6avPz3JxJTM_zzFAx72snY4HczMbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz, thank you for the help!
> This normally indicate that there isnt any stream endpoint registered,
> so perhaps PulseAudio has crashed or is not running for some reason?
That was exactly my problem. I had everything setup and working, except
I didn't have the pulseaudio USE flag enabled, so there was no
pulseaudio endpoint at all. Once I enabled that use flag, updated my
system and rebooted, I was able to pair and connect :)

