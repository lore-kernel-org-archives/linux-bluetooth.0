Return-Path: <cyrus@holtmann.org>
Message-ID: <013e01c8bb99$b4ba5580$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Marcel Holtmann" <marcel@holtmann.org>,
	"Johan Hedberg" <johan.hedberg@gmail.com>
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Issues with BlueZ v3.31 Object Path Naming
Date: Wed, 21 May 2008 18:23:37 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_013B_01C8BB6F.C9229570"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_013B_01C8BB6F.C9229570
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have not been chiming in for several weeks, because I have been busy =
hacking through code to figure out how bluez is supposed to work, how it =
actually works, and issues and incompatibilitites I am struggling with =
between bluez (DBus, v3.31) and the CSR BlueLab libraries (v4.0, =
compatible with BT2.1).; What fun.

In working with my test application, talking with bluez, I have run into =
the following and need clarification before proceeding:
  1.. What is the path name for the top level Manager interface?  Is it =
going to be "/org/bluez"? Or is it supposed to be "/"?=20
    If you call the DefaultAdapter method with the "/org/bluez" path, it =
is resolved to call old_default_adapter in hcid/manager.c, returning a =
String representing the old Default Adapter path, or "/org/bluez/hci0"?=20

    On the other hand, call the DefaultAdapter method with the "/" path, =
it is resolved to call default_adapter in hcid/manager.c, returning an =
Object (actually a string representing an object path), representing the =
NEW Default Adapter path: "/hci0".  However, when returning the Object, =
it also throws an error because, somehow, /hci0 was never registered.  =
(Unregistered object at path '/hci0'). Very bad result.=20

    So, what should it be?  /org/bluez and /org/bluez/hci0?  Or / and =
/hci0?=20

    And, while we are at it, should we clean up the documentation in =
docs/manager-api.txt and docs/adapter-api.txt?  Both refer to the "old" =
paths.  Let me know and I will be happy to "dive in".=20

  2.. For what it is worth, the "new" and experimental Adapter methods =
ARE registered with path "/hci0", despite the apparent fact that no =
object '/hci0' is registered...=20
  3.. I had been confused about opening an audio.Control device as =
opposed to (or in addition to, or in sequence with) a device under =
org.bluez.Adapter, using CreateDevice and CreatePairedDevice.  When I =
did get things to "work", sort of, CreateDevice would return a device =
path name like "/hci0/dev_xx_xx_xx_xx_xx_xx", but on return would fail =
with the same "Unregistered object at path" error as above.=20
  4.. Along the lines of the last item, it does appear that one must =
pair, then one must create an audio "device" using the =
org.bluez.audio.Manager CreateDevice method (with path =
/org/bluez/audio).  Am I correct in this understanding?=20
  5.. Yet another question: is the "/org/bluez/audio" path correct, or =
will it be changed in the future?  When I have used this method, it =
returns a device path of "/org/bluez/audio/device0".  It is interesting =
(and perhaps a bit strange) to use the device address, as opposed to the =
device path, to create this pseudo-device to provide the audio services =
(Device, Headset, Gateway, Sink, Source, Control).
I can quickly submit patches to unify the naming, etc., if you will tell =
me your current thinking and roadmap in this area.  However, I do not =
want to waste my time hacking if you are going in some other direction.

David Stockwell
------=_NextPart_000_013B_01C8BB6F.C9229570
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff><FONT face=3DArial size=3D2>
<DIV>I have not been chiming in for several weeks, because I have been =
busy=20
hacking through code to figure out how bluez is supposed to work, how it =

actually works, and issues and incompatibilitites I am struggling with =
between=20
bluez (DBus, v3.31) and the CSR BlueLab libraries (v4.0, compatible with =

BT2.1).; What fun.</DIV>
<DIV>&nbsp;</DIV>
<DIV>In working with my test application, talking with bluez, I have run =
into=20
the following and need clarification before proceeding:</DIV>
<OL>
  <LI>What is the path name for the top level Manager interface?&nbsp; =
Is it=20
  going to be "/org/bluez"? Or is it supposed to be "/"?=20
  <BLOCKQUOTE dir=3Dltr style=3D"MARGIN-RIGHT: 0px">
    <P>If you call the DefaultAdapter method with the "/org/bluez" path, =
it is=20
    resolved to call old_default_adapter in hcid/manager.c, returning a =
String=20
    representing the old Default Adapter path, or "/org/bluez/hci0"?=20
    <P>On the other hand, call the DefaultAdapter method with the "/" =
path, it=20
    is resolved to call default_adapter in hcid/manager.c, returning an =
Object=20
    (actually a string representing an object path), representing the =
NEW=20
    Default Adapter path: "/hci0".&nbsp; However, when returning the =
Object, it=20
    also throws an error because, somehow, /hci0 was never =
registered.&nbsp;=20
    (Unregistered object at path '/hci0'). Very bad result.=20
    <P>So, what should it be?&nbsp; /org/bluez and =
/org/bluez/hci0?&nbsp; Or /=20
    and /hci0?=20
    <P>And, while we are at it, should we clean up the documentation in=20
    docs/manager-api.txt and docs/adapter-api.txt?&nbsp; Both refer to =
the "old"=20
    paths.&nbsp; Let me know and I will be happy to "dive in". =
</P></BLOCKQUOTE>
  <LI>For what it is worth, the "new" and experimental Adapter methods =
ARE=20
  registered with path "/hci0", despite the apparent fact that no object =
'/hci0'=20
  is registered...=20
  <LI>I had been confused about opening an audio.Control device as =
opposed to=20
  (or in addition to, or in sequence with) a device under =
org.bluez.Adapter,=20
  using CreateDevice and CreatePairedDevice.&nbsp; When I did get things =
to=20
  "work", sort of, CreateDevice would return a device path name like=20
  "/hci0/dev_xx_xx_xx_xx_xx_xx", but on return would fail with the same=20
  "Unregistered object at path" error as above.=20
  <LI>Along the lines of the last item, it does appear that one must =
pair, then=20
  one must create an audio "device" using the=20
  org.bluez.audio.Manager&nbsp;CreateDevice method (with path=20
  /org/bluez/audio).&nbsp; Am I correct in this understanding?=20
  <LI>Yet another question: is&nbsp;the "/org/bluez/audio" =
path&nbsp;correct, or=20
  will it be changed in the future?&nbsp; When I have used this method, =
it=20
  returns a device path of "/org/bluez/audio/device0".&nbsp; It is =
interesting=20
  (and perhaps a bit strange) to use the device address, as opposed to =
the=20
  device path, to create this pseudo-device to provide the audio =
services=20
  (Device, Headset, Gateway, Sink, Source, Control).</LI></OL>
<DIV>I can quickly submit patches to unify the naming, etc.,&nbsp;if you =
will=20
tell me your current thinking and roadmap in this area.&nbsp; However, I =
do not=20
want to waste my time hacking if you are going in some other =
direction.</DIV>
<DIV>&nbsp;</DIV>
<DIV>David Stockwell</DIV></FONT></BODY></HTML>

------=_NextPart_000_013B_01C8BB6F.C9229570--
