Return-Path: <cyrus@holtmann.org>
Message-ID: <027501c8bdbe$40af10f0$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
	"Johan Hedberg" <johan.hedberg@gmail.com>
Subject: Proposed/revised API for org.bluez.audio.control (AVRCP)
Date: Sat, 24 May 2008 11:50:16 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0271_01C8BD94.555EE130"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_0271_01C8BD94.555EE130
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0272_01C8BD94.555EE130"


------=_NextPart_001_0272_01C8BD94.555EE130
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have revised and updated the AVRCP API proposal, submitted in March.

I agree that the previous version was too complicated, and have =
encapsulated everything having to do with UnitInfo and SubUnitInfo into =
the internals (most of those elements are fixed anyway, and can be set =
in the audio.conf file).

With regards to the rest, I propose to provide two ways to handle =
Passthrough messages received; by uinput for integration with GStreamer =
and the like, and by signal, which will pass not only the keystroke =
itself, but the vendor dependent data allowed for in the spec (AVRCP =
with Metadata Transfer, published by the BT SIG).

I propose to handle Metadata as a sub-class or specialization of =
VendorDependent, without taking away the ability to create one's own =
VendorDependent messages.  I am thinking that to send a batch of =
Metadata, one would create it as a string-variant dict, with the string =
being a key to identify what the thing to be transmitted is (and hence =
how to interpret/translate it, per the spec).  The internal plumbing =
will take care of batching all of it into a VendorDependent and shipping =
it off.

With respect to handling basic Passthrough and Metadata, this should =
cover it, and provide very good functionality for most applications.

The spec also provides for numerous events and responses; I am still =
reviewing them to see how or if these can or should be implemented.  It =
does appear that some of these would require a greater level of =
integration with the overall "playing" application to handle these =
within this module, which IMHO is not a good idea.

David Stockwell
------=_NextPart_001_0272_01C8BD94.555EE130
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD><FONT face=3DArial><FONT size=3D2>
<BODY>
<DIV>I have revised and updated the AVRCP API proposal, submitted in=20
March.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I agree that the previous version was too complicated, and have=20
encapsulated everything having to do with UnitInfo and SubUnitInfo into =
the=20
internals (most of those elements are fixed anyway, and can be set in =
the=20
audio.conf file).</DIV>
<DIV>&nbsp;</DIV>
<DIV>With regards to the rest, I propose to provide two ways to handle=20
Passthrough messages received; by uinput for integration with GStreamer =
and the=20
like, and by signal, which will pass not only the keystroke itself, but =
the=20
vendor dependent data allowed for in the spec (AVRCP with Metadata =
Transfer,=20
published by the BT SIG).</DIV>
<DIV>&nbsp;</DIV>
<DIV>I propose to handle Metadata as a sub-class or specialization of=20
VendorDependent, without taking away the ability to create one's own=20
VendorDependent messages.&nbsp; I am thinking that to send a batch of =
Metadata,=20
one would create it as a string-variant dict, with the string being a =
key to=20
identify what the thing to be transmitted is (and hence how to=20
interpret/translate it, per the spec).&nbsp; The internal plumbing will =
take=20
care of batching all of it into a VendorDependent and shipping it =
off.</DIV>
<DIV>&nbsp;</DIV>
<DIV>With respect to handling basic Passthrough and Metadata, this =
should cover=20
it, and provide very good functionality for most applications.</DIV>
<DIV>&nbsp;</DIV>
<DIV>The spec also provides for numerous events and responses; I am =
still=20
reviewing them to see how or if these can or should be =
implemented.&nbsp; It=20
does appear that some of these would require a greater level of =
integration with=20
the overall "playing" application to handle these within this module, =
which IMHO=20
is not a good idea.</DIV>
<DIV>&nbsp;</DIV>
<DIV>David Stockwell</DIV></BODY></HTML></FONT></FONT>

------=_NextPart_001_0272_01C8BD94.555EE130--

------=_NextPart_000_0271_01C8BD94.555EE130
Content-Type: text/plain;
	name="avrcp-api-v0.1.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="avrcp-api-v0.1.txt"

org.bluez.audio.Control interface

This interface is available for remote devices which implement support =
for an
AVRCP controller and target.

Object path(s)	/org/bluez/audio/device*

