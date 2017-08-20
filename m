Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: 
From: Andreas Wettergren <murpe79@gmail.com>
Subject: Re: KORG nanoKONTROL Studio MIDI over Bluetooth problem
Message-ID: <b56a27b8-afa9-dcd7-e7da-91081bcc6625@gmail.com>
Date: Sun, 20 Aug 2017 12:59:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I just got a NanoKontrol Studio and I'm experiencing the same 
problems/symptoms as Robert did back in May.

I get both "MIDI I/O: Failed to read initial request" in the logs, and 
frequent disconnects.

I've tried playing around with MinInterval/MaxInterval (as well as 
Latency and Timeout) as suggested by Felipe, but I can't seem to get it 
working properly.

However, by the logs from btmon, hcidump and bluetoothd, it seems like 
the main problem is that I keep getting timeouts, and Bluez disconnects 
for that reason.

The best result so far is that the midi device ports have appeared 
briefly in aseqdump / Catia (not the CAD package, the one from KXStudio),
so it would seem there is a chance to get this working if I can just 
prevent the timeouts/disconnections.

I've tried reading up a bit on what exactly the parameters do, and sort 
of get the idea, but the details are still a bit hazy.
I'm just not sure how to proceed in the most rational way at this point.
(Blindly trying arbitrary numbers is probably not going to work well :) )

My questions are:

@Robert:

Did you get your nanoKontrol Studio to connect/work properly in the end?
If so, would you care to share which Connection Parameters you used?

@Felipe:

Is there any point in pursuing this at the moment, or do you think "MIDI 
I/O: Failed to read initial request" might be a showstopper?

This is my understanding so far;
The interval values are multiplied by 1.25 to get the actual millisecond 
value, thus 6 => 7.5 ms.
The latency value is the number of non-responses the stack will tolerate 
before giving up on the connection.
The timeout value is in 10 ms increments, so for example 200 => 2000 ms 
timeout.
Is the above correct?

Are the rules in chapter 3.6 of Apples design guidelines relevant, or 
are they not applicable to the Bluez stack?
(https://developer.apple.com/hardwaredrivers/BluetoothDesignGuidelines.pdf.
I made a spreadsheet to test for legal combinations, it seems the valid 
ranges are pretty narrow)

Finally, should I just try bumping MaxInterval (and maybe MinInterval) 
until I see a change in behavior,
and leave Latency and Timeout at 0/200?

(I suppose I’ve changed the values a bit haphazardly up til now, a more 
methodical approach might help, I’ll give that a try.)

I can see that changing timeout changes the period between disconnects,
but I can't seem to increase it enough to have them go away.

Many thanks for your work on this, and any help will be greatly appreciated.

Best regards

/Andreas

PS. I'm running Debian testing/unstable, Bluez 5.45-1, kernel is 
4.11.0-2-rt-amd64, BT USB adapter is a Cambridge 0a12:0001, HCI 4.0.


