Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimX-ofkv4oekES0kfi7l_y4yLMVAO8A9e0Nx5tg@mail.gmail.com>
References: <AANLkTimX-ofkv4oekES0kfi7l_y4yLMVAO8A9e0Nx5tg@mail.gmail.com>
From: Manuel Naranjo <manuel@aircable.net>
Date: Sun, 6 Jun 2010 15:04:38 -0300
Message-ID: <AANLkTikNPHQ_r3lrQMDE2C-6ZhY5uWZ84OxREiUUgarK@mail.gmail.com>
Subject: Re: Inquiry Result with repeated set of MAC addresses - Is it a
	problem with Bluetooth device ?
To: Saurabh Thukral <saurabhth@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> On running <hcitool scan> in one terminal and simultaneously viewing
> results using <hcidump> on the other terminal, I had a very
> interesting observation that has made me quite perplexed. I would
> really like you to help me out.
>r
> The observation is that suppose a device(Nokia N73) with MAC address
> M1 is discoverable, the response to Inquiry Request command is often a
> set of multiple Inquiry Result each with the same MAC address M1.
This is totally normal! It's related to how bluetooth inquiry process
works. The device doing the inquiry is jumping at a rate of 1600
hops/s (If I'm not wrong) over 32 channels and te device in inquiry
scan is jumpung at a way lower rate. So the radio might, and actually
will, find the same device multiple times per scan cycle. hcidump
shows you exactly which information is going on between the radio and
the stack.

The advantage of getting multiple results are many:
* RSSI depends on scanning channel: not all the channel have the same
noise level, so averaging RSSI with multiple results is way more
accurate than just one rssi value from one only channel.
* Faster response: hcitool inq will only show you the results once it
has solved both name and completed scanning, but actually it's getting
the results way before. I had been able to expermient dicovering a new
radio in less than 1 second so I could take action, and this can only
be done if you get multiple results per scan cycle.

Off course it requires more inteligence on you side. You need to
filter which results are new and which are not, but that is damn easy,
and you would be loose applications if it was otherwise.

Manuel


-- 
Manuel Francisco Naranjo
Software Department Argentina
Wireless Cables Inc
www.aircable.net
cel: +5493412010019
skype: naranjomanuelfrancisco
