Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335042808.16897.350.camel@aeonflux>
References: <CAB7rCTjRzTZP6TDgsrWvFxE8zuFuYDBQdMnjyvnM4p6Cw=ro2g@mail.gmail.com>
	<1335004527.16897.337.camel@aeonflux>
	<CAB7rCTiu18D8h611avpWqP9fD2STaWMErN7bSv-af-7yvraQaw@mail.gmail.com>
	<1335035377.16897.340.camel@aeonflux>
	<CAB7rCTgxpeXiMqz8__GEzEekkCb79yU--TEq6N=qZMuyuR+SoQ@mail.gmail.com>
	<1335042808.16897.350.camel@aeonflux>
Date: Sun, 22 Apr 2012 12:42:10 -0500
Message-ID: <CAB7rCThjFzL7Ji=eVf_KSrn-DxytG7qdoXb+zf5o+Rgx5JhkXA@mail.gmail.com>
Subject: Re: PTS / linkkey issue
From: Mike <puffy.taco@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary=0016e6dd8d508d0e4f04be480a2d
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e6dd8d508d0e4f04be480a2d
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>> >> >> I'm having a somewhat relate issue to Vishal AGARWAL [1]. =A0The t=
rouble
>> >> >> I have is that the PTS system is requesting auth type 0, and Bluez
>> >> >> happily obliges. =A0This leaves the PTS device as temporary, and B=
lueZ
>> >> >> then deletes this device after the end of the connection. =A0This
>> >> >> prevents me from being able to pass TP/OOR/BV-02-I: [HF reconnects=
 to
>> >> >> AG]. =A0The code is designed to periodically reconnect to the AG a=
fter
>> >> >> it detects a link timeout. =A0But, if BlueZ has deleted the device=
, I
>> >> >> don't do that. =A0This also somewhat applies to the A2DP test case=
s, as
>> >> >> my device must be left in pairing mode in order for the tests to p=
ass.
>> >> >>
>> >> >> So, my question to people who have used PTS, is there a way to get=
 the
>> >> >> PTS to perform a pairing that is not 0x00 MITM Protection Not Requ=
ired
>> >> >> =96 No Bonding. Numeric comparison with automatic accept allowed? =
=A0I'm
>> >> >> using an older kernel that doesn't have the mgmt interface (2.6.33
>> >> >> with some features/fixes backported from newer kernels) but am usi=
ng
>> >> >> the latest BlueZ from git (at least of a month ago or so). =A0But =
even
>> >> >> so, the proposal of keeping the linkkey around for the ACL session
>> >> >> would be useless, I think, because the intent is to have a link
>> >> >> timeout event.
>> >> >
>> >> > can you quickly check if for some weird reason the PTS uses debug k=
eys
>> >> > or if you enabled debug keys within BlueZ.
>> >> >
>> >> > We treat debug keys even worse than no bonding. Unless you set Debu=
gKeys
>> >> > in /etc/bluetooth/main.conf they are thrown out right away. However=
 be
>> >> > really careful here. That option is only for debugging. You should =
never
>> >> > ever leave that on in a production device. You would make your devi=
ce
>> >> > vulnerable like no tomorrow.
>> >>
>> >> I checked hci dumps of both the init of my unit and the trace from th=
e
>> >> PTS run, and neither had sent the HCI_Write_Simple_Pairing_Debug_mode
>> >> command. =A0Plus we can see that the key type is 0x04, Unauthenticate=
d
>> >> Combination Key. =A0I also verified that DebugKeys was false in
>> >> main.conf.
>> >
>> > please post the actual pairing exchange here, but this seems like the
>> > PTS is fundamentally broken. If we pair with no bonding, we do throw t=
he
>> > link key away and that is suppose to be done this way.
>>
>> I have attached the trace both in Frontline ComProbe capture format
>> and as an export to a somewhat readable html format. =A0The trace was
>> taken on the PTS machine (so host=3DPTS machine). =A0Note that it is not=
 a
