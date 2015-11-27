Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <d942deb8e0bd715b4ce207a874b0bda4.squirrel@mungewell.org>
In-Reply-To: <AM3PR01MB211848A73CABF9631293C19F9030@AM3PR01MB211.eurprd01.prod.exchangelabs.com>
References: <AM3PR01MB211848A73CABF9631293C19F9030@AM3PR01MB211.eurprd01.prod.exchangelabs.com>
Date: Fri, 27 Nov 2015 08:51:14 -0700
Subject: Re: Exploring Bluez alternatives
From: "Simon Wood" <simon@mungewell.org>
To: "Ad Zeevaarders" <ad.zeevaarders@veynex.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, November 27, 2015 1:32 am, Ad Zeevaarders wrote:
> Hello,
>
>
> I am an intern at a company. After having developed a few Low Energy
> applications using BlueZ, the DBus-way and the mgmt way, I was ready for
> my new assignment. The applications I developed were targeted at an
> embedded ARM platform running Linux without DBus. The new application I
> need to develop needs to connect to a device, receive some values using
> indications, then disconnect.
>
> To my amazement my employer told me that they wanted me to explore
> alternatives to BlueZ, as they were unsure of the reliability and
> especially the performance. They sent me a Wikipedia page listing several
> embedded Bluetooth stacks, like BlueCode+, and asked me to prove, for
> every single stack, why Bluez was 'better'. My initial response was
> "Because it is the official supported Bluetooth stack for Linux, our
> target development OS." Exploring the other solutions, I could not find
> any rationale as to why I would choose a different protocol stack.

Hi,
This maybe of no interest, but I wanted to point out another alternate
'community written' stack....

http://bluekitchen-gmbh.com/btstack/

Started as a completely Free project, but was then relicensed to be 'free
for non-commercial'. Depending on what you need it might be usable for
your projects.

BTW you have a hard task if employers just don't like Bluez :-( To me (as
just a user) the code size would be the major detractor, but it does work
pretty well.

Good luck,
Simon


