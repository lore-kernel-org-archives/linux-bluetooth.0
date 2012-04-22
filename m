Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335125337.16897.357.camel@aeonflux>
References: <CAB7rCTjRzTZP6TDgsrWvFxE8zuFuYDBQdMnjyvnM4p6Cw=ro2g@mail.gmail.com>
	<1335004527.16897.337.camel@aeonflux>
	<CAB7rCTiu18D8h611avpWqP9fD2STaWMErN7bSv-af-7yvraQaw@mail.gmail.com>
	<1335035377.16897.340.camel@aeonflux>
	<CAB7rCTgxpeXiMqz8__GEzEekkCb79yU--TEq6N=qZMuyuR+SoQ@mail.gmail.com>
	<1335042808.16897.350.camel@aeonflux>
	<CAB7rCThjFzL7Ji=eVf_KSrn-DxytG7qdoXb+zf5o+Rgx5JhkXA@mail.gmail.com>
	<1335125337.16897.357.camel@aeonflux>
Date: Sun, 22 Apr 2012 15:33:45 -0500
Message-ID: <CAB7rCTgLNv=BUznKMN3hU3NM_7odUsoELC2LZGYFwX6Xqawg5Q@mail.gmail.com>
Subject: Re: PTS / linkkey issue
From: Mike <puffy.taco@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> >> >> >> I'm having a somewhat relate issue to Vishal AGARWAL [1]. =A0Th=
e trouble
>> >> >> >> I have is that the PTS system is requesting auth type 0, and Bl=
uez
>> >> >> >> happily obliges. =A0This leaves the PTS device as temporary, an=
d BlueZ
>> >> >> >> then deletes this device after the end of the connection. =A0Th=
is
>> >> >> >> prevents me from being able to pass TP/OOR/BV-02-I: [HF reconne=
cts to
>> >> >> >> AG]. =A0The code is designed to periodically reconnect to the A=
G after
>> >> >> >> it detects a link timeout. =A0But, if BlueZ has deleted the dev=
ice, I
>> >> >> >> don't do that. =A0This also somewhat applies to the A2DP test c=
ases, as
>> >> >> >> my device must be left in pairing mode in order for the tests t=
o pass.
>> >> >> >>
>> >> >> >> So, my question to people who have used PTS, is there a way to =
get the
>> >> >> >> PTS to perform a pairing that is not 0x00 MITM Protection Not R=
equired
>> >> >> >> =96 No Bonding. Numeric comparison with automatic accept allowe=
d? =A0I'm
>> >> >> >> using an older kernel that doesn't have the mgmt interface (2.6=
.33
>> >> >> >> with some features/fixes backported from newer kernels) but am =
using
>> >> >> >> the latest BlueZ from git (at least of a month ago or so). =A0B=
ut even
>> >> >> >> so, the proposal of keeping the linkkey around for the ACL sess=
ion
>> >> >> >> would be useless, I think, because the intent is to have a link
>> >> >> >> timeout event.
>> >> >> >
>> >> >> > can you quickly check if for some weird reason the PTS uses debu=
g keys
>> >> >> > or if you enabled debug keys within BlueZ.
>> >> >> >
>> >> >> > We treat debug keys even worse than no bonding. Unless you set D=
ebugKeys
>> >> >> > in /etc/bluetooth/main.conf they are thrown out right away. Howe=
ver be
>> >> >> > really careful here. That option is only for debugging. You shou=
ld never
>> >> >> > ever leave that on in a production device. You would make your d=
evice
>> >> >> > vulnerable like no tomorrow.
>> >> >>
>> >> >> I checked hci dumps of both the init of my unit and the trace from=
 the
