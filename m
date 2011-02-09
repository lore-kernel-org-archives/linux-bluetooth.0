Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D51D8AE.9020005@codeaurora.org>
References: <4D51D8AE.9020005@codeaurora.org>
Date: Wed, 9 Feb 2011 07:34:09 -0200
Message-ID: <AANLkTimiJ2sP8yrpnk3=Hjo6XrVoEuRbmYE2H=UsKAA7@mail.gmail.com>
Subject: Re: Kernal/User space change for LE Random Addresses
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,
On Tue, Feb 8, 2011 at 9:58 PM, Brian Gix <bgix@codeaurora.org> wrote:
>
> One other change that is needed, which I don't really know how to attack is
> remote devices with Random Addresses.  There is at least one team here at
> UPF with a device with a Random Address which cannot be connected to with
> either Vinicius' or the bluetooth-next kernal tips, because the connection
> HCI command only specifies Public Addresses as the remote address type.
>

We are already working on it. We discussed yesterday an approach to
address this issue.
An address/advertising cache will be added in the kernel, if the given
address is found in the cache the two most significant bits will be
checked to infer the address type, otherwise the fallback will be
BR/EDR. For BR/EDR L2CAP SOCK_SEQPACKET sockets PSM is always
provided, we can also use this information to distinguish BR/EDR from
LE address if an advertising has not been detected previously.

> I am not at all knowledgable about sockets, but I assume that a new Socket
> option needs to be defined that specifies address type.
>
> I can get around this inelegantly by building a secondary kernel which
> hard-codes the address type to Random, and then dual booting into that
> kernel for random address only remote devices.
>
> I would love if someone who knows the bluez socket option handling (both
> kernel and user space) could fix this, otherwise I will try to muddle along
> on my own.

I suggest to build a secondary kernel while we are working on it.

BR,
Claudio.
