Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: meshctl cannot parse its own config file
From: =?utf-8?Q?Micha=C5=82_Hobot?= <michal.hobot@silvair.com>
In-Reply-To: <1511249147.6536.13.camel@intel.com>
Date: Fri, 24 Nov 2017 22:13:30 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <3516B3B5-B03B-48BF-A0C0-227E5BF3FD9D@silvair.com>
References: <D4221F5B-37CC-4BAA-88F3-C7B7F2E98DA2@silvair.com>
 <1511249147.6536.13.camel@intel.com>
To: "Stotland, Inga" <inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Inga,
I think I found root cause of the problem. There is a bug in a way =
custom models are parsed, so parsing fails quietly and correct =
information doesn't get written to the provisioner db.
This happens only when there is more than one custom model in =
composition data.

The patch is pretty trivial and self-explanatory:

--- bluez.orig/mesh/node.c	2017-11-21 18:04:57.000000000 +0100
+++ bluez/mesh/node.c	2017-11-24 21:37:16.000000000 +0100
@@ -432,7 +432,7 @@ bool node_parse_composition(struct mesh_
 			len -=3D 2;
 		}
 		while (len >=3D 4 && v--) {
-			mod_id =3D get_le16(data);
+			mod_id =3D get_le16(data + 2);
 			vendor_id =3D get_le16(data);
 			mod_id |=3D (vendor_id << 16);
 			if (!node_set_model(node, ele->index, mod_id))


Identical error prevents composition data from being printed out =
correctly:

--- bluez.orig/mesh/prov-db.c	2017-11-21 18:04:57.000000000 +0100
+++ bluez/mesh/prov-db.c	2017-11-24 21:36:12.000000000 +0100
@@ -676,7 +676,7 @@ bool prov_db_add_node_composition(struct
 		}
=20
 		while (len >=3D 4 && v--) {
-			mod_id =3D get_le16(data);
+			mod_id =3D get_le16(data + 2);
 			vendor_id =3D get_le16(data);
 			mod_id |=3D (vendor_id << 16);
 			data +=3D 4;


Btw, should I post an official patch? I'm new to this group.

Regards,
Michal Hobot


> Wiadomo=C5=9B=C4=87 napisana przez Stotland, Inga =
<inga.stotland@intel.com> w dniu 21.11.2017, o godz. 08:25:
>=20
> Hi Michal,
>=20
> On Mon, 2017-11-20 at 19:19 +0100, Micha=C5=82 Hobot wrote:
>> Hi,
>> I'm testing meshctl of bluez 5.47 with a lighting device with Silvair
>> mesh stack.
>> I am able to provision a device using a following sequence of
>> commands:
>>=20
>> provision a9d8....(UUID follows)
>> add-appkey 1
>> bind 0 1 1000
>>=20
>> Im then able to turn the light on and off using onoff 1 / onoff 0.
>> Get also works.
>>=20
>> When I'm leaving meshctl and start it once again, it fails while
>> parsing provisioner_db.json
>>=20
>> I found out that the problem was caused by:
>>=20
>> "bind":[
>>  1
>> ]
>>=20
>> in nodes/elements/models
>> When I remove "bind" element, everything seems to work fine.
>>=20
>> Is it a bug in the software or am I doing something wrong?
>>=20
>> Attaching configuration files.
>>=20
>> Regards,
>> Michal Hobot
>>=20
> Looks like you discovered a loophole: the provisioner
> should not try to issue any configuration commands that require
> knowledge of model/element setup on the node without first getting =
node
> composition. The result is a malformed database.
>=20
> I submitted a patch: "[PATCH BlueZ] mesh: validate configuration
> target" to address this issue.
>=20
> Meanwhile, I suggest calling "get-composition" command prior to any
> config command that deals with models.
>=20
> Thanks,
>=20
> Inga

