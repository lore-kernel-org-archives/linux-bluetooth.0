Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <97A79091-A35F-4A53-8AAF-DCD527C574DA@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Merrill <dmerrill@media.mit.edu>
In-Reply-To: <f86d2a880811181148x724e7ff8s474a1821d50c58e3@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: one "talker" multiple "listeners" possible for inquiry scan with RSSI?
Date: Mon, 24 Nov 2008 03:51:26 +0100
References: <f86d2a880811181148x724e7ff8s474a1821d50c58e3@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> I am getting to know bluez, reading the BT spec, playing with pybluez
> - and I have a multi-adapter question I hope someone may know the
> answer to.
>
> I want to capture the RSSI from a mobile phone from several Bluetooth
> radio dongles on a linux system, so I can try to estimate where the
> mobile phone is. I find that when I have all radios doing inquiry
> scans with RSSI at the same time, it generates a lot of radio traffic,
> and WiFi in the area slows down.
>
> So I'm wondering, can I have one radio initiate the inquiry scan with
> RSSI, and have the other 5 radios just listen for the replies from the
> mobile phone without "talking"? Could this be accomplished just by
> setting the hardware address of the "listeners" to match the address
> of the "talker", then they would receive the replies - or is there
> some hand-shaking / delivery guarantee algorithm that is required that
> would not be possible if the listeners remain quiet?

the simple answer is no. It is not how Bluetooth works. For more  
details you should get a book on Bluetooth that explains how the radio/ 
baseband actually works.

Regards

Marcel

