Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Nov 2011 13:44:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 9/9] Bluetooth: Support LE-Only discovery procedure
Message-ID: <20111130114441.GA12605@x220>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
 <1322265226-6404-10-git-send-email-andre.guedes@openbossa.org>
 <F0070FBC0FB3174D8D11444EB2D5B02641649D@DNCE02.ent.ti.com>
 <20111129091434.GB17393@x220>
 <F0070FBC0FB3174D8D11444EB2D5B0264282C0@DNCE02.ent.ti.com>
 <20111130112703.GA12146@x220>
 <F0070FBC0FB3174D8D11444EB2D5B026428402@DNCE02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B026428402@DNCE02.ent.ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Nov 30, 2011, Ganir, Chen wrote:
> What I meant to ask was who is responsible for asking for dual mode or
> single mode scan now that the parameters were added? Does the
> bluetoothd now needs to know if the controller and host support LE, so
> it can start a BR/EDR/LE scan? or will the bluetoothd always ask for
> BR/EDR/LE scan, and the kernel will execute the supported search
> according to the LMP flags?

The latter (in fact that's what bluetoothd is already now doing; it's
just that the necessary bits on the kernel side aren't in place yet).

Johan
