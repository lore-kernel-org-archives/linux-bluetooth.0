Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Jun 2011 10:36:44 +0900
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>,
	linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: Binary PIN Support
Message-ID: <20110608013644.GA8315@dell.ccr.corp.intel.com>
References: <BANLkTikAfy-=MRTb_SGa8d2td5oq73xGYg@mail.gmail.com>
 <1306976897.7131.5.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306976897.7131.5.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jun 02, 2011, Marcel Holtmann wrote:
> > Since the idea with hex-encoding binary PINs and prefixing them with
> > '$' did not get accepted, I have some other ideas for this:
> > 
> > 1: Use hard coded PINs for those devices. That is, use VID/PID
> > detection during pairing and send hardcoded PIN (or based on src/dst
> > address). Problem: VID/PID information is not available during
> > pairing or may not be available, yet. Some devices may even reject
> > SDP requests when not paired (as mentioned on IRC). Maybe someone
> > has an idea how to get this working.
> 
> if I remember this correctly, then Wiimote does support DeviceID profile
> and thus reports proper VID/PID combinations.
> 
> So just create some auto-pair support in bluetoothd (if needed via
> plugins) and just auto-pair them like we would do with Secure Simple
> Pairing anyway.
> 
> There is really no need at all to involve the UI code and mess up the
> D-Bus API as it is. It was never designed for hardcoded PIN codes other
> then numbers and strings anyway.
> 
> > 2: Extend DBus Agent API with a function RequestBinaryPinCode()
> > which works exactly like RequestPinCode() but returns a bytearray
> > (with length) instead of a string. A dbus agent then needs to
> > signal to bluetoothd that it provides this method and bluetoothd
> > shall call RequestBinaryPinCode() instead of RequestPinCode().
> > However, I couldn't figure out a proper way to signal this capability
> > to bluetoothd.
> > The agent could send some kind of EnabledBinaryPinSupport-Signal to
> > bluetoothd...
> 
> No way ever. We had that problem when we initially had to support a
> fallback for the agent in 3.x series. Never ever again.
> 
> > 3: Use some kind of encoding in the UTF-8 string as proposed with the
> > '$' character.
> > However, this might break old software.
> 
> And how is that going to work out in reality. Same as $ is a valid
> character. So also a clear no.
> 
> Go with 1) and try to just auto-pair the Wiimotes. That is the right
> approach and makes a lot sense. It might be the one with the most work
> on getting the DeviceID support integrated properly, but it is the right
> way forward here.

Does the Wiimote support DeviceID info through EIR? If not we'd need to
change the way CreatePairedDevice works since right now SDP is done only
*after* pairing.

Johan