>> >> >> PTS run, and neither had sent the HCI_Write_Simple_Pairing_Debug_m=
ode
>> >> >> command. =A0Plus we can see that the key type is 0x04, Unauthentic=
ated
>> >> >> Combination Key. =A0I also verified that DebugKeys was false in
>> >> >> main.conf.
>> >> >
>> >> > please post the actual pairing exchange here, but this seems like t=
he
>> >> > PTS is fundamentally broken. If we pair with no bonding, we do thro=
w the
>> >> > link key away and that is suppose to be done this way.
>> >>
>> >> I have attached the trace both in Frontline ComProbe capture format
>> >> and as an export to a somewhat readable html format. =A0The trace was
>> >> taken on the PTS machine (so host=3DPTS machine). =A0Note that it is =
not a
>> >> trace from the particular test I mentioned above, but every test has
>> >> the same pairing experience.
>> >>
>> >> I think what you're after is this section:
>> >>
>> >> Frame 65: (Controller) Len=3D8
>> >> HCI
>> >> Packet from: Controller
>> >> HCI Event
>> >> Event: HCI IO Capability Request
>> >> Total Length: 6
>> >> BD_ADDR: 0x649c8ec1bce3
>> >>
>> >> Frame 66: (Host) Len=3D12
>> >> HCI
>> >> Packet from: Host
>> >> HCI Command
>> >> Opcode: 0x042b
>> >> Group: Link Control
>> >> Command: HCI_IO_Capability_Response
>> >> Total Length: 9
>> >> Bluetooth Device Address: 0x64-9c-8e-c1-bc-e3
>> >> LAP: 0xc1-bc-e3
>> >> UAP: 0x8e
>> >> NAP: 0x64-9c
>> >> IO Capability: DisplayYesNo
>> >> OOB Data Present: OOB authentication data not present
>> >> Authentication_Requirements: MITM Protection Not Required - No
>> >> Bonding. Numeric comparision with automatic accept allowed
>> >>
>> >> Frame 67: (Controller) Len=3D12
>> >> HCI
>> >> Packet from: Controller
>> >> HCI Event
>> >> Event: Command Complete
>> >> Total Length: 10
>> >> Number HCI Command Packets: 1
>> >> HCI Command
>> >> Opcode: 0x042b
>> >> Group: Link Control
>> >> Command: HCI_IO_Capability_Response
>> >> Return Parameters
>> >> Status: Success
>> >> Bluetooth Device Address: 0x64-9c-8e-c1-bc-e3
>> >> LAP: 0xc1-bc-e3
>> >> UAP: 0x8e
>> >> NAP: 0x64-9c
>> >>
>> >> Frame 68: (Controller) Len=3D11
>> >> HCI
>> >> Packet from: Controller
>> >> HCI Event
>> >> Event: HCI IO Capability Response
>> >> Total Length: 9
>> >> BD_ADDR: 0x649c8ec1bce3
>> >> IO Capability: NoInputNoOutput
>> >> OOB Data Present: OOB authentication data not present
>> >> Authentication_Requirements: MITM Protection Not Required - No
>> >> Bonding. Numeric comparision with automatic accept allowed
>> >>
>> >> > Is there any chance to do a dedicated or general bonding with the P=
TS to
>> >> > keep the link key around? Like you would actually be doing when usi=
ng
>> >> > any HFP device.
>> >>
>> >> It appears, based on the issues filed against PTS, that the PTS
>> >> doesn't have this option. =A0Right now, my device, which acts as HFP =
HF,
>> >> does not initiate pairing through any UI and requires the HFP AG to
>> >> make the first connection.
>> >
>> > and if you are the HF role, then this is perfectly acceptable. The oth=
er
>> > side should pair with you. And they need to use dedicated bonding to d=
o
>> > so. The no bonding pairing is utterly useless.
>> >
>> > Going through the log, it it seems that the PTS initiates the connecti=
on
>> > and then tries to pair. Since it has no link key for the other side, i=
t
>> > should realize that it has to run dedicated bonding first. Doing this
>> > with no bonding is just wrong.
>> >
>> > Any chance to run this PTS case against an actual Bluetooth headset an=
d
>> > see what it does in this area. We can not store the link key if it has
>> > been requested with no bonding. The only thing I can think of right no=
w
>> > is that when the RFCOMM channel is requested we force an upgrade of th=
e
>> > link key to general bonding.
>>
>> Attached a trace against a BT headset. =A0It looks pretty much the same,
>> except that the BT headset does keep the link key around in the no
>> bonding case, so future PTS runs work without have to do a new
>> pairing.
>
> that just means that everybody has worked around PTS being utterly
> stupid. This is so sad.
>
>> It's not just HFP that's affected. =A0The same type of problem exists
>> with A2DP where we're forced to leave the Pairable Bluez adapter
>> property True for every PTS connection attempt. =A0We normally set
>> Discoverable and Pairable at the same time. =A0So even if the RFCOMM
>> case caused extra actions, it hardly fixes it.
>
> The concept of Pairable is exactly present so that an attacker can not
> pair with you out of the blue. If you are not in Pairable and have no
> link key, you just get rejected right away. Which is the right way to do
> it.
>
> Secure Simple Pairing might give you an unbreakable authentication, but
> you can now just go in an redo the pairing any time you like. Not really
> what should happen.
>
> I am curious if the PTS would even survive a pairing request with
> general bonding after we just paired with no bonding. But essentially
> you are correct here. If Pairable is not set, it is not going to help
> us.
>
> So I have not seen the complete log since even the HTML is ugly, but
> when the PTS tries to re-connect and we re-connect to the PTS, would it
> actually store the link key? If PTS also throws the key away, then this
> is all pointless attempt.

>From what the BQE doing the testing for me has shown, there is some
means by which the same link key can be used in multiple sessions of
the PTS.  Not sure exactly what causes that.

In any case, the real trouble I have is that BlueZ doesn't keep the
device around.  The link key issue is worked around enough by leaving
Pairable as true for the PTS session.  Since the link key is not going
to be kept, the device keeps the temporary marking.  Once I lose
connection, all D-Bus paths for the device disappear.  Without the
D-Bus paths, the Ofono Modem disappears and I don't have a mechanism
to attempt a reconnection.  I had mentioned the BQE try to call the
CreateDevice method against the BlueZ adapter, thinking as long as the
device is created first, it might all work.  I'm told that it didn't.
It may be that the Pairable property went back to false (timeout) and
that caused problems.  Do you think that should have worked?  If so,
I'll have him give it a try again.  If we can get that working, then
there is at least a means to workaround PTS' issues.

Thanks,
Mike

> Personally, the PTS should be doing a dedicated bonding first as
> preamble for every test case. Otherwise this is by no means real world
> testing anyway.
