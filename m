Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [RFC 0/3] core/adapter: Add disabling duplicate device filtering
 from d-bus
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20161207201642.GF35881@redhat.com>
Date: Thu, 8 Dec 2016 07:18:53 +0100
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Brennan Ashton <brn@deako.com>
Message-Id: <0551C6BD-7C6C-4929-AC5A-79A9ADB5176C@holtmann.org>
References: <1481060400-7088-1-git-send-email-dzickus@redhat.com>
 <CABBYNZLdm5TsxZeCzS0S_7Xf0sfqYPNy8YrOMTpOsL3pNUO0jA@mail.gmail.com>
 <20161207201642.GF35881@redhat.com>
To: Don Zickus <dzickus@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Don,

>>> Recent discussions on the bluez mailing list revealed it was not easy
>>> to disable duplicate device filtering from the d-bus interface.
>>> 
>>> As a result, if I wanted to monitor LE devices entering and leaving the
>>> adapters range (using RSSI data), it was difficult.
>>> 
>>> This patchset is a dirty hack to make this work. The first patch enables
>>> it on the kernel side, while the other two patches enable it from the bluez
>>> side.
>>> 
>>> I understand there are concerns about flooding the d-bus interface when
>>> enabling this.  I tried to write a throttling mechanism using the mainloop
>>> as my timer, but soon realized you can only have 1 device RSSI event
>>> per loop, so that wasn't going to work.  Open to suggestions if still a
>>> concern.
>>> 
>>> Posted as an RFC just to generate discussion.  I expect I missed a lot of
>>> little details here, but wanted to post my proof of concept to see if this
>>> is something to work with.
>>> 
>>> This patchset includes both the kernel and bluez patches.  I understand this is
>>> not recommended for normal practice.  But I thought for an RFC, it is nice to
>>> keep things together for now.
>> 
>> I would avoid adding a new MGMT command and instead disabled
>> duplicated filtering if RSSI filtering is set since anyway RSSI
>> filtering needs to disable duplicates in order to do any RSSI
>> filtering reliable. So this would mean that if the user wants to see
>> to get duplicate filtering it needs to set a RSSI which should rate
>> limit as we would use a threshold.
> 
> Hi Luiz,
> 
> Ok, fair enough.  I then simplified it down to a small kernel patch that
> seems to work if I set an RSSI threshold with SetDiscoveryFilter.
> 
> I only do this on an active_scan.  Not sure if I should do it for the
> passive scans too?
> 
> If this looks ok, I will resubmit properly.

I am not sure this is the best idea. So right now the kernel restarts scanning to get new RSSI values when we have a quirk set that strict scan filtering is performed by the controller (strict means address only).

That is for discovery. Something started by the user and something that does not last over long times. Discovery is using active scanning which takes way more TX/RX time on air than passive scanning. It is also known to be causing more problems then it solves when run constantly. The reason is that it will interrupt CONNECT_REQ since SCAN_REQ are more likely to win based on their shorter packet size.

So the main question is if you are after a certain set of devices (based on their address) and want to monitor their RSSI or are you after any device and want to match based on advertising data?

The first one could be dealt with by using the whitelist, the second one is nasty from a power consumption point of view. Any long term operation there would be causing major headaches.

Keep in mind that besides the kernel waking up (and USB transport), you also end up waking userspace all the time to process the information and send out over D-Bus. Which means you might going to wakeup even more processes.

Regards

Marcel

