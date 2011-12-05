Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: LE Connection issues
Date: Mon, 5 Dec 2011 15:38:24 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B026440280@DNCE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone.

I've tried investigating the LE connection procedure a bit, and I came up with some issues. For example, you MUST first scan for devices even if you have a device already paired, in order to connect to it. This is not the case for BR/EDR devices, where you can turn on the host, and try to connect to the paired device immediately. This has a major impact on user experience. I believe that the only relevant information from the advertising data is the address type, which can be sent to the host, and used later when trying to connect to the device again. I believe there were some discussions regarding this issue a while back, but I cannot recall what was done about this.

In addition, a call for brd_device_add_attio_callback may fail immediately (without even calling the connect/disconnect callbacks) if the device is not present in the advertising cache (fail with error "no route to device"). This also results in a bad user experience, since a user may think that the host is trying to connect to the peer, while in fact the host failed and did not indicate this failure to the user. Since LE does not define a connection timeout, we have a problem here, since we failed on implementation and not spec issue, and we did not inform the user of this error.

Did anyone else encounter these issues, or has anything to comment about these issues ?

Thanks,
Chen Ganir.
