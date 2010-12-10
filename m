Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1291954417-18138-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1291954417-18138-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Fri, 10 Dec 2010 02:13:12 -0300
Message-ID: <AANLkTi=yGjNbLuy-7Gk9tWnMXV2r+DhKF5xjr4zfZXFb@mail.gmail.com>
Subject: Re: [PATCH] Initial draft of Application registration API
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

It should be a RFC instead of PATCH in the subject prefix.

On Fri, Dec 10, 2010 at 1:13 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Add new methods to allow automatic connection when a known remote device
> which supports the wanted services is found.
>
> Overview: RegisterApplication method allows a given application to
> controls the connection establishment procedure for bonded devices.
> StartDiscovery() implements an interleaved discovery, switching between
> inquiry and LE active scanning. For single mode devices found, an
> application can call CreateDevice or CreatePairedDevice, these methods
> will trigger the Discover All Primary Services and SSP(if applied).

Please read SMP instead of SSP for CreatePairedDevice. GATT/ATT
implements a per attribute permission, for BlueZ we are planning to
use CreatePairedDevice to trigger the SMP/key distribution. SMP
negotiation is being implemented completely in the kernel, but at the
moment there isn't key storage and management interface between the
kernel and the userspace to notify the keys. SMP just works method
will be triggered when the client access the first attribute which
requires encryption or when a encrypted link is created.

IMHO, automatic connections needs to be restricted to bonded devices.
If necessary, we can also use the Trusted property.

Claudio
