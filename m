Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110608013644.GA8315@dell.ccr.corp.intel.com>
References: <BANLkTikAfy-=MRTb_SGa8d2td5oq73xGYg@mail.gmail.com>
	<1306976897.7131.5.camel@aeonflux>
	<20110608013644.GA8315@dell.ccr.corp.intel.com>
Date: Thu, 16 Jun 2011 18:18:35 +0200
Message-ID: <BANLkTi=oyVyy2ocyP5hbHe2TmfRLGN1zpw@mail.gmail.com>
Subject: Re: Binary PIN Support
From: David Herrmann <dh.herrmann@googlemail.com>
To: Marcel Holtmann <marcel@holtmann.org>, David Herrmann <dh.herrmann@googlemail.com>,
	linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 8, 2011 at 3:36 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Marcel,
>
> On Thu, Jun 02, 2011, Marcel Holtmann wrote:
>> > Since the idea with hex-encoding binary PINs and prefixing them with
>> > '$' did not get accepted, I have some other ideas for this:
>> >
>> > 1: Use hard coded PINs for those devices. That is, use VID/PID
>> > detection during pairing and send hardcoded PIN (or based on src/dst
>> > address). Problem: VID/PID information is not available during
>> > pairing or may not be available, yet. Some devices may even reject
>> > SDP requests when not paired (as mentioned on IRC). Maybe someone
>> > has an idea how to get this working.
>>
>> if I remember this correctly, then Wiimote does support DeviceID profile
>> and thus reports proper VID/PID combinations.
>>
>> So just create some auto-pair support in bluetoothd (if needed via
>> plugins) and just auto-pair them like we would do with Secure Simple
>> Pairing anyway.
>>
>> There is really no need at all to involve the UI code and mess up the
>> D-Bus API as it is. It was never designed for hardcoded PIN codes other
>> then numbers and strings anyway.
>>
>> > 2: Extend DBus Agent API with a function RequestBinaryPinCode()
>> > which works exactly like RequestPinCode() but returns a bytearray
>> > (with length) instead of a string. A dbus agent then needs to
>> > signal to bluetoothd that it provides this method and bluetoothd
>> > shall call RequestBinaryPinCode() instead of RequestPinCode().
>> > However, I couldn't figure out a proper way to signal this capability
>> > to bluetoothd.
>> > The agent could send some kind of EnabledBinaryPinSupport-Signal to
>> > bluetoothd...
>>
>> No way ever. We had that problem when we initially had to support a
>> fallback for the agent in 3.x series. Never ever again.
>>
>> > 3: Use some kind of encoding in the UTF-8 string as proposed with the
>> > '$' character.
>> > However, this might break old software.
>>
>> And how is that going to work out in reality. Same as $ is a valid
>> character. So also a clear no.
>>
>> Go with 1) and try to just auto-pair the Wiimotes. That is the right
>> approach and makes a lot sense. It might be the one with the most work
>> on getting the DeviceID support integrated properly, but it is the right
>> way forward here.
>
> Does the Wiimote support DeviceID info through EIR? If not we'd need to
> change the way CreatePairedDevice works since right now SDP is done only
> *after* pairing.

Would it be ok if I write a plugin that compares the remote-name of
the bluetooth device with its database and performs SDP queries before
authentication?
That is, the UI programs would have to use CreateDevice() to connect
to wiimotes, the plugin would then see that the device-name looks
familiar, perform SDP query and if the DeviceID matches, then the
plugin will call CraetePairedDevice() (or its internal functions) to
start authentication.

This would mean that despite UI programs call CreateDevice() they will
get always a paired device (if the remote device is a wiimote).
Otherwise I would need to change CreatePairedDevice() to always
perform SDP queries before pairing which would delay the
authentication on many devices that don't need this. Also many devices
may not even allow SDP when not paired so this would even fail on many
devices.

Regards
David
