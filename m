Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05032811466fe34801@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [Bluez-users] PANU service search
In-Reply-To: <1112037740.9016.45.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5098_12938496.1112039186795"
References: <e1effdeb05032805225cf1b8dd@mail.gmail.com>
	 <1112016560.9016.32.camel@pegasus>
	 <e1effdeb0503280607600d1863@mail.gmail.com>
	 <1112019482.9016.37.camel@pegasus>
	 <e1effdeb050328110339a02eb7@mail.gmail.com>
	 <1112037740.9016.45.camel@pegasus>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 28 Mar 2005 16:46:26 -0300

------=_Part_5098_12938496.1112039186795
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

The code for support search for PANU service is attached. The change
is very small
but will help me create a PAN for UPnP application in ad hoc scenario.


Regards,
Claudio.





On Mon, 28 Mar 2005 21:22:20 +0200, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
> 
> > I will try explain my problem more deeply.
> >
> > Bluetooth Extended Service Discovery Profile (ESDP) for Universal Plug
> > and Play(UPnP)
> > defines how devices with Bluetooth wireless communications can use the
> > Bluetooth
> > Service Discovery Protocol (SDP) initially to discover other devices
> > that support UPnP
> > services and retrieve information about these services.
> > For more details see http://www.bluetooth.org  document: ESDP_for_UPnP_V0.95.pdf
> >
> > According with this profile three approach can be implemented:
> > 1. L2CAP -based Solution: focus on layering UPnP services
> >    over the L2CAP layer of the Bluetooth protocol stack for use by
> >    devices that lack IP support.
> > 2. IP-based Solution using PAN Profile: focus on layering UPnP
> > services over the Bluetooth Personal Area Networking (PAN) Profile.
> > 3. IP-based Solution using LAN Access Profile : focus on layering UPnP
> > services over the Bluetooth Local Area Network (LAN) Access Profile.
> >
> > I choose the SECOND because I have to address ad hoc and NAP scenarios. The 3th
> > option doesn't support multiple connections. The first option is not
> > feasible for me
> > because a UPnP service can be available in a server that belong to a
> > LAN. Therefore,
> > using  L2CAP -based Solution I will not be able to search UPnP service
> > in a device
> > that doesn't belongs directly to the PAN.
> >
> >
> > After select the SECOND approach two scenarios exist:
> > - Ad Hoc scenario
> >   The Control Point* device(role GN) will establish a PAN with PANUs
> > devices(listen enabled), assign IP to the nodes and after search for
> > UPnP services. The Control Point is the active member, it search for other
> > devices and must foward packet to all devices that belongs to the PAN.
> >
> > - NAP scenario
> >   If a NAP(listen enabled) is available, the Control Point(role PANU)
> > will connect to
> > the NAP and search for UPnP service in the LAN
> 
> and I still don't see your problem here. Everything is available for
> doing this.
> 
> > I implemented the search for PANU service and tested. Now, what is the
> > procedure to
> > submit a new patch. I am not sure if this small enhancement can be
> > usefull for the
> > bluez community.
> 
> Create a patch and post it to the bluez-devel mailing list.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_5098_12938496.1112039186795
Content-Type: text/x-patch; name="panu_support.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="panu_support.diff"

--- bluez-utils-2.15/tools/sdptool.c=092004-12-25 16:06:02.000000000 -0200
+++ bluez-utils-2.15-panu/tools/sdptool.c=092005-03-28 14:09:33.245185360 -=
0300
@@ -1599,6 +1599,69 @@
 =09return ret;
 }
=20
+
+static int add_panu(sdp_session_t *session, svc_info_t *si)
+{
+=09sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+=09uuid_t root_uuid, ftrn_uuid, l2cap_uuid, bnep_uuid;
+=09sdp_profile_desc_t profile[1];
+=09sdp_list_t *aproto, *proto[2];
+=09sdp_record_t record;
+=09uint16_t lp =3D 0x000f, ver =3D 0x0100;
+=09sdp_data_t *psm, *version;
+=09int ret =3D 0;
+
+=09memset((void *)&record, 0, sizeof(sdp_record_t));
+=09record.handle =3D 0xffffffff;
+=09sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+=09root =3D sdp_list_append(NULL, &root_uuid);
+=09sdp_set_browse_groups(&record, root);
+=09sdp_list_free(root, NULL);
+
+=09sdp_uuid16_create(&ftrn_uuid, PANU_SVCLASS_ID);
+=09svclass_id =3D sdp_list_append(NULL, &ftrn_uuid);
+=09sdp_set_service_classes(&record, svclass_id);
+=09sdp_list_free(svclass_id, NULL);
+
+=09sdp_uuid16_create(&profile[0].uuid, PANU_PROFILE_ID);
+=09profile[0].version =3D 0x0100;
+=09pfseq =3D sdp_list_append(NULL, &profile[0]);
+=09sdp_set_profile_descs(&record, pfseq);
+=09sdp_list_free(pfseq, NULL);
+
+=09sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+=09proto[0] =3D sdp_list_append(NULL, &l2cap_uuid);
+=09psm =3D sdp_data_alloc(SDP_UINT16, &lp);
+=09proto[0] =3D sdp_list_append(proto[0], psm);
+=09apseq =3D sdp_list_append(NULL, proto[0]);
+
+=09sdp_uuid16_create(&bnep_uuid, BNEP_UUID);
+=09proto[1] =3D sdp_list_append(NULL, &bnep_uuid);
+=09version =3D sdp_data_alloc(SDP_UINT16, &ver);
+=09proto[1] =3D sdp_list_append(proto[1], version);
+=09apseq =3D sdp_list_append(apseq, proto[1]);
+
+=09aproto =3D sdp_list_append(NULL, apseq);
+=09sdp_set_access_protos(&record, aproto);
+
+=09sdp_set_info_attr(&record, "PAN User", NULL, NULL);
+
+=09if (sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) {
+=09=09printf("Service Record registration failed\n");
+=09=09ret =3D -1;
+=09=09goto end;
+=09}
+=09printf("PANU service registered\n");
+end:
+=09sdp_data_free(version);
+=09sdp_data_free(psm);
+=09sdp_list_free(proto[0], 0);
+=09sdp_list_free(proto[1], 0);
+=09sdp_list_free(apseq, 0);
+=09sdp_list_free(aproto, 0);
+=09return ret;
+}
+
 static int add_ctp(sdp_session_t *session, svc_info_t *si)
 {
 =09sdp_list_t *svclass_id, *pfseq, *apseq, *root;
@@ -1793,6 +1856,7 @@
=20
 =09{ "NAP",=09NAP_SVCLASS_ID,=09=09=09add_nap=09=09},
 =09{ "GN",=09=09GN_SVCLASS_ID,=09=09=09add_gn=09=09},
+=09{ "PANU",       PANU_SVCLASS_ID,                add_panu        },
=20
 =09{ "HID",=09HID_SVCLASS_ID,=09=09=09NULL=09=09},
 =09{ "CIP",=09CIP_SVCLASS_ID,=09=09=09NULL=09=09},

------=_Part_5098_12938496.1112039186795--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