>> trace from the particular test I mentioned above, but every test has
>> the same pairing experience.
>>
>> I think what you're after is this section:
>>
>> Frame 65: (Controller) Len=3D8
>> HCI
>> Packet from: Controller
>> HCI Event
>> Event: HCI IO Capability Request
>> Total Length: 6
>> BD_ADDR: 0x649c8ec1bce3
>>
>> Frame 66: (Host) Len=3D12
>> HCI
>> Packet from: Host
>> HCI Command
>> Opcode: 0x042b
>> Group: Link Control
>> Command: HCI_IO_Capability_Response
>> Total Length: 9
>> Bluetooth Device Address: 0x64-9c-8e-c1-bc-e3
>> LAP: 0xc1-bc-e3
>> UAP: 0x8e
>> NAP: 0x64-9c
>> IO Capability: DisplayYesNo
>> OOB Data Present: OOB authentication data not present
>> Authentication_Requirements: MITM Protection Not Required - No
>> Bonding. Numeric comparision with automatic accept allowed
>>
>> Frame 67: (Controller) Len=3D12
>> HCI
>> Packet from: Controller
>> HCI Event
>> Event: Command Complete
>> Total Length: 10
>> Number HCI Command Packets: 1
>> HCI Command
>> Opcode: 0x042b
>> Group: Link Control
>> Command: HCI_IO_Capability_Response
>> Return Parameters
>> Status: Success
>> Bluetooth Device Address: 0x64-9c-8e-c1-bc-e3
>> LAP: 0xc1-bc-e3
>> UAP: 0x8e
>> NAP: 0x64-9c
>>
>> Frame 68: (Controller) Len=3D11
>> HCI
>> Packet from: Controller
>> HCI Event
>> Event: HCI IO Capability Response
>> Total Length: 9
>> BD_ADDR: 0x649c8ec1bce3
>> IO Capability: NoInputNoOutput
>> OOB Data Present: OOB authentication data not present
>> Authentication_Requirements: MITM Protection Not Required - No
>> Bonding. Numeric comparision with automatic accept allowed
>>
>> > Is there any chance to do a dedicated or general bonding with the PTS =
to
>> > keep the link key around? Like you would actually be doing when using
>> > any HFP device.
>>
>> It appears, based on the issues filed against PTS, that the PTS
>> doesn't have this option. =A0Right now, my device, which acts as HFP HF,
>> does not initiate pairing through any UI and requires the HFP AG to
>> make the first connection.
>
> and if you are the HF role, then this is perfectly acceptable. The other
> side should pair with you. And they need to use dedicated bonding to do
> so. The no bonding pairing is utterly useless.
>
> Going through the log, it it seems that the PTS initiates the connection
> and then tries to pair. Since it has no link key for the other side, it
> should realize that it has to run dedicated bonding first. Doing this
> with no bonding is just wrong.
>
> Any chance to run this PTS case against an actual Bluetooth headset and
> see what it does in this area. We can not store the link key if it has
> been requested with no bonding. The only thing I can think of right now
> is that when the RFCOMM channel is requested we force an upgrade of the
> link key to general bonding.

Attached a trace against a BT headset.  It looks pretty much the same,
except that the BT headset does keep the link key around in the no
bonding case, so future PTS runs work without have to do a new
pairing.

It's not just HFP that's affected.  The same type of problem exists
with A2DP where we're forced to leave the Pairable Bluez adapter
property True for every PTS connection attempt.  We normally set
Discoverable and Pairable at the same time.  So even if the RFCOMM
case caused extra actions, it hardly fixes it.

> This essentially means pairing twice and that is still stupid, but might
> be what we should be doing. Or at least provide another hint to the
> L2CAP and RFCOMM channel's security to what we expect before allowing
> any connection. This is far fetching and utterly pointless if it would
> make break the GAP qualification.
>
> So I am curious to see a trace from a headset and a standard headset
> handles this. Or if they all just ignore the no bonding part.
>
> Johan, have a look at this. You looked this stuff more recently than I
> did.

Thanks,
Mike

