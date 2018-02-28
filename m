Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Stotland, Inga" <inga.stotland@intel.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/1 v2] Add initial doc describing Bluetooth Mesh
 API
Date: Wed, 28 Feb 2018 20:17:18 +0000
Message-ID: <1519849036.4140.27.camel@intel.com>
References: <20180218064819.23459-1-inga.stotland@intel.com>
         <20180218064819.23459-2-inga.stotland@intel.com>
         <7EA4BC6E-29F5-440E-9D61-0EECE796AB6E@holtmann.org>
In-Reply-To: <7EA4BC6E-29F5-440E-9D61-0EECE796AB6E@holtmann.org>
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-tAE05WnoTf623X3S4XXX"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-tAE05WnoTf623X3S4XXX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Mon, 2018-02-26 at 14:49 +0100, Marcel Holtmann wrote:
> Hi Inga,
>=20
> > ---
> > doc/mesh-api.txt | 269
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 269 insertions(+)
> > create mode 100644 doc/mesh-api.txt
> >=20
> > diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
> > new file mode 100644
> > index 000000000..87311faba
> > --- /dev/null
> > +++ b/doc/mesh-api.txt
> > @@ -0,0 +1,269 @@
> > +Bluetooth Mesh Socket API
> > +*************************
> > +
> > +Copyright (C) 2018 Intel Corporation. All rights reserved.
> > +
> > +This document decribes the data format that is used for
> > communication with
> > +the kernel via Bluetooth Mesh socket. The data that are passed
> > over this
> > +type of a socket is specific to Bluetooth Mesh Profile.
> > +
> > +The Bluetooth Mesh socket is implemented as part of PF_BLUETOOTH
> > family
> > +and can be created by opening a raw HCI socket with hci_channel
> > set to
> > +HCI_CHANNEL_BTMESH. The mesh socket requires the creating process
> > to have
>=20
> call this HCI_CHANNEL_MESH. There is no point in adding BT* here.
>=20
> > +CAP_NET_ADMIN capability.
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > +Packet Structure: user space to/from kernel (Tx/Rx)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > +
> > +Each packet to or from the Over-the-Air interface is sent between
> > the user
> > +space and the kernel must be of nonzero length, and start with the
> > AD_Type,
> > +followed by a variable amount of additional payload.
> > +
> > +	0               8
> > +	+---------------+------------------------------------
> > +	|  AD_Type      | Mesh Packet
> > +	+---------------+=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94
> > +
>=20
> Actually I would have really preferred that we followed the Proxy PDU
> format.
>=20
> 	2 Bits reserved
> 	6 Bits packet type
> 	Variable data payload
>=20
> I think that we really need the 0x02 type for configuration between
> the kernel and userspace.

The idea is to allow the data payload to be identical to the mesh
message that would go over the air. Hence, everything that is not part
of the actual mesh message ends up in either cmsg or sockopt.
Introducing 0x2 "configuration" type will break this paradigm since the
configuration for mesh does not map directly to configuration for
Proxy.=20


> > +AD_Type (1 octet -- Defined by the Bluetooth SIG)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Provisioning:	0x29 -	The payload contains a Mesh
> > Provisioning message
> > +Network:		0x2A -	The payload contains a Mesh
> > Data Packet
> > +Beacon:		0x2B -	The payload contains a Mesh
> > Beacon
> > +
> > +The AD_Type values correspond to AD types introduced in Mesh
> > Profile
> > +specification. The API is designed to support additional types.
> > +
> > +
> > +A packet with empty (Zero-Length) payload may be sent over the
> > socket in case
> > +when only Control ancillary data is needed (e.g., Flush or Scan,
> > defined below).
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Socket Options
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +HCI Mesh Scan Filter
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +	Code:	0x05
> > +
> > +	Filter_Id		(1 octet)
> > +	Duplicates		(1 octet)
> > +	Filter			(variable length)
> > +
> > +Read/write socket option used to setup scan filters for mesh
> > specific packets.
> > +First octet of filter must include at least the AD_Type but may be
> > longer to
> > +include NIDs or other known data.
>=20
> These ones look more like type 0x02 PDU packets. And this in
> particular I would have done as Add Network ID and Remove Network ID
> and let the kernel deal with deciding if it chooses a more global
> filter (since not enough filters are available) or if it can be more
> precise with the filtering.
>=20

This is a once in awhile operation, so It felt like socket option seems
like a better place for it. It could be made more user friendly at the
expense of losing flexibility in future of adding filtering on
additional AD Types.

