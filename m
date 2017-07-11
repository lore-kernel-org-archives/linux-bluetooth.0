Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 11 Jul 2017 18:31:22 +0200
From: Olivier MARTIN <olivier@labapart.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Felix Schulthess <felix.schulthess@scs.ch>,
        linux-bluetooth@vger.kernel.org
Subject: Re: DBUS API: Retrieve current MTU used by remote device
In-Reply-To: <CABBYNZLp-1gxGftHQBT_q5pdrxW_fdBoKYMQSmMOS+bZWwk=NQ@mail.gmail.com>
References: <0fef8015e74a2a96af45c36e9c67dc36@labapart.com>
 <9c9da882-fd5b-dfa1-447e-a6f05b341f97@scs.ch>
 <a4919190d5de8c7c3d25f1ea81772513@labapart.com>
 <CABBYNZLp-1gxGftHQBT_q5pdrxW_fdBoKYMQSmMOS+bZWwk=NQ@mail.gmail.com>
Message-ID: <1dd40da57a55b3c36be7c5a52c99bbaf@labapart.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Ubuntu 16.04 LTS is shipped with bluez v5.37. You could argue Bluez 
v5.37 does not officially support GATT over DBus as the support is still 
experimental which is true. And because v5.37 does not support GATT Long 
Write, developers should not use Bluez prior to v5.42 (date when GATT 
D-Bus API is marked as not experimental anymore).

As the GATT client might also send packet longer than 20 bytes, the 
client also needs to support Long Read/Write (same as GATT server).
 From my quick search, it looks Long Read/Write support is not well 
supported by all GATT server/client. I do not know whether it is a 
correct assumption or developers are not aware of its support.

At the moment I am using a protocol on top of GATT to send my payload in 
chunk. I sometimes send payloads as large as 200 bytes. By sending 19 
bytes (+ 1 bytes for the application protocol to support chunk) I need 
11 GATT characteristic writes while I could send only 1 packet if I knew 
the ATT MTU could have been increased to 203 bytes or more.
Throughput is not critical but it has a high importance in my use case 
(Human Machine interface).

By increasing my hardcoded payload from 20 bytes to 200 bytes (because I 
know the negociated ATT MTU is 512 bytes), my application test time 
execution dereases from 32sec to 11sec. If I knew the ATT MTU (for 
instance from D-Bus Bluez), I could replace the hardcoded value by the 
negociated one.

If I had some confidence Long Read/Write feature was well supported, I 
will be happy to use it. But I am worry it is not - but I could be 
wrong. What do you think?


On 11.07.2017 15:01, Luiz Augusto von Dentz wrote:
> Hi Olivier,
> 
> On Tue, Jul 11, 2017 at 1:54 PM, Olivier MARTIN <olivier@labapart.com> 
> wrote:
>> Thanks Luiz for the answer, but I am guessing WriteValue() uses Long 
>> Write.
>> But it looks like not all BLE devices support Long Read/Write 
>> (including
>> Bluez until recently - v5.39 - April 2016). It also seems some/all(?)
>> Android devices do not support it.
> 
> I wouldn't call recently a more than one year only release and I guess
> the versions that don't support, and I though Long Write is mandatory
> for the server at least for the complete server:
> 
> C.4: Mandatory IF GATT 1/4 “Complete GATT Server” is supported,
> otherwise Optional.
> 
> or are you talking about Reliable Writes?
> 
>> I did not find this information but is a device that does not support 
>> Long
>> Write; would the application still receive GATT packets sent by Long 
>> Write
>> in a defragmented manner?
> 
> I guess the remaining bytes over the MTU would not be sent since that
> would require Prepare Write operation which I guess fail with such
> devices and since regular Write Request don't have an offset we cannot
> continue sending.
> 
>> The workaround often uses is to leave the GATT server fragmenting 
>> itself the
>> packets to send to the GATT client with an arbitrary packet length 
>> value.
>> Knowing the MTU uses between the two GATT devices could improve the
>> throughput.
> 
> I guess you mean the GATT server will not be able to reassemble thus
> you send in chunks as big as the MTU, but this presumes there is
> something in the data payload that is doing sar, so a protocol on top
> of GATT.
> 
> But be aware that most OSes don't protect against multiple clients
> writing to the same attribute, not to mention there can be quite big
> latencies since GATT has a 30 seconds timeout for each request which
> is why usually Write Without Response procedure is used with such
> operations.
> 
> If you care about throughput then using D-Bus to pipe data is probably
> very inefficient, L2CAP CoC would probably be the best solution to
> something like a serial port emulation over LE, but sadly Android and
> iOS still don't support that.

http://labapart.com
