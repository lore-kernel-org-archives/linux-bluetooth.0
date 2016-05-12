Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8yUD3J0gNPVVDu1_TCqdhZdCsTovWRTrCCido9Dh3DcRw@mail.gmail.com>
References: <EB98033C-EA6B-45A7-AC0D-DD2F2FAD69E6@gmail.com>
	<CAD0=r8yUD3J0gNPVVDu1_TCqdhZdCsTovWRTrCCido9Dh3DcRw@mail.gmail.com>
Date: Thu, 12 May 2016 11:50:26 +0300
Message-ID: <CABBYNZ+qPjkXWJQ141_jBzZx-r50G8FFge4HKsSLcA2k_BCsqA@mail.gmail.com>
Subject: Re: Best schema to "stream" data over BLE
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: Travis Griggs <travisgriggs@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Travis, Jakub,

On Wed, May 11, 2016 at 7:29 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> On Tue, May 10, 2016 at 6:23 PM, Travis Griggs <travisgriggs@gmail.com> wrote:
>> The GATT architecture of BLE lends itself to small fixed pieces of data (20 bytes max per characteristic). But in some cases, you end up wanting to “stream” some arbitrary length of data, that is greater than 20 bytes. For example, a firmware upgrade, even if you know its slow.
>>
>> I’m curious what scheme others have used if any, to “stream” data (even if small and slow) over BLE characteristics. I’m also curious how fast I can expect the bluez stuff to go when it’s having to channel through dbus.  I’ve used two different schemes to date. One was to use a control characteristic, where the receiving device notify the sending device how much data it had received, and the sending device then used that to trigger the next write (I did both with_response, and without) on a different characteristic. Another scheme I did recently, was to basically chunk the data into 19 byte segments, where the first byte indicates the number of packets to follow, when it hits 0, that clues the receiver that all of the recent updates can be concatenated and processed as a single packet.
>>
>> I’m finding bluez pretty slow. Running between iOS and an STMicro chip, I can get around 500bytes/sec. But between iOS and bluez (embedded Linux, python3 with dbus), I’m getting much less, about 125 bytes/sec. The speed isn’t a show stopper. I’m really just curious what schemes (if any) others have used.

It might be the connection parameters are not optimal for speed, but
also the fact that this goes over D-Bus makes things even slower but I
would say it is the major different here.

>
> Hi Travis,
>
> For firmware update there is BLE DFU.
> For general data transfer: if you can, change MTU to bigger value, it
> can go from 23 up to 512. It will depend on controllers on both sides.
> Then change connection paramters to make it as fast as possible,
> having small connection interval helps alot.
> Another thing: for transfering data use Notifications (slave->master)
> and Write Command (master->slave). When you use Indications, or
> regular Write commands, you can have only one "transaction" happening
> at a time. So it takes 2 connection intervals to transfer MTU of data.
> Depending on controller, you can send multiple notifications/write
> commands during one connection interval ant this should give huge
> speed improvement. Best I achieved was around 10 - 20 kb/s, but as I
> said, it will depend on controllers and connection parameters.

Well that taken out the possibility to use L2CAP channels directly
which should prevent interleaved GATT commands which can block the
channel for up to 30 seconds, it really beats me how vendor even
consider doing DFU over GATT since the transfer can stall at any point
and the default behavior is to disconnect if the channel timeout,
besides in L2CAP CoC you can have a MTU of up to 64K which should
translate in much better transfer speed.


-- 
Luiz Augusto von Dentz
