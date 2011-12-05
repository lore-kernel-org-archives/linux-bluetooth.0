Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B026440280@DNCE02.ent.ti.com>
References: <F0070FBC0FB3174D8D11444EB2D5B026440280@DNCE02.ent.ti.com>
Date: Mon, 5 Dec 2011 17:51:09 -0300
Message-ID: <CAKT1EBfB_WSh45sgZzZYTF4tiu0yb+ZTy1wPKbMdApfAZdKHvw@mail.gmail.com>
Subject: Re: LE Connection issues
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Mon, Dec 5, 2011 at 12:38 PM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Hi everyone.
>
> I've tried investigating the LE connection procedure a bit, and I came up with some issues. For example, you MUST first scan for devices even if you have a device already paired, in order to connect to it. This is not the case for BR/EDR devices, where you can turn on the host, and try to connect to the paired device immediately. This has a major impact on user experience. I believe that the only relevant information from the advertising data is the address type, which can be sent to the host, and used later when trying to connect to the device again. I believe there were some discussions regarding this issue a while back, but I cannot recall what was done about this.
>
> In addition, a call for brd_device_add_attio_callback may fail immediately (without even calling the connect/disconnect callbacks) if the device is not present in the advertising cache (fail with error "no route to device"). This also results in a bad user experience, since a user may think that the host is trying to connect to the peer, while in fact the host failed and did not indicate this failure to the user. Since LE does not define a connection timeout, we have a problem here, since we failed on implementation and not spec issue, and we did not inform the user of this error.
>
> Did anyone else encounter these issues, or has anything to comment about these issues ?

We don't have a final decision yet, but there are some suggestions.
The fact is we need to have a functional implementation, even it is
not the final solution. Andre Guedes has some patches to trigger
scanning before each connect(if the address is not found in the
cache). Search for "[PATCH 0/4] LE connection improvements" in the
mailing list. However, considering that BlueZ will act as central it
is necessary to use whitelist during the connection establishment to
avoid the penalty for non connectable devices.

IMO connections should not be triggered intermediately for paired
devices. We need to provide more flexibility to allow apps/profiles
controlling connections. Definitively, btd_device_add_attio_callback
needs to be improved. We can't keep the timeout in the kernel since
timeouts are defined by profiles.

L2CAP config timeout ~40 seconds for LE connections should be
removed(discussed in Prague). Passive/background scanning if there is
at least one key available or a socket/connect pending is still open,
we need to discuss if it is feasible or not.

BR,
Claudio
