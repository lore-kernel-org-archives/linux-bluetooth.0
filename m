Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Nov 2011 11:14:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 9/9] Bluetooth: Support LE-Only discovery procedure
Message-ID: <20111129091434.GB17393@x220>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
 <1322265226-6404-10-git-send-email-andre.guedes@openbossa.org>
 <F0070FBC0FB3174D8D11444EB2D5B02641649D@DNCE02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B02641649D@DNCE02.ent.ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

> Do we really need this kind of functionality?

Firstly you should realize that this is not about functionality exposed
to the user or applications, but functionality exposed to bluetoothd.
The fact that we have something in the mgmt interface doesn't mean that
it'll automatically be exposed in the D-Bus interface or bluetoothd
internal APIs.

As for this particular case (allowing bluetoothd to restrict device
discovery to LE or BR/EDR) the reason is the concern that when doing
discovery for a specific profile which is only applicable for BR/EDR or
LE, you really don't want to waste the users time doing the "other"
discovery which will not yield any valuable results. Examples of this
could be discovering devices to send a file over Object Push (BR/EDR
only) or when running a application for a LE profile which utilizes
features only available though an LE radio.

I'm not completely sure the need for this will be strong enough for
exposing it in the D-Bus API, but not having it in the kernel interface
(mgmt) from the start makes it a lot harder to fix if we do end up
needing it later (as opposed to the D-Bus interface which would "only"
mean doing a new major BlueZ version).

Johan
