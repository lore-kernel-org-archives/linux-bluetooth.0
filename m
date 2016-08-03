Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Going Faster between iOS and BlueZ
Message-Id: <6A53EA11-BBCC-41CA-9EA7-FB2B5375F00D@gmail.com>
Date: Wed, 3 Aug 2016 15:26:59 -0700
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After my report from a week or so ago, I decided to put my application to the side, and just write a simple application where I could try different things easily. My main goal, was to get to a point where I could *stream* arbitrary chunks of bytes through one or more characteristics using the APIs provided by iOS and the bluez gatt dbus api. This is briefly what I found.

An app that tries to write 1040 bytes through a write (with response) characteristic will take 7 seconds to do the 52 writes required. So roughly 7 writes a second.

I played multiple games at this point. What if I have 2 characteristics? Could I get 7 writes a second through each in parallel? The answer is no.

Conversely, the same is true for ‘indicate’ characteristics. Pushing data the other way also manages about 7 changes a second. And doubling up, just doubles the time it takes.

write-without-response is a different story. iOS will run this so fast, that they just start to disappear. I think I’ve read that that’s on the iOS side itself. My testing indicates there seems to be a buffer of about 30 writes, and then they just start going to /dev/null. If I issue them at a regular timed interval though (essentially throttling it), they all get through. In that case, delaying 18 milliseconds between each write, everything makes it through, and I’m now able able to send the 52 packets in 1 second (+/- 100 ms). That’s at least 7x faster. Similar as before, you can’t “double pump” this. Using two characteristics, if i do 2 without response writes every 18ms, I’ll start to lose packets.

The story plays out similar for a ‘notify’ characteristic. I can issue 50 or so changes a second and have them picked up fine by the iOS side. The difference between bluez and iOS is that it seems to self throttle. It runs faster, but there’s no need to throttle it, it never seems to lose stuff due to some sort of buffer overflow. Double pumping has no effect. The throughput will still be about 1 KB/second, whether spread across multiple or just one characteristic.

The final observation was the surprise. It turns out that while you can only go so fast in one direction, you can go the same speed in both directions simultaneously. IOW you can be notifying 1KB/s changes at the same time you are writing without response  1 KB/s (on two separate characteristics). So the net data transfer at that point is more like 2KB/s.

So I was able to get 2 speed gains to my schema and basically simplify things to go faster:

1) Use clocked write-without-response from the central/iOS device; use notify as fast as it will go from the bluez/peripheral device
2) Separate the request/reply streams so that while you’re receiving the response from one request, you’re already sending the next request.

With these 2 changes, my app is now streaming rest-like queries to my device at least 15x faster than before. And I went from 3 characteristics down to just 1.


To “frame” the data, I used a leading byte countdown scheme. Any time that leading byte gets down to 0, I know it’s time to process the accumulated buffer (on either side). My requst/response format includes an identifier so that the responses can be correlated with the requests that go out asynchronously.

Hopefully, this might help some other soul who ends up searching archives if he’s doing handheld to bluez/peripheral stuff.