> > +
> > +HCI Mesh Default Tx Power
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +	Code:	0x06
> > +
> > +	Tx_Power		(1 octet)
> > +
> > +Read/write socket option for setting default Tx power.
>=20
> Leave this out for now. I assume initially we will always use 127 for
> do not care. If we think it is valuable for testing, then via
> debugfs.
>=20

I agree. No use for this at the moment.

> > +
> > +HCI Mesh Default Cahnnel Map
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > +	Code:	0x07
> > +
> > +	Chan_map		(1 octet)
> > +
> > +Read/write socket option for setting default channel map.
>=20
> Also irrelevant and only for fine tuning and testing. Can be exposed
> via debugfs.
>=20

Agreed.

> > +
> > +HCI Mesh Accuracy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +	Code:	0x08
> > +
> > +	Accuracy		(1 octet)
> > +
> > +Read-only socket option to obtain the value of the smallest number
> > of
> > +milliseconds that a Mesh Friendship Offer Window can be, for
> > guaranteed
> > +Poll Response transmission within that window.
>=20
> I still would have done this via type 0x02 and a PDU exchange
> protocol. Mainly because then it also becomes traceable via btmon. So
> yes, I want the mesh channel also be included in btmon.
>=20
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Tx Ancillary Data
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The information about which timing settings to use when sending a
> > mesh
> > +packet is contained in mandatory ancillary data accompanying the
> > +payload. Exactly one of the following (mutually exclusive)
> > ancillary
> > +data types must be present with nonzero length Tx payload:
> > +
> > +Mesh Transmit Info
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +cmsg_level     cmsg_type             cmsg_data[]
> > +--------------------------------------------------
> > +SOL_BLUETOOTH  BTMESH_TX_INFO        Parameters
>=20
> General format we started using is BT_* and so this should be
> BT_MESH_*
>=20
> > +
> > +	Code:	0x01
> > +	Parameters:
> > +		Count			(1 octet)
> > +		Interval:		(2 octets)
> > +		Min_Random_Delay:	(1 octet)
> > +		Max_Random_Delay:	(1 octet)
> > +
> > +The retransmission parameters for a regular outgoing mesh message.
> > +
> > +Count is the total number of times to Tx. A Zero means Tx Until
> > Canceled.
> > +
> > +Interval is the number of milliseconds between each Tx.
> > +
> > +Random Delay is milliseconds added before first Tx.
> > +
> > +Mesh Poll Transmit Info
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +cmsg_level     cmsg_type              cmsg_data[]
> > +---------------------------------------------------
> > +SOL_BLUETOOTH  BTMESH_POLL_TX_INFO    Parameters
> > +
> > +	Code:	0x02
> > +	Parameters:
> > +		Scan_Delay		(1 octet)
> > +		Scan_Duration		(1 octet)
> > +		Filter_Ids[2]		(2 octets)
> > +		Min_Random_Delay:	(1 octet)
> > +		Max_Random_Delay:	(1 octet)
> > +
> > +Scan_Delay describes the wait period to begin scanning after the
> > Poll message
> > +is sent.
> > +
> > +Filter_Ids contain IDs of two filters that account for two
> > possible values of
> > +IV Update bit in expected Poll response.
> > +
> > +Random Delay is milliseconds added before Tx.
> > +
> > +Mesh Poll Response Transmit Info
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +cmsg_level     cmsg_type                cmsg_data[]
> > +-----------------------------------------------------
> > +SOL_BLUETOOTH  BTMESH_POLL_RSP_TX_INFO  Parameters
> > +
> > +	Code:	0x03
> > +	Parameters:
> > +		Instant		(4 octets)
> > +		Delay		(1 octet)
> > +
> > +The timing parameters for sending a friend poll response.
> > +
> > +Instant is a 4-octet opaque value that corresponds to the instant
> > an
> > +associated incoming mesh message was recieved, for timing
> > purposes.
> > +
> > +Delay defines number of milliseconds after the corresponding
> > Instant
> > +to wait before sending this Tx.
> > +
> > +__________________________________________________________________
> > __
> > +
> > +The following ancillary types are optional with nonzero length Tx
> > payload:
> > +
> > +Transmit Power
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +cmsg_level     cmsg_type             cmsg_data[]
> > +---------------------------------------------------------------
> > +SOL_BLUETOOTH  BTMESH_TX_POWER_INFO  Parameters
> > +
> > +	Code:	0x04
> > +	Parameters:
> > +		Tx_Power	(1 octet)
> > +
> > +Transmit power setting can be used for finer control on the
> > outbound messages.
> > +If not present, use default value (builtin or configured as socket
> > options).
> > +
> > +Transmit Channel
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +cmsg_level     cmsg_type               cmsg_data[]
> > +---------------------------------------------------------------
> > +SOL_BLUETOOTH  BTMESH_TX_CHANNEL_INFO  Parameters
> > +
> > +	Code:	0x05
> > +	Parameters:
> > +		Tx_Channel	(1 octet)
> > +
> > +The presence of this option specifies transmit channel and allows
> > +for better control, e.g., to respond on the same
> > +channel as the one on which incoming message has been received.
> > +If not present, the default value will be used (builtin or
> > configured as
> > +socket options).
>=20
> Don=E2=80=99t bother with these two at the moment. I think they have no u=
se
> for us except for allowing some testing via debugfs. They needed to
> be in the HCI spec for completeness and because you can also use the
> HCI spec to build a mesh sniffer.
>=20
> > +
> > +
> > +Additional the ancillary data portion may contain Control type
> > information.
> > +
> > +The following are Control ancillary data types, that me be sent
> > with or
> > +without payloads:
> > +
> > +Scan
> > +=3D=3D=3D=3D=3D=3D=3D
> > +cmsg_level     cmsg_type             cmsg_data[]
> > +---------------------------------------------------------------
> > +SOL_BLUETOOTH  BTMESH_SCAN           Parameters
> > +
> > +	Code:	0x06
> > +	Parameters:
> > +		Filter_Ids[]	(variable)
> > +
> > +To enable/disable scanning of Mesh packets.
> > +
> > +If Filter_Ids array is nonzero length, start scanning with the
> > specified
> > +filters (filters are initialized via socket options mechanism).
> > This array
> > +replaces any prior filters.
> > +
> > +If no filter IDs are present (i.e., zero array length), stop
> > scanning.
>=20
> I dislike this. We should have a type 0x02 command that tells us what
> kind of role we are operating in. And based on that scanning is
> enabled by binding the socket and closing it. Or changing the role.
> The whole filter id exposure seems a bit odd to me. I realize that
> this might look simple, but a few things should be done by the
> kernel. And managing the scanning filters is one of them. So we need
> to feed the kernel enough details that it can do that efficiently.
> Swapping filters around from userspace is painful.
>=20

