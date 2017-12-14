Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Stotland, Inga" <inga.stotland@intel.com>
To: "sbrown@cortland.com" <sbrown@cortland.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH V2 1/8] mesh: meshctl: Change command names to
 <cmd>-<get/set>
Date: Thu, 14 Dec 2017 08:08:02 +0000
Message-ID: <1513238880.3023.18.camel@intel.com>
References: <20171212125832.13440-1-sbrown@cortland.com>
         <20171212125832.13440-2-sbrown@cortland.com>
In-Reply-To: <20171212125832.13440-2-sbrown@cortland.com>
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-7gskc1qlTak56mUShBaV"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-7gskc1qlTak56mUShBaV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Tue, 2017-12-12 at 12:58 +0000, sbrown@cortland.com wrote:
> From: Steve Brown <sbrown@cortland.com>
>=20
> Fix lines over 80 chars
> Move cmd_default()
> Add parameter to pub-set to control retransmit count
> ---
>  mesh/config-client.c | 78 +++++++++++++++++++++++++++---------------
> ----------
>  1 file changed, 41 insertions(+), 37 deletions(-)
>=20
> diff --git a/mesh/config-client.c b/mesh/config-client.c
> index 3d618b6a6..51adf2c52 100644
> --- a/mesh/config-client.c
> +++ b/mesh/config-client.c
> @@ -170,9 +170,9 @@ static bool client_msg_recvd(uint16_t src,
> uint8_t *data,
>  		if (len !=3D 12 && len !=3D 14)
>  			return true;
> =20
> -		bt_shell_printf("\nSet publication for node %4.4x
> status: %s\n", src,
> -				data[0] =3D=3D MESH_STATUS_SUCCESS ?
> "Success" :
> -						mesh_status_str(data
> [0]));
> +		bt_shell_printf("\nSet publication for node %4.4x
> status: %s\n",
> +				src, data[0] =3D=3D MESH_STATUS_SUCCESS
> ?
> +				"Success" :
> mesh_status_str(data[0]));
> =20
>  		if (data[0] !=3D MESH_STATUS_SUCCESS)
>  			return true;
> @@ -189,6 +189,7 @@ static bool client_msg_recvd(uint16_t src,
> uint8_t *data,
>  		pub.ttl =3D data[7];
>  		pub.period =3D data[8];
>  		n =3D (data[8] & 0x3f);
> +		bt_shell_printf("Publication address: 0x%04x\n",
> pub.u.addr16);
>  		switch (data[8] >> 6) {
>  		case 0:
>  			bt_shell_printf("Period: %d ms\n", n * 100);
> @@ -206,7 +207,8 @@ static bool client_msg_recvd(uint16_t src,
> uint8_t *data,
> =20
>  		pub.retransmit =3D data[9];
>  		bt_shell_printf("Retransmit count: %d\n", data[9] >>
> 5);
> -		bt_shell_printf("Retransmit Interval Steps: %d\n",
> data[9] & 0x1f);
> +		bt_shell_printf("Retransmit Interval Steps: %d\n",
> +				data[9] & 0x1f);
> =20
>  		ele_idx =3D ele_addr - node_get_primary(node);
> =20
> @@ -219,6 +221,7 @@ static bool client_msg_recvd(uint16_t src,
> uint8_t *data,
>  				     node_model_pub_get(node,
> ele_idx, mod_id));
>  		break;
>  	}
> +
>  	return true;
>  }
> =20
> @@ -287,6 +290,23 @@ static bool config_send(uint8_t *buf, uint16_t
> len)
> =20
>  }
> =20
> +static void cmd_default(uint32_t opcode)
> +{
> +	uint16_t n;
> +	uint8_t msg[32];
> +
> +	if (IS_UNASSIGNED(target)) {
> +		bt_shell_printf("Destination not set\n");
> +		return;
> +	}
> +
> +	n =3D mesh_opcode_set(opcode, msg);
> +
> +	if (!config_send(msg, n))
> +		bt_shell_printf("Failed to send command (opcode
> 0x%x)\n",
> +								opco
> de);
> +}
> +
>  static void cmd_get_composition(int argc, char *argv[])
>  {
>  	uint16_t n;
> @@ -556,7 +576,7 @@ static void cmd_set_pub(int argc, char *argv[])
>  	n =3D mesh_opcode_set(OP_CONFIG_MODEL_PUB_SET, msg);
> =20
>  	parm_cnt =3D read_input_parameters(argc, argv);
> -	if (parm_cnt !=3D 5) {
> +	if (parm_cnt !=3D 6) {
>  		bt_shell_printf("Bad arguments\n");
>  		return;
>  	}
> @@ -574,14 +594,14 @@ static void cmd_set_pub(int argc, char *argv[])
>  	/* Publish period  step count and step resolution */
>  	msg[n++] =3D parms[3];
>  	/* Publish retransmit count & interval steps */
> -	msg[n++] =3D (1 << 5) + 2;
> +	msg[n++] =3D parms[4];
>  	/* Model Id */
> -	if (parms[4] > 0xffff) {
> -		put_le16(parms[4] >> 16, msg + n);
> -		put_le16(parms[4], msg + n + 2);
> +	if (parms[5] > 0xffff) {
> +		put_le16(parms[5] >> 16, msg + n);
> +		put_le16(parms[5], msg + n + 2);
>  		n +=3D 4;
>  	} else {
> -		put_le16(parms[4], msg + n);
> +		put_le16(parms[5], msg + n);
>  		n +=3D 2;
>  	}
> =20
> @@ -589,23 +609,6 @@ static void cmd_set_pub(int argc, char *argv[])
>  		bt_shell_printf("Failed to send \"SET MODEL
> PUBLICATION\"\n");
>  }
> =20
> -static void cmd_default(uint32_t opcode)
> -{
> -	uint16_t n;
> -	uint8_t msg[32];
> -
> -	if (IS_UNASSIGNED(target)) {
> -		bt_shell_printf("Destination not set\n");
> -		return;
> -	}
> -
> -	n =3D mesh_opcode_set(opcode, msg);
> -
> -	if (!config_send(msg, n))
> -		bt_shell_printf("Failed to send command (opcode
> 0x%x)\n",
> -								opco
> de);
> -}
> -
>  static void cmd_get_ttl(int argc, char *argv[])
>  {
>  	cmd_default(OP_CONFIG_DEFAULT_TTL_GET);
> @@ -614,27 +617,28 @@ static void cmd_get_ttl(int argc, char *argv[])
>  static const struct bt_shell_menu cfg_menu =3D {
>  	.name =3D "config",
>  	.entries =3D {
> -	{"target",		"<unicast>",		=09
> cmd_set_node,
> +	{"target",		"<unicast>",		cmd_se
> t_node,
>  						"Set target node to
> configure"},
> -	{"get-composition",	"[<page_num>]",		cm
> d_get_composition,
> +	{"composition-get",	"[<page_num>]",		cm
> d_get_composition,
>  						"Get Composition
> Data"},
> -	{"add-netkey",		"<net_idx>",		=09
> cmd_add_net_key,
> +	{"netkey-add",		"<net_idx>",		cm
> d_add_net_key,
>  						"Add network key"},
> -	{"del-netkey",		"<net_idx>",		=09
> cmd_del_net_key,
> +	{"netkey-del",		"<net_idx>",		cm
> d_del_net_key,
>  						"Delete network
> key"},
> -	{"add-appkey",		"<app_idx>",		=09
> cmd_add_app_key,
> +	{"appkey-add",		"<app_idx>",		cm
> d_add_app_key,
>  						"Add application
> key"},
> -	{"del-appkey",		"<app_idx>",		=09
> cmd_del_app_key,
> +	{"appkey-del",		"<app_idx>",		cm
> d_del_app_key,
>  						"Delete application
> key"},
>  	{"bind",		"<ele_idx> <app_idx> <mod_id>
> [cid]",
>  				cmd_bind,	"Bind app key to a
> model"},
> -	{"set-ttl",		"<ttl>",			c
> md_set_ttl,
> +	{"ttl-set",		"<ttl>",		cmd_set_t
> tl,
>  						"Set default TTL"},
> -	{"get-ttl",		NULL,			cmd_
> get_ttl,
> +	{"ttl-get",		NULL,			cmd_
> get_ttl,
>  						"Get default TTL"},
> -	{"set-pub", "<ele_addr> <pub_addr> <app_idx> "
> -						"<period (step|res)>
> <model>",
> +	{"pub-set", "<ele_addr> <pub_addr> <app_idx> "
> +			"<period (step|res)> <re-xmt (count|per)>
> <model>",
>  				cmd_set_pub,	"Set
> publication"},
> +
>  	{} },
>  };
> =20

Since you are modifying pub-set command, could you please fix it to
correctly indicate SIG and vendor models, similarly to "bind" command
(adding an optional "cid" parameter for vendor models).

Regards,

Inga Stotland
--=-7gskc1qlTak56mUShBaV
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MTIxNDA4MDgwMFowIwYJKoZIhvcNAQkEMRYE
FLQQrRMS080jMOmQI6vMf1sIWB5GMA0GCSqGSIb3DQEBAQUABIIBAMuKVfsTNftrRNi3WhMVaDWf
f/gjSLTbosImQO2a6+cYPIUN+Hd8nwh5jKU9WLrOldsG+BfyhQT4W42aXnPww78FjP1pjxhb/df9
cmvP+12z9prDImoFTtk/dYtidzrBBzSgiCHN0WtYm6HWuMaOsBxTZRgAhI991bwWU0GJJzlvk2pj
0YnQVO69agkM9x8WGorVi0R0KTv+JAZgXSRjy3/NYjUsgz1GS5TzEW2HAVCZQqSl+rhIpRTCMcro
nNW61n5OcyBeNzH6HN/qaRaTzVZeXOXBHX3rUZ+ieX/S9T0iyOcZj/K6UhvCUye/jTCOH2e2rlCI
euo80j/+CP7NrHQAAAAAAAA=


--=-7gskc1qlTak56mUShBaV--
