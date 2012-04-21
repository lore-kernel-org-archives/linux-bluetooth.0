Return-Path: <cyrus@holtmann.org>
Message-ID: <1335042808.16897.350.camel@aeonflux>
Subject: Re: PTS / linkkey issue
From: Marcel Holtmann <marcel@holtmann.org>
To: Mike <puffy.taco@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sat, 21 Apr 2012 23:13:28 +0200
In-Reply-To: <CAB7rCTgxpeXiMqz8__GEzEekkCb79yU--TEq6N=qZMuyuR+SoQ@mail.gmail.com>
References: <CAB7rCTjRzTZP6TDgsrWvFxE8zuFuYDBQdMnjyvnM4p6Cw=ro2g@mail.gmail.com>
	 <1335004527.16897.337.camel@aeonflux>
	 <CAB7rCTiu18D8h611avpWqP9fD2STaWMErN7bSv-af-7yvraQaw@mail.gmail.com>
	 <1335035377.16897.340.camel@aeonflux>
	 <CAB7rCTgxpeXiMqz8__GEzEekkCb79yU--TEq6N=qZMuyuR+SoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

> >> >> I'm having a somewhat relate issue to Vishal AGARWAL [1].  The trouble
> >> >> I have is that the PTS system is requesting auth type 0, and Bluez
> >> >> happily obliges.  This leaves the PTS device as temporary, and BlueZ
> >> >> then deletes this device after the end of the connection.  This
> >> >> prevents me from being able to pass TP/OOR/BV-02-I: [HF reconnects to
> >> >> AG].  The code is designed to periodically reconnect to the AG after
> >> >> it detects a link timeout.  But, if BlueZ has deleted the device, I
> >> >> don't do that.  This also somewhat applies to the A2DP test cases, as
> >> >> my device must be left in pairing mode in order for the tests to pass.
> >> >>
> >> >> So, my question to people who have used PTS, is there a way to get the
> >> >> PTS to perform a pairing that is not 0x00 MITM Protection Not Required
> >> >> – No Bonding. Numeric comparison with automatic accept allowed?  I'm
> >> >> using an older kernel that doesn't have the mgmt interface (2.6.33
> >> >> with some features/fixes backported from newer kernels) but am using
> >> >> the latest BlueZ from git (at least of a month ago or so).  But even
> >> >> so, the proposal of keeping the linkkey around for the ACL session
> >> >> would be useless, I think, because the intent is to have a link
> >> >> timeout event.
> >> >
> >> > can you quickly check if for some weird reason the PTS uses debug keys
> >> > or if you enabled debug keys within BlueZ.
> >> >
> >> > We treat debug keys even worse than no bonding. Unless you set DebugKeys
> >> > in /etc/bluetooth/main.conf they are thrown out right away. However be
> >> > really careful here. That option is only for debugging. You should never
> >> > ever leave that on in a production device. You would make your device
> >> > vulnerable like no tomorrow.
> >>
> >> I checked hci dumps of both the init of my unit and the trace from the
> >> PTS run, and neither had sent the HCI_Write_Simple_Pairing_Debug_mode
> >> command.  Plus we can see that the key type is 0x04, Unauthenticated
> >> Combination Key.  I also verified that DebugKeys was false in
> >> main.conf.
> >
> > please post the actual pairing exchange here, but this seems like the
> > PTS is fundamentally broken. If we pair with no bonding, we do throw the
> > link key away and that is suppose to be done this way.
> 
> I have attached the trace both in Frontline ComProbe capture format
> and as an export to a somewhat readable html format.  The trace was
> taken on the PTS machine (so host=PTS machine).  Note that it is not a
> trace from the particular test I mentioned above, but every test has
> the same pairing experience.
> 
> I think what you're after is this section:
> 
> Frame 65: (Controller) Len=8
> HCI
> Packet from: Controller
> HCI Event
> Event: HCI IO Capability Request
> Total Length: 6
> BD_ADDR: 0x649c8ec1bce3
> 
> Frame 66: (Host) Len=12
> HCI
> Packet from: Host
> HCI Command
> Opcode: 0x042b
> Group: Link Control
> Command: HCI_IO_Capability_Response
> Total Length: 9
> Bluetooth Device Address: 0x64-9c-8e-c1-bc-e3
> LAP: 0xc1-bc-e3
> UAP: 0x8e
> NAP: 0x64-9c
> IO Capability: DisplayYesNo
> OOB Data Present: OOB authentication data not present
> Authentication_Requirements: MITM Protection Not Required - No
> Bonding. Numeric comparision with automatic accept allowed
> 
> Frame 67: (Controller) Len=12
> HCI
> Packet from: Controller
> HCI Event
> Event: Command Complete
> Total Length: 10
> Number HCI Command Packets: 1
> HCI Command
> Opcode: 0x042b
> Group: Link Control
> Command: HCI_IO_Capability_Response
> Return Parameters
> Status: Success
> Bluetooth Device Address: 0x64-9c-8e-c1-bc-e3
> LAP: 0xc1-bc-e3
> UAP: 0x8e
> NAP: 0x64-9c
> 
> Frame 68: (Controller) Len=11
> HCI
> Packet from: Controller
> HCI Event
> Event: HCI IO Capability Response
> Total Length: 9
> BD_ADDR: 0x649c8ec1bce3
> IO Capability: NoInputNoOutput
> OOB Data Present: OOB authentication data not present
> Authentication_Requirements: MITM Protection Not Required - No
> Bonding. Numeric comparision with automatic accept allowed
> 
> > Is there any chance to do a dedicated or general bonding with the PTS to
> > keep the link key around? Like you would actually be doing when using
> > any HFP device.
> 
> It appears, based on the issues filed against PTS, that the PTS
> doesn't have this option.  Right now, my device, which acts as HFP HF,
> does not initiate pairing through any UI and requires the HFP AG to
> make the first connection.

and if you are the HF role, then this is perfectly acceptable. The other
side should pair with you. And they need to use dedicated bonding to do
so. The no bonding pairing is utterly useless.

Going through the log, it it seems that the PTS initiates the connection
and then tries to pair. Since it has no link key for the other side, it
should realize that it has to run dedicated bonding first. Doing this
with no bonding is just wrong.

Any chance to run this PTS case against an actual Bluetooth headset and
see what it does in this area. We can not store the link key if it has
been requested with no bonding. The only thing I can think of right now
is that when the RFCOMM channel is requested we force an upgrade of the
link key to general bonding.

This essentially means pairing twice and that is still stupid, but might
be what we should be doing. Or at least provide another hint to the
L2CAP and RFCOMM channel's security to what we expect before allowing
any connection. This is far fetching and utterly pointless if it would
make break the GAP qualification.

So I am curious to see a trace from a headset and a standard headset
handles this. Or if they all just ignore the no bonding part.

Johan, have a look at this. You looked this stuff more recently than I
did.

Regards

Marcel