Adding filters should remain dynamic, e.g., when a new network key is
added (or looking forward, new AD Type).=20

> Otherwise we could just expose HCI_CHANNEL_MESH as HCI mesh commands.
> They are all multiplexed via a single opcode anyway and have a single
> event with and event prefix. So if you want this detailed control of
> the HCI commands, then don=E2=80=99t try to put too much kernel in betwee=
n.
> Just do path through of them.
>=20
> We could do just that and then leave the kernel portion for this
> alone. Maybe it is worth while to debate pros and cons for this. It
> is actually not the worst idea to give exclusive access to the mesh
> commands. It would be similar to HCI_CHANNEL_USER, but only for the
> mesh commands and we would strip the HCI command header and HCI event
> header + event prefix off it so that you just have to deal with mesh
> opcode and mesh subevent code.
>=20
> Hmmm .. it gets a bit tricky for the command complete portion of it.
> So it might have to be the full HCI anyway, but restricted to one
> opcode and only matching events being forwarded.
>=20
> Actually if I spin my train of thoughts further now, we might want to
> put HCI_CHANNEL_MESH on ice and leave that for some future version. I
> think providing some sort of abstraction and automatic handling of
> scanning filters etc. is a good abstraction for the kernel, but it
> might be something that will take a while to be defined and working
> correctly. Doing the HCI mesh commands directly on a socket has the
> command complete problem as stated above and having yet another
> variation of HCI_CHANNEL_RAW with mesh HCI filters seems wrong as
> well. Especially since eventually I want to have an option to disable
> HCI_CHANNEL_RAW. In addition it would have been exclusive access to
> make sure nothing goes wrong.
>=20
> So maybe we just expose HCI mesh commands as MGMT command and MGMT
> event.
>=20
> Mesh Command
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 	Command Code:		0x0043
> 	Controller Index:	<controller index>
> 	Command Parameters:	Opcode (1 Octet)
> 				Command parameters (Variable)
> 	Return Parameters:	Status (1 Octet)
> 				Opcode (1 Octet)
> 				Return parameters (Variable)
>=20
> Mesh Event
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 	Event Code:		0x0026
> 	Controller Index:	<controller index>
> 	Event Parameters:	Subevent (1 Octet)
> 				Even parameters (variable)
>=20
> This would map 1:1 to the HCI mesh commands and events with the tiny
> modification that the event prefix is stripped from the Mesh Event
> and not provided and with the Mesh Get Options command issued it
> would be mapped to event prefix length of zero.
>=20
> And then only a settings 16 Mesh would be needed. Or we make the
> command and event only available when HCI mesh commands are actually
> supported. That is something that would needs to be discussing. In
> general, we have not had limited commands based on hardware
> functionality, but these two would be special since they are vendor
> specific commands in the first place.
>=20
> For the kernel side we only have the the driver provide the mesh HCI
> opcode and run Mesh Get Options once to retrieve the firmwares event
> prefix so that it can be zeroed out by the MGMT commands and events.
>=20
> With that comments? Thoughts?