Methods:
	dict	GetProperties()
		GHashTable with named properties and variant values.

	boolean IsConnected()
		Returns TRUE if connected with the remote device.

	void	ConnectResponse(boolean response)
		Respond to ConnectedRequested from remote device.
		Respond TRUE if granting connection request.

	void	Disconnect()
		Disconnect from remote device.

	boolean SendPassthrough(avc_operation_id key, boolean state,
			uint16 sizeof_op_data, const void * op_data)
		Called to send Passthrough commands.

	boolean SendVendorDependent(uint16 sizeof_op_data, const void * =
op_data)
		Called to send VendorDependent commands, other than Metadata.

	void *	FetchVendorDependent(uint16 sizeof_op_data)
		Called to retrieve VendorDependent commands, other than Metadata.

	void	SendMetadata(uint8 pdu_id, dict meta_data)
		Called to send Metadata commands (a subset of the
		VendorDependent message). Multiple key/element pairs.

Signals:
		Connected()
		Sent when a successful connection has been made to the remote device.

		Disconnected()
		Sent when a connection to the remote device has been disconnected.

		ConnectRequested(string address)
		Sent when a remote device wishes to connect.  Return value is BT =
address
		of connecting device (might be Device path instead...)

		DisconnectRequested()
		Sent when a connected remote device wishes to disconnect.

		PassthroughReceived(avc_operation_id key, boolean state,
			uint16 sizeof_op_data, const void * op_data)
		Called when Passthrough command is received from connected device.

		VendorDependentReceived(uint16 sizeof_op_data, const void * op_data)
		Called when VendorDependent message is received from connected device
		(except for Metadata).

		MetadataReceived(dict metadata)
		Called when Metadata is received from connected device.  May be =
multiple
		meta attribute/element pairs.

Properties:
	string	Address [readonly]
		Bluetooth Device Address of the connected device.

	string	Name [readonly]
		The Bluetooth "friendly name" from the connected device.

	uint8	SubUnitID [readonly]
		The three-bit Subunit ID from the connected device (per the spec).

	uint8	SubUnitType [readonly]
		The five-bit Subunit Type from the connected device (per the spec).

	array{uint} CompanyIDs [readonly]
		List of three-byte Company IDs (OUI) from the connected device.

	array{uint8} Capabilities [readonly]
		List of Capabilities provided by the connected device.

Note that many of the items supporting AVRCP and the Metadata Extension =
are essentially
fixed from the standpoint of the application running in the Linux box.  =
To simplify the
API, these are best handled by setting them up statically in the =
audio.conf file.

A list of these attributes and possible settings will be submitted in =
the very near future.
------=_NextPart_000_0271_01C8BD94.555EE130
Content-Type: application/octet-stream;
	name="audio.conf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="audio.conf"

# Configuration file for the audio service

# This section contains options which are not specific to any
# particular interface
[General]

# Switch to master role for incoming connections (defaults to true)
#Master=3Dtrue

# If we want to disable support for specific services
# Defaults to supporting all implemented services
#Disable=3DControl,Source
Disable=3DHeadset,Gateway,Sink,Source
Enable=3DControl

# SCO routing. Either PCM or HCI (in which case audio is routed to/from =
ALSA)
# Defaults to HCI
#SCORouting=3DPCM

# Headset interface specific options (i.e. options which affect how the =
audio
# service interacts with remote headset devices)
[Headset]

# Set to true to support HFP (in addition to HSP only which is the =
default)
# Defaults to false
HFP=3Dfalse

# HFP Gateway features
# Defaults to false
3WayCalling=3Dfalse
EchoCancelNoiseCancel=3Dfalse
VoiceRecognition=3Dfalse
InBandRingtone=3Dfalse
VoiceTags=3Dfalse
RejectingCalls=3Dfalse
EnhancedCallStatus=3Dfalse
EnhancedCallControl=3Dfalse
ExtendedErrorResultCodes=3Dfalse

# Just an example of potential config options for the other interfaces
#[A2DP]
#SBCSources=3D1
#MPEG12Sources=3D0

# Configuration for Control/AVRCP Implementation
[Control]
Role=3DTarget  # Role of Bluez server.  Other options: Controller, Both
Company=3DFFFFFF # For Metadata transfer, BT SIG 001958 is =
assumed/standard
SubunitID=3D0
SubunitType=3D9
PassthroughUinput=3Dfalse
PassthroughSignal=3Dtrue
EnableMetadata=3Dtrue
#

------=_NextPart_000_0271_01C8BD94.555EE130--
