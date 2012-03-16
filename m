Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NHvdHNUsYh1tOkXEd9u5cGLszDCsXTVrwG=TjRxbNFuw@mail.gmail.com>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
	<alpine.LNX.2.00.1203161556540.18356@pobox.suse.cz>
	<CAJdJm_NHvdHNUsYh1tOkXEd9u5cGLszDCsXTVrwG=TjRxbNFuw@mail.gmail.com>
Date: Fri, 16 Mar 2012 14:28:34 -0300
Message-ID: <CAAngNMY7HJHRU9P3hNknMsZEOs3Yt7aiC5=Cp4r1PXrYYTHFEg@mail.gmail.com>
Subject: Re: [RFC 0/1] User-space I/O driver for HID subsystem (Bluetooth-LE HIDP)
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Jiri Kosina <jkosina@suse.cz>,
	David Herrmann <dh.herrmann@googlemail.com>,
	linux-input@vger.kernel.org, chen.ganir@ti.com,
	claudio.takahasi@openbossa.org, linux-bluetooth@vger.kernel.org,
	Vijaykumar.Dadmode@csr.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Mar 16, 2012 at 1:04 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Jiri,
>
> On Fri, Mar 16, 2012 at 10:58 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>> On Fri, 16 Mar 2012, David Herrmann wrote:
>>
>>> I have hacked together a small driver which allows user-space I/O drivers to
>>> provide HID devices. This is needed for Bluetooth-Low-Energy HID devices as the
>>> Bluetooth-LE protocol is parsed in user-space.
>>
>> David,
>>
>> thanks for your effort.
>>
>> I haven't read the full discussion you have CCed me on yesterday, but I
>> have one substantial question to start with -- is there a simple
>> explanation in a few sentences why Bluetooth-LE can't be added as a
>> in-kernel transport layer?
>
> Just to add my own opinion here (as this topic has been brought before
> long ago, but on linux-bluetooth only):
>
> For LE we have a single LE channel (multiplexed for all LE profiles
> running simultaneously, as described by Claudio and Joao Vita
> earlier), and this channel takes so called ATT (attribute protocol)
> packets. These packets have a very small header (at least one byte to
> identify the request/response being sent), but usually have extra
> bytes for parameters (e.g. an "attribute handle" from which BlueZ can
> know to which GATT profile it is being addressed) and data payload.
>
> If LE (actually the ATT protocol used by LE, which is also usable over
> BR/EDR) were to be parsed on the kernel, we would also need to parse
> the ATT packet in order to know to which attribute handles it is being
> addressed. The kernel would also need to keep tracking of the higher
> level HID over GATT services so it could know which packets to process
> for HID , and which are destined for other LE profiles (running on
> BlueZ, or being sent to non-HID profile running on peer device).
>
> At least this is my understanding of the problem.
>
> Regards,

And the biggest concern of having this in userspace was latency. I've
done a small test getting input events coming from a regular mouse
through /dev/input/mouse0 on a userspace application that feeds this
events back to the kernel through uinput, creating a second virtual
mouse on /dev/input/mouse1. Then attaching this mouse1 to an
additional pointer on X shows that the latency of this roundtrip
between the kernel and the userspace have no impact on this usecase
(no visual difference between the movement of one pointer and the
second one).

So mitigating this potential problem, I don't see why doing this ATT
parsing and demuxing on the kernel would be an advantage (but I may be
missing something here).

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
