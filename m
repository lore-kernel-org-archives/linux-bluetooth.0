Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: Andre Guedes <andre.guedes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2 9/9] Bluetooth: Support LE-Only discovery procedure
Date: Wed, 30 Nov 2011 06:43:59 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0264282C0@DNCE02.ent.ti.com>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
 <1322265226-6404-10-git-send-email-andre.guedes@openbossa.org>
 <F0070FBC0FB3174D8D11444EB2D5B02641649D@DNCE02.ent.ti.com>
 <20111129091434.GB17393@x220>
In-Reply-To: <20111129091434.GB17393@x220>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan, 

> -----Original Message-----
> From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
> Sent: Tuesday, November 29, 2011 11:15 AM
> To: Ganir, Chen
> Cc: Andre Guedes; linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v2 9/9] Bluetooth: Support LE-Only discovery
> procedure
> 
> Hi Chen,
> 
> > Do we really need this kind of functionality?
> 
> Firstly you should realize that this is not about functionality exposed
> to the user or applications, but functionality exposed to bluetoothd.
> The fact that we have something in the mgmt interface doesn't mean that
> it'll automatically be exposed in the D-Bus interface or bluetoothd
> internal APIs.
> 
> As for this particular case (allowing bluetoothd to restrict device
> discovery to LE or BR/EDR) the reason is the concern that when doing
> discovery for a specific profile which is only applicable for BR/EDR or
> LE, you really don't want to waste the users time doing the "other"
> discovery which will not yield any valuable results. Examples of this
> could be discovering devices to send a file over Object Push (BR/EDR
> only) or when running a application for a LE profile which utilizes
> features only available though an LE radio.
> 
> I'm not completely sure the need for this will be strong enough for
> exposing it in the D-Bus API, but not having it in the kernel interface
> (mgmt) from the start makes it a lot harder to fix if we do end up
> needing it later (as opposed to the D-Bus interface which would "only"
> mean doing a new major BlueZ version).
> 
> Johan

If this is the case, and we know that for now, we have no need for this, why introduce more complexity ? How will the current GAP device search work ? How will interleaved scanning work ? Will it be triggered from the bluetoothd ? Will it be handled by the kernel ?

Chen.

