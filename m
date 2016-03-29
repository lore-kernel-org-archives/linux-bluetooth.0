Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMes48935-joX6LCUQyAjSVR3NV5RfGp+FgJjkzNXpJBioSv1A@mail.gmail.com>
References: <CAMes48935-joX6LCUQyAjSVR3NV5RfGp+FgJjkzNXpJBioSv1A@mail.gmail.com>
Date: Tue, 29 Mar 2016 21:56:19 +0200
Message-ID: <CAMes489GQn1QdNhS46oK7oojmicqLa75nMdf+bYSi5OTb5k_eg@mail.gmail.com>
Subject: Re: Microsoft Sculpt Touch Bluetooth mouse disconnects
From: Jon Doe <tuksgig@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 29, 2016 at 2:32 PM, Jon Doe <tuksgig@gmail.com> wrote:
> Hi,
>
> My bluetooth mouse keeps on disconnecting after a few minutes. This is
> a common problem (see
> https://bugs.launchpad.net/linuxmint/+bug/1417444 and
> https://bugzilla.redhat.com/show_bug.cgi?id=923349 ).
>
> I have booted Windows in a VM and captured USB bluetooth traffic to
> try and see what's going wrong. There are a few differences in the
> setup sequence (encryption is enabled, link policies are set with park
> mode enabled, flush timeout set to 0, MTU size is bigger at 672 etc).
> I've tried a few custom commands to try and emulate the Windows setup.
> What I've tried so far:
>
> hcitool cmd 0x02 0x0d 0x2a 0 0x0f 0 (write link policy settings)
> hcitool cmd 0x02 0x05 0x2a 0 0x50 0 0x40 0 (set park state)
> hcitool enc 28:18:78:xx:xx:xx (enable encryption)
> hciconfig hci0 aclmtu 672:8 (set MTU size)
>
> So far, no luck. After about 600 seconds the mouse goes to sleep. On
> wakeup, it does try to reconnect, but something goes wrong and the
> mouse dies :-(
>
> What else can I try?

I think I found the magic command:

hcitool cmd 0x02 0x07 0x29 0x00 0x00 0x02 0x00 0x00 0x00 0x00 0x00
0x00 0x00 0x00 0x10 0x27 0x00 0x00 0xff 0xff 0xff 0xff

where 0x29 00 is the connection number. This translates to the
following HCI command:

Bluetooth HCI Command - QoS Setup
Command Opcode: QoS Setup (0x0807)
0000 10.. .... .... = Opcode Group Field: Link Policy Commands (0x0002)
.... ..00 0000 0111 = Opcode Command Field: QoS Setup (0x0007)
Parameter Total Length: 20
Connection Handle: 0x0029
Flags: 0x00
Service Type: Guaranteed (0x02)
Available Token Rate: 0
Peak Bandwidth: 0
Latency: 10000
Delay Variation: 4294967295
