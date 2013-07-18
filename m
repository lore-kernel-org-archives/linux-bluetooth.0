Return-Path: <cyrus@holtmann.org>
From: Ruben Jenster <rjenster@gmail.com>
Content-Type: multipart/mixed; boundary="Apple-Mail=_21BF328A-0DE8-43ED-ACBE-3437F2F9A1AF"
Subject: AVRCP(-CT): Fixed volume control for devices in controller mode.
Message-Id: <C1D70CB9-F9E5-494A-BF0E-C8D76F5302F5@gmail.com>
Date: Thu, 18 Jul 2013 19:54:30 +0200
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_21BF328A-0DE8-43ED-ACBE-3437F2F9A1AF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

AVRCP volume control is currently not working with bluez5 (master =
branch) when the device is in controller mode.
I saw the following output when pressing the volume keys on my iPhone:

profiles/audio/avrcp.c:handle_vendordep_pdu() AVRCP PDU 0x50, company =
0x001958 len 0x0100

I looked at the source and noticed that the event registration for the =
volume changed event is done differently=20
when the device is in target or controller mode. Volume control works =
when using the method used for devices in target mode.

See the patch attached. Please fix this in the next release!


Cheers,
Ruben


--Apple-Mail=_21BF328A-0DE8-43ED-ACBE-3437F2F9A1AF
Content-Disposition: attachment;
	filename=0001-AVRCP-CT-Fixed-event-handling-for-AVRCP_EVENT_VOLUME.patch
Content-Type: application/octet-stream;
	name="0001-AVRCP-CT-Fixed-event-handling-for-AVRCP_EVENT_VOLUME.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20a614d65cacab8eefd8c2d8f995aed481e375ba42=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Ruben=20Jenster=20<r.jenster@drachenfels.de>=0A=
Date:=20Thu,=2018=20Jul=202013=2019:31:37=20+0200=0ASubject:=20[PATCH]=20=
AVRCP(-CT):=20Fixed=20event=20handling=20for=0A=20=
AVRCP_EVENT_VOLUME_CHANGED.=0A=0AUse=20('avrcp_register_notification')=20=
to=20register=20the=20volume=0Achanged=20event=20in=20the=20AVRCP=20=
controller=20initialization=20method.=0A(similar=20to=20the=20AVRCP=20=
target=20initialization=20method).=0AThis=20makes=20the=20volume=20=
control=20working=20with=20my=20iPhone.=0A---=0A=20=
profiles/audio/avrcp.c=20|=205=20+++--=0A=201=20file=20changed,=203=20=
insertions(+),=202=20deletions(-)=0A=0Adiff=20--git=20=
a/profiles/audio/avrcp.c=20b/profiles/audio/avrcp.c=0Aindex=20=
cd0a736..714966a=20100644=0A---=20a/profiles/audio/avrcp.c=0A+++=20=
b/profiles/audio/avrcp.c=0A@@=20-3341,8=20+3341,9=20@@=20static=20void=20=
session_ct_init_control(struct=20avrcp=20*session)=0A=20=09=09=09=09=09=09=
=09handle_vendordep_pdu,=0A=20=09=09=09=09=09=09=09session);=0A=20=09=
session->control_handlers=20=3D=20ct_control_handlers;=0A-=09if=20=
(session->version=20>=3D=200x0104)=0A-=09=09session->supported_events=20=
=3D=20(1=20<<=20AVRCP_EVENT_VOLUME_CHANGED);=0A+=20=20=20=20if=20=
(session->version=20>=3D=200x0104)=0A+=20=20=20=20=20=20=20=20=
avrcp_register_notification(session,=0A+=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20AVRCP_EVENT_VOLUME_CHANGED);=0A=20=
=0A=20=09service=20=3D=20btd_device_get_service(session->dev,=20=
AVRCP_TARGET_UUID);=0A=20=09if=20(service=20!=3D=20NULL)=0A--=20=0A=
1.8.2.1=0A=0A=

--Apple-Mail=_21BF328A-0DE8-43ED-ACBE-3437F2F9A1AF
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii







--Apple-Mail=_21BF328A-0DE8-43ED-ACBE-3437F2F9A1AF--
