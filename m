Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "Ganir, Chen" <chen.ganir@ti.com>,
        "marcel@holtmann.org"
	<marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] hcidump: Add TI Logger dump support
Date: Sun, 20 Jan 2013 18:58:58 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B920418@DNCE05.ent.ti.com>
References: <1356354253-26134-1-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1356354253-26134-1-git-send-email-chen.ganir@ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


> -----Original Message-----
> From: Ganir, Chen
> Sent: Monday, December 24, 2012 3:04 PM
> To: marcel@holtmann.org; linux-bluetooth@vger.kernel.org
> Cc: Ganir, Chen
> Subject: [PATCH] hcidump: Add TI Logger dump support
>=20
> From: Chen Ganir <chen.ganir@ti.com>
>=20
> Texas Instruments controllers can be configured to send the
> internal firmware log through a vendor specific HCI event on
> the hci transport.
> This patch allows capturing those log events, and writing them
> to a file, which can then be used with the latest TI Logger
> application to read and show the logs.
>=20
> This is usefull in case there is no other way to get the TI log
> (for example, the lack of a connection to the controller Log TX
> hardware line).


Holtmann, Did you forget this one ? This is the fixed version, after your c=
omments.

Thanks,
Chen Ganir.
