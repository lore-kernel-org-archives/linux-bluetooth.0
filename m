Return-Path: <cyrus@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 10 Mar 2014 17:54:17 -0700
From: Terry Hardie <terryh@orcas.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <CAJdJm_M=qHZFdGRd0B3DTNCJXyraj4+P4aDG6t7y_w76XCXYdA@mail.gmail.com>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org>
 <alpine.DEB.2.02.1403072307490.21384@orcas.net>
 <CAJdJm_M=qHZFdGRd0B3DTNCJXyraj4+P4aDG6t7y_w76XCXYdA@mail.gmail.com>
Message-ID: <9f497be2aad5f7dbe83aa1b38f7b92e7@orcas.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 2014-03-10 06:21, Anderson Lizardo wrote:
> Hi Terry,
> 
> On Sat, Mar 8, 2014 at 3:19 AM, Terry Hardie <terryh@orcas.net> wrote:
>> The problem is when running a lescan (hcitool lescan) with a LE device 
>> in
>> paring mode, which is transmitting a lot of LE Advertising report 
>> packets,
>> the HCI drivers eventually loses sync. I've traced it down to a 
>> duplicate
>> USB fragment.
> 
> I think your logs show missing USB packets (not duplicated)... More
> details below.

Interesting that it always loses 2 packets, and never 1, that's why I 
assumed duplication...

> In summary, it is expected that for devices that don't change address,
> the only byte to change is the RSSI (last byte of the last fragment).
> That's why the 2 first fragments are usually the same for all
> advertising packets.

You asked in another email if I tried a powered hub. Yes, I tried a 
powered hub. I get the same results.

Also, although it's not common, I also see these lost frames outside of 
a scan. A scan is just the easiest way to reproduce it. If I leave a tag 
broadcasting once per second, 2 receivers on the same USB bus, after an 
hour or so, the same problem happens (and this is only 1 broadcast per 
second from the PROX tag, received by 2 receivers simultaneously, 
resulting in each receiver sending 3 USB transfers to the host - 6 USB 
transfer total), so this is not just limited to high packet rates. I 
think there's some problem with USB bus contention, especially since 
both receivers try to send data to the host at EXACTLY the same time.

Terry