Well, while this approach could work. The advantage is the access to
command complete and comand status events. But then having an
independent mesh daemon (also ell based) may become problematic.
Also, putting actual mesh access layer messages via management socket
is a bit questionable: my understanding is that mgmt socket is mainly
for control and configuration messsages.

>=20
> Regards
>=20
> Marcel
>=20
--=-tAE05WnoTf623X3S4XXX
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
Zg5mBVQoBK5apmk2/QnKNb/XBUyu62quyTXRahXz2KXRqznXj++7MiP2dYTRzC1XMK1lAgMBAAGj
ggIxMIICLTAdBgNVHQ4EFgQUzeWQY29S+1e6mTvizPBEGBE3JGUwHwYDVR0jBBgwFoAU2kEjnFqP
ca9Xgz4g0+Nl2wzLC9swZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5jb20vcmVw
b3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwNEIu
Y3JsMIGfBggrBgEFBQcBAQSBkjCBjzAiBggrBgEFBQcwAYYWaHR0cDovL29jc3AuaW50ZWwuY29t
LzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0
ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwNEIuY3J0MAsGA1Ud
DwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9TgpHACWeB
3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsGAQQBgjcV
CgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBLBgNVHREERDBCoCcGCisGAQQBgjcUAgOg
GQwXaW5nYS5zdG90bGFuZEBpbnRlbC5jb22BF2luZ2Euc3RvdGxhbmRAaW50ZWwuY29tMA0GCSqG
SIb3DQEBBQUAA4IBAQCoG+97GZuQEwQnuWIVQWcpVw1Ym/kJEGjRAiB8JMflkvaemGuUV/xS2ccg
o4V80bU6Ee3jhFp3DH8aiO068JigsTZRDt172E7E/p187o2M6FicC63aUgWW/FZfEaOXuky/8jdz
9oaWcDIwFm+L6vpSQrE5Wbk5sCX04SvRlJ6X/+KAWJGE5sU9lA4XB0yJapCCoVyNZln3H3PdSXC2
rdOl2HSUdGOvmIwNkaSLLaVgUjz6mFzzRi/64tOfROIQSEdBYNStKYCixc2KP/sWL6LtfW+sQVLZ
r+HHDskuWTuEbYxFinLxC1gayzk80cz9z4qMg5bQJWyClLIwh4qpnUpoMYICFzCCAhMCAQEwgZAw
eTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UE
ChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3Vp
bmcgQ0EgNEICEzMAAE9zKgiM3IZosrQAAAAAT3MwCQYFKw4DAhoFAKBdMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDIyODIwMTcxNlowIwYJKoZIhvcNAQkEMRYE
FHv3no7C611+RtZHLjlDLhi0XvyqMA0GCSqGSIb3DQEBAQUABIIBAMJeT5kWghKaqtsYhHp8qT6v
0RAGC2beu5jdK0GmAOv9i4yfBjeS1d3wOIwlxYXCy5F4VfFMmc4ZpSKWN6Yciza5+1Nmgi40NTGy
W1obz6jhgdk/RKyu5IGOyx+3tGlGFpIUM1dz6hqG71Wx2Lju4vE6DHfmFN6RiXRC4mRkvDjt6iYr
M5Y87PZXvCB8lnLq/UJzUt2W48nLeYTl0l1LUnOFmk4KQqRUyfb0hP8RAFVlrRgdUq7ffAX6xeCg
BXNbi9K1XG0EVqcalKi7G41bQ6tNUkjGH44SRI4xg/rnd7ijDQ5s7QjpTmilf5dXNG1YnZdzDvgF
+zf+a8Ous9SgsO0AAAAAAAA=


--=-tAE05WnoTf623X3S4XXX--