--0016e6dd8d508d0e4f04be480a2d
Content-Type: application/zip; name="btheadset.zip"
Content-Disposition: attachment; filename="btheadset.zip"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h1cdifgk0

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
uWvhBDEva/rrdk1iRwS5DIOnsoNyuSCD2+OSdkqSyvqm2RRb1RRWib0y6TGtt3R4MreX2TD4yWgu
ar24FGmtLM1X9bciGr8pmaOzcCzPT0vG61Ukp7/xVcpSWYOjlXbsLDjYxRzspzlJ1WAA4TVHKusT
afj2O0CdWPenCOlHmM56he67576zy82v0GnP82fXXqHv/d7zZ5e3/EEKv/LZFxpe2Mszv/q1F86u
va8IEy8y9cav0NX/WjPY9BX68Xu+3wjE6W/p1sszybzU0Ogvz/VXH3ho+cqt5hSCIAiCIAiCIAjy
/491fyaIIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiC
IAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiC
IAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiC
IO+RhFIpayW5LNGcpGo0frImV2elsjZIk+XCEE3ksjSar2o1RaIJuSQNURodTx/NJA8eylExFArQ
fLlIR+JHx8dig3QLZzRSKtGMPD2jqTQjqZIyJxWHtmrge2C4hxCOGF/P/pWb2xPkDAU1DVaMy7zd
uAp9xvWmbkJe6DHudRXIr+H0i85P9ho+f9phCqBgM2/7jCIRvnZDl6lC3hvR/beklcq0kp/Vp5h6
y0ipJmmVijZDs8mDTaV0LnsLfFGw1iqFSolOyNIpSbmleYKqZmGfWxDd+wTvPrf7mCh6BY97qDCV
36op/3dc6M/dfIb+Pbey8/wfL8N1K3sEQZAPC9aC9mm7cX8Zz/br/u5mmxnb+cb+3dVW7w+2tZa/
2Ka3WNpA/5LLuNrI2t7ttRlxmI21tddffeAhtv5a9XiyPtZ6ze4f3H9dB1T4fE/XTl31D9c568AG
NREE+bBgI63gwez9w7VdB5yt5Xva9Fbu61tA2rDq+5r2jJW7Mif187V5XeSOn2k/Z3fW653WPfNr
h3LfuU/odqzM9Exm7U3tfHP7Bor3iNXvy838WHvfZ0y5tbdZ+brbvG6epYvz5Df9WnsjS4aVF+tq
7YdWHeYnUd/TGLt6/am6/andhGReOsvs3qn/GehvJtxTWdKeJ8f9SWK7LqHvuwiCIAiCIAiCIAiC
IB8EDtL087tfyxLOm9XLsvnD/1vN65curvpLTa/59xA7P6I/l8HxN64f1fFPmlePeb1iI8NfUg6a
1/5NrRDk/bHe7x7ejc2ioHx1oel3D+3lD5oPW7sfhrY83NQeq7yebDObd0v9HCHP9Rhf7M8no+Nj
ieTBw5lILjk+9i3o7oSkqHKlHPY7s3JRUsOHKqo2KAo6B6KVsqZUSiVJsUTOcUWelsv50pp1k5Xz
iFwuVk7lZK0khSdkRavlSzRblqemQBfLJMLRyuxsvlw8EImmDmSj4wfic1JZa/jc2CJblMbys1J4
vKBJmuqMKfKcpBzKq9FSRZWK4al8SZWcI6c1KSvfJoWDzqyWL5yI1LRKWFNqklEMC/OBKUEICn4f
tCU5Ec8cimTHj4zdNJrMxVIHw0KLNBuHDBli6zaZHR2PRVJthoeOgD6XHDuYbXYSjYxl4tmjY9E2
STwHAtZw408gE3JJgwEAWUQ9MSJNVRSJdUkuTzdHyeYiuexEMn6kWRhNjWfjMZDov8M7nI1nxiKj
cXZ+vrWiEParv3RmPHY4mqPJGPubl4NSWVLkAhXdQ+KQG74R9oc92eTBsUjucCbONhbRHQqEfP5g
QPAKbrcY8gq6HxY+mc0lo9nr4PQ1UmOjOQ75nypVToWFQfbhzFW0fEkfK/WIrM2MVdj8CHtA5R50
RsA4Py3BIB7W5FJYGBL8AdELyqYbQRCDpiTobb0BlSc06ExL+ROWC5iNQ8aEHGy6FYY8fr+3Vdai
9npDfrhpdpWTZyVVy89Ww1bvve5gyBP0+n3BwQ1FQV/I4wNfbsF7sZXfv7GIVdQbEfD6GomJTaUl
JSsVKuWimU8zq6ydzcqAEAx6dSdCKORze0NBYXA9megHccgret2hkMcviH4w8bjXlbl9F4XZOCV+
98U9c6/1TIQGBP3ugOciq4CwsYilxMNSwkauaa6sdRsmBpsbg0Ev+1wbvzULt8fjFQW/1xN0ez0C
eIcJs57MCyMYCIpCwO8NBuDDx3Tu0LoyH3Ttokib5GaLUTemi3+TRGyQG3O6hFoesrDf6xPdQUgG
dNAjiIN+n1vw+VjZJ/hCAdM4ocCqqYYDQTdoAqI4GAyJLJFQwTBgayZz5vH5vbozMRgIMR9sFFk5
CGM6CAvuVLRSK+trlQgrA6hE0RuApyvoZ/eCD1yzGP7AoIAfv8APZ7SmKDAjmhZXa7UzbyyL9lWm
qWabIpOHjVRTYBcSwiIdPS7DlrsmE9dkkipp7IloPAzmzgHXQSdhf7qSjmey42ORVDJ39ONQnFzn
fwMmzZ1p0jww6HtOIgObGU2OJcb1I9kOfTtj2ydd03wVNrvIXFGrRmeGhAPzB/aJYWcsr+WDgrsq
iiBKKFJRl6bc0SHRcwAuejFdUbSIqsrTZfafLypYJtM3hT0iZZ8C9fiou8BuAkHqCVC/XxcanwH9
u5sKebpm79/K3tdqH9jK3ttqH9rK3sPsBYGu07NcNB2G9m7WJ68ZhMX0MWebW/qN1gXZ/RY+g1Y/
POx+C7fuJuNNemwYi1ZrLfn69iHrxq/b+/XcF/WbzdsjWoNshVjfOMjMjHtm7H3X9u6NR+xw7AMa
sfc0Du8jVYb/TSa34d9jGfvZdxbCuHdvVdHflGOPGW7DNAumzS9iDDNThSH/gcyUvrjk3cUqjGJ+
rqoXa+rxY7BK1phMhYsu1F/F4MSejKTo2OHRkXjmShDERCEac3u8QtTjicciiZAYgf04FhLccbYP
R0MjTS92xpvq/wJQSwECFAsUAAAACACqY5ZAwEB1QDosAABnTwIADAAAAAAAAAABACAAAAAAAAAA
cGFpcmluZy5odG1sUEsBAhQLFAAAAAgAMlSWQKpO792QEQAAGzgBABgAAAAAAAAAAAAgAAAAZCwA
AFRDX0lDQV9CVl8wMV9QYWlyaW5nLmNmYVBLBQYAAAAAAgACAIAAAAAqPgAAAAA=
--0016e6dd8d508d0e4f04be480a2d--
