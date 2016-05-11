Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <EB98033C-EA6B-45A7-AC0D-DD2F2FAD69E6@gmail.com>
References: <EB98033C-EA6B-45A7-AC0D-DD2F2FAD69E6@gmail.com>
Date: Wed, 11 May 2016 09:29:27 -0700
Message-ID: <CAD0=r8yUD3J0gNPVVDu1_TCqdhZdCsTovWRTrCCido9Dh3DcRw@mail.gmail.com>
Subject: Re: Best schema to "stream" data over BLE
From: Jakub Pawlowski <jpawlowski@google.com>
To: Travis Griggs <travisgriggs@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, May 10, 2016 at 6:23 PM, Travis Griggs <travisgriggs@gmail.com> wrote:
> The GATT architecture of BLE lends itself to small fixed pieces of data (20 bytes max per characteristic). But in some cases, you end up wanting to “stream” some arbitrary length of data, that is greater than 20 bytes. For example, a firmware upgrade, even if you know its slow.
>
> I’m curious what scheme others have used if any, to “stream” data (even if small and slow) over BLE characteristics. I’m also curious how fast I can expect the bluez stuff to go when it’s having to channel through dbus.  I’ve used two different schemes to date. One was to use a control characteristic, where the receiving device notify the sending device how much data it had received, and the sending device then used that to trigger the next write (I did both with_response, and without) on a different characteristic. Another scheme I did recently, was to basically chunk the data into 19 byte segments, where the first byte indicates the number of packets to follow, when it hits 0, that clues the receiver that all of the recent updates can be concatenated and processed as a single packet.
>
> I’m finding bluez pretty slow. Running between iOS and an STMicro chip, I can get around 500bytes/sec. But between iOS and bluez (embedded Linux, python3 with dbus), I’m getting much less, about 125 bytes/sec. The speed isn’t a show stopper. I’m really just curious what schemes (if any) others have used.

Hi Travis,

For firmware update there is BLE DFU.
For general data transfer: if you can, change MTU to bigger value, it
can go from 23 up to 512. It will depend on controllers on both sides.
Then change connection paramters to make it as fast as possible,
having small connection interval helps alot.
Another thing: for transfering data use Notifications (slave->master)
and Write Command (master->slave). When you use Indications, or
regular Write commands, you can have only one "transaction" happening
at a time. So it takes 2 connection intervals to transfer MTU of data.
Depending on controller, you can send multiple notifications/write
commands during one connection interval ant this should give huge
speed improvement. Best I achieved was around 10 - 20 kb/s, but as I
said, it will depend on controllers and connection parameters.




>
> TIA--
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
