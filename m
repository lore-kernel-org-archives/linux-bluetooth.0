Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170516142414.GA9507@x1c>
References: <CAMybWM3jHv75hrixjk3Ep8Er7Qkw8T5peKTN6SNE3qJLg9n2eg@mail.gmail.com>
 <20170516142414.GA9507@x1c>
From: Natalya Rozhnova <rozhnova.natalya@gmail.com>
Date: Tue, 16 May 2017 17:27:53 +0200
Message-ID: <CAMybWM2fmQcu=+4dQWbrk+6UgVeYiiefKm-8UjcixJFzLRqaYw@mail.gmail.com>
Subject: Re: Understanding Bluez mgmt events
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

Thank you very much for your reply, it's much clearer now!

Natalya

2017-05-16 16:24 GMT+02:00 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Natalya,
>
> On Tue, May 16, 2017, Natalya Rozhnova wrote:
>> I'm trying to understand the mgmt events in Bluez.
>> If I understand correctly, the MGMT_OP_... commands are first sent as following:
>>
>> mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY, ...)
>>
>> And then it should trigger a corresponding event like
>> MGMT_EV_DISCOVERING, MGMT_EV_DEVICE_FOUND etc.
>>
>> I'm quite lost in understanding who, where and how generates these
>> MGMT_EV... events...
>> Could anybody please explain this on a simple example or showing a
>> piece of code in bluez sources where it is done...
>
> The mgmt protocol is a protocol between user space and the kernel. User
> space (normally bluetoothd) sends commands to the kernel, and the kernel
> sends events to user space. You can find the kernel-side implementation
> in net/bluetooth/mgmt.c.
>
> Johan
