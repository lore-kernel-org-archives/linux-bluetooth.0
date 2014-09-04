Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, bharat.panda@samsung.com,
	p.sinha@samsung.com, d.kasatkin@samsung.com
References: <1409204803-3705-1-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZJaruAHM3sAg6msQyvgGj=_+CehXmEmGzOt4gjE_b+10w@mail.gmail.com>
 <000001cfc2a0$0032aa30$0097fe90$@samsung.com>
 <CABBYNZLZj-+et7M7eXncm=YdkCx7H_GfYKuLBc49OFKHm6JP4Q@mail.gmail.com>
In-reply-to: 
Subject: RE: [MAP] obexd/client: Handle MAP event types
Date: Thu, 04 Sep 2014 19:52:56 +0530
Message-id: <000601cfc84b$d131d4c0$73957e40$@samsung.com>
MIME-version: 1.0
Content-type: multipart/mixed;
 boundary="----=_NextPart_000_0007_01CFC879.EAEF8F00"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multipart message in MIME format.

------=_NextPart_000_0007_01CFC879.EAEF8F00
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: Gowtham Anandha Babu [mailto:gowtham.ab@samsung.com]
> Sent: Thursday, August 28, 2014 7:03 PM
> To: 'Luiz Augusto von Dentz'
> Cc: 'linux-bluetooth@vger.kernel.org'
> Subject: RE: [MAP] obexd/client: Handle MAP event types
>=20
> Hi Luiz,
>=20
> > -----Original Message-----
> > From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> > Sent: Thursday, August 28, 2014 3:16 PM
> > To: Gowtham Anandha Babu
> > Cc: linux-bluetooth@vger.kernel.org
> > Subject: Re: [MAP] obexd/client: Handle MAP event types
> >
> > Hi,
> >
> > On Thu, Aug 28, 2014 at 12:11 PM, Gowtham Anandha Babu
> > <gowtham.ab@samsung.com> wrote:
> > > Hi Luiz,
> > >     But in the obexd/client/mns.c
> > >     Inside parse_event_report_type() function, event types are
> > > assigned
> > with the values MAP_ET_MEMORY_FULL and
> MAP_ET_MEMORY_AVAILABLE.
> > >     It should be handled in the map_handle_notification() inside =
map.c.
> >
> > Please do not top post in the mailing list, use inline posting.
> > Regarding the parsing, yes it does have proper handling of those =
event
> > but there is no mapping to the D-Bus API therefore we ignore those
> > memory event. As I mentioned the they are not per message so they
> > cannot be set as a status of a message, anyway it would not make
> > sense, and having it on the MessageAccess interface has not been
> > considered but first I need to have a proper user case where it =
makes
> sense to expose those events.
> >
> > Luiz Augusto von Dentz
>=20
>=20
> The use cases are:
> 1) What if one tries to push a message, but the space available in the =
MSE
> device is not enough. So MCE will receive Memory Full Event.
> 2) Once the user cleared some memory in the MSE device, MCE should be
> notified with Memory Available Event.
> As you mentioned earlier, these cannot be set as a status of a =
message. But
> MCE device needs to be get notified about this events.
>=20
> If the MCE receives Memory Full event, it will set the status as =
"delivery-
> failure".
> Once MSE device(server)  deletes some messages and send Memory
> Available event then MCE will push the pending message.
> Can it be done like this?
>=20
> Regards,
> Gowtham

Just a reminder. With little bit clarity , If MCE pushes the message, =
the "Memory Full" event type is given by MSE. Then I think the status of =
that message will be empty. Instead we can set the status as a =
"sending-failure".
Whatever explained I added in the attached patch for your kind perusal.

Regards,
Gowtham

------=_NextPart_000_0007_01CFC879.EAEF8F00
Content-Type: application/octet-stream;
	name="0001-obexd-client-Handle-MAP-event-types.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-obexd-client-Handle-MAP-event-types.patch"

>From 448f7b2f3910e667e45f7e48ae01a96529be1a78 Mon Sep 17 00:00:00 2001=0A=
From: gowtham babu <gowtham.ab@samsung.com>=0A=
Date: Thu, 4 Sep 2014 19:35:49 +0530=0A=
Subject: [MAP] obexd/client: Handle MAP event types=0A=
=0A=
Adds below MCE event types handling in map_handle_notification()=0A=
MAP_ET_MEMORY_FULL=0A=
---=0A=
 obexd/client/map.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/obexd/client/map.c b/obexd/client/map.c=0A=
index 520e492..d80ad98 100644=0A=
--- a/obexd/client/map.c=0A=
+++ b/obexd/client/map.c=0A=
@@ -1927,6 +1927,9 @@ static void map_handle_notification(struct =
map_event *event, void *user_data)=0A=
 	case MAP_ET_MESSAGE_SHIFT:=0A=
 		map_handle_folder_changed(map, event, event->folder);=0A=
 		break;=0A=
+	case MAP_ET_MEMORY_FULL:=0A=
+		map_handle_status_changed(map, event, "sending-failure");=0A=
+		break;=0A=
 	default:=0A=
 		break;=0A=
 	}=0A=
-- =0A=
1.9.1=0A=
=0A=

------=_NextPart_000_0007_01CFC879.EAEF8F00--

