Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1203161556540.18356@pobox.suse.cz>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
	<alpine.LNX.2.00.1203161556540.18356@pobox.suse.cz>
Date: Fri, 16 Mar 2012 12:04:30 -0400
Message-ID: <CAJdJm_NHvdHNUsYh1tOkXEd9u5cGLszDCsXTVrwG=TjRxbNFuw@mail.gmail.com>
Subject: Re: [RFC 0/1] User-space I/O driver for HID subsystem (Bluetooth-LE HIDP)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@googlemail.com>,
	linux-input@vger.kernel.org, chen.ganir@ti.com,
	claudio.takahasi@openbossa.org, jprvita@openbossa.org,
	linux-bluetooth@vger.kernel.org, Vijaykumar.Dadmode@csr.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jiri,

On Fri, Mar 16, 2012 at 10:58 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 16 Mar 2012, David Herrmann wrote:
>
>> I have hacked together a small driver which allows user-space I/O drivers to
>> provide HID devices. This is needed for Bluetooth-Low-Energy HID devices as the
>> Bluetooth-LE protocol is parsed in user-space.
>
> David,
>
> thanks for your effort.
>
> I haven't read the full discussion you have CCed me on yesterday, but I
> have one substantial question to start with -- is there a simple
> explanation in a few sentences why Bluetooth-LE can't be added as a
> in-kernel transport layer?

Just to add my own opinion here (as this topic has been brought before
long ago, but on linux-bluetooth only):

For LE we have a single LE channel (multiplexed for all LE profiles
running simultaneously, as described by Claudio and Joao Vita
earlier), and this channel takes so called ATT (attribute protocol)
packets. These packets have a very small header (at least one byte to
identify the request/response being sent), but usually have extra
bytes for parameters (e.g. an "attribute handle" from which BlueZ can
know to which GATT profile it is being addressed) and data payload.

If LE (actually the ATT protocol used by LE, which is also usable over
BR/EDR) were to be parsed on the kernel, we would also need to parse
the ATT packet in order to know to which attribute handles it is being
addressed. The kernel would also need to keep tracking of the higher
level HID over GATT services so it could know which packets to process
for HID , and which are destined for other LE profiles (running on
BlueZ, or being sent to non-HID profile running on peer device).

At least this is my understanding of the problem.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
