Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Stotland, Inga" <inga.stotland@intel.com>
To: "sbrown@cortland.com" <sbrown@cortland.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH V3 3/9] mesh: meshctl: Add set heartbeat publish
Date: Sun, 17 Dec 2017 06:18:58 +0000
Message-ID: <1513491536.13970.9.camel@intel.com>
References: <20171215064606.15051-1-sbrown@cortland.com>
         <20171215064606.15051-4-sbrown@cortland.com>
In-Reply-To: <20171215064606.15051-4-sbrown@cortland.com>
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-mwUHL/XVwlLuImBgcrJZ"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-mwUHL/XVwlLuImBgcrJZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Fri, 2017-12-15 at 06:46 +0000, sbrown@cortland.com wrote:
> From: Steve Brown <sbrown@cortland.com>
>=20
> Sets heartbeat for node 0100
>=20
> [config: Target =3D 0100]# hb-set 0100 0 0 0 0
>=20
> Set heartbeat for node 0100 status: Success
> Destination:    0100
> Count:          00
> Period:         00
> TTL:            ff
> Features:       0000
> Net_Idx:        0000
> ---
>  mesh/config-client.c | 75
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mesh/net.c           | 20 +++++++++++++-
>  2 files changed, 94 insertions(+), 1 deletion(-)
>=20
> diff --git a/mesh/config-client.c b/mesh/config-client.c
> index aa7414cc3..270a8ca36 100644
> --- a/mesh/config-client.c
> +++ b/mesh/config-client.c
> @@ -258,6 +258,24 @@ static bool client_msg_recvd(uint16_t src,
> uint8_t *data,
>  			bt_shell_printf("Subscr Addr:\t%4.4x\n",
>  					get_le16(data + i));
>  		break;
> +
> +	/* Per Mesh Profile 4.3.2.63 */
> +	case OP_CONFIG_HEARTBEAT_PUB_STATUS:
> +		bt_shell_printf("\nSet heartbeat for node %4.4x
> status: %s\n",
> +				src,
> +				data[0] =3D=3D MESH_STATUS_SUCCESS ?
> "Success" :
> +						mesh_status_str(data
> [0]));
> +
> +		if (data[0] !=3D MESH_STATUS_SUCCESS)
> +			return true;
> +
> +		bt_shell_printf("Destination:\t%4.4x\n",
> get_le16(data + 1));
> +		bt_shell_printf("Count:\t\t%2.2x\n", data[3]);
> +		bt_shell_printf("Period:\t\t%2.2x\n", data[4]);
> +		bt_shell_printf("TTL:\t\t%2.2x\n", data[5]);
> +		bt_shell_printf("Features:\t%4.4x\n", get_le16(data
> + 6));
> +		bt_shell_printf("Net_Idx:\t%4.4x\n", get_le16(data +
> 8));
> +		break;
>  	}
> =20
>  	return true;
> @@ -712,6 +730,46 @@ static void cmd_sub_get(int argc, char *argv[])
>  		bt_shell_printf("Failed to send \"GET SUB GET\"\n");
>  }
> =20
> +static void cmd_set_hb(int argc, char *argv[])
> +{
> +	uint16_t n;
> +	uint8_t msg[32];
> +	int parm_cnt;
> +
> +	if (IS_UNASSIGNED(target)) {
> +		bt_shell_printf("Destination not set\n");
> +		return;
> +	}
> +
> +	n =3D mesh_opcode_set(OP_CONFIG_HEARTBEAT_PUB_SET, msg);
> +
> +	parm_cnt =3D read_input_parameters(argc, argv);
> +	if (parm_cnt !=3D 5) {
> +		bt_shell_printf("Bad arguments: %s\n", argv[1]);
> +		return;
> +	}
> +
> +	/* Per Mesh Profile 4.3.2.62 */
> +	/* Publish address */
> +	put_le16(parms[0], msg + n);
> +	n +=3D 2;
> +	/* Count Log */
> +	msg[n++] =3D parms[1];
> +	/* Period Log */
> +	msg[n++] =3D parms[2];
> +	/* Heartbeat TTL */
> +	msg[n++] =3D DEFAULT_TTL;
> +	/* Features */
> +	put_le16(parms[3], msg + n);
> +	n +=3D 2;
> +	/* NetKey Index */
> +	put_le16(parms[4], msg + n);
> +	n +=3D 2;
> +
> +	if (!config_send(msg, n))
> +		bt_shell_printf("Failed to send \"SET HEARTBEAT
> PUBLICATION\"\n");
> +}
> +
>  static void cmd_get_ttl(int argc, char *argv[])
>  {
>  	cmd_default(OP_CONFIG_DEFAULT_TTL_GET);
> @@ -741,6 +799,23 @@ static const struct bt_shell_menu cfg_menu =3D {
>  	{"pub-set", "<ele_addr> <pub_addr> <app_idx> "
>  			"<period (step|res)> <re-xmt (count|per)>
> <model>",
>  				cmd_set_pub,	"Set
> publication"},
> +	{"proxy-set",		"<proxy>",		cmd_s
> et_proxy,
> +						"Set proxy state"},
> +	{"proxy-get",		NULL,			cm
> d_get_proxy,
> +						"Get proxy state"},
> +	{"ident-set",		"<net_idx> <state>",	cmd
> _set_ident,
> +						"Set node identity
> state"},
> +	{"ident-get",		"<net_idx>",		cmd
> _get_ident,
> +						"Get node identity
> state"},
> +	{"relay-set",		"<relay> <rexmt count> <rexmt
> steps>",
> +							cmd_set_rela
> y,
> +						"Set relay"},
> +	{"relay-get",		NULL,			cm
> d_get_relay,
> +						"Get relay"},
> +	{"pub-get", "<ele_addr> <model>",		cmd_get_pub
> ,
> +						"Get publication"},
> +	{"hb-pub-set", "<pub_addr> <count> <period> <features>
> <net_idx>",
> +				cmd_set_hb,     "Set heartbeati
> publish"},
>  	{"sub-add", "<ele_addr> <sub_addr> <model id>",
>  				cmd_sub_add,    "Subscription add"},
>  	{"sub-get", "<ele_addr> <model id>",
> diff --git a/mesh/net.c b/mesh/net.c
> index 421dc6955..20dfcb8a8 100644
> --- a/mesh/net.c
> +++ b/mesh/net.c
> @@ -1399,6 +1399,24 @@ static bool ctl_rxed(uint16_t net_idx,
> uint32_t iv_index,
>  		uint8_t *trans, uint16_t len)
>  {
>  	/* TODO: Handle control messages */
> +
> +	/* Per Mesh Profile 3.6.5.10 */
> +	if (trans[0] =3D=3D NET_OP_HEARTBEAT) {
> +		uint16_t feat =3D get_be16(trans + 2);
> +
> +		bt_shell_printf("HEARTBEAT src: %4.4x dst: %4.4x \
> +				TTL: %2.2x feat: %s%s%s%s\n",
> +				src, dst, trans[1],
> +				(feat & MESH_FEATURE_RELAY) ? "relay
> " : "",
> +				(feat & MESH_FEATURE_PROXY) ? "proxy
> " : "",
> +				(feat & MESH_FEATURE_FRIEND) ?
> "friend " : "",
> +				(feat & MESH_FEATURE_LPN) ? "lpn" :
> "");
> +		return true;
> +	}
> +
> +	bt_shell_printf("unrecognized control message src:%4.4x
> dst:%4.4x len:%d\n",
> +			src, dst, len);
> +	print_byte_array("msg: ", trans, len);
>  	return false;
>  }
> =20
> @@ -2098,7 +2116,7 @@ bool net_access_layer_send(uint8_t ttl,
> uint16_t src, uint32_t dst,
>  	if (!result)
>  		return false;
> =20
> -	segN =3D SEG_MAX(len + sizeof(uint32_t));
> +	segN =3D SEG_MAX(len + sizeof(mic32));
> =20
>  	/* Only one ACK required SAR message per destination at a
> time */
>  	if (segN && IS_UNICAST(dst)) {

After applying this patch, the code fails to compile because of
undeclared functions for get/set proxy, get/set relay, get/set ident
and get pub.
I believe the expectation is that the code should cleanly compile after
applying each patch. Plus, you would want to keep the new added
fuctionalities bundled together, i.e., introduce new command menu items
along with the command handling (e.g., "proxy-set" & "proxy-get" belong
in
"[PATCH Vxxx 6/9] mesh: meshctl: Add set/get proxy"

Regards,

Inga
--=-mwUHL/XVwlLuImBgcrJZ
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MTIxNzA2MTg1NlowIwYJKoZIhvcNAQkEMRYE
FFhHYwjAfx00f2G7vSwFXbgWGmKPMA0GCSqGSIb3DQEBAQUABIIBAKR8jrs/lLAoEKA1THbCWV9v
06neia7VRrvhUJfxe93LFj+1rsdFxLX+YP+0gw0k31LyqFBb5eHfPCIM7ER5MGoqwdAp9IWWN5K9
t33TeDrfiIPGTm2aasdtmqqQQkSmzwjfVKYpEsc5VwOhz/qWt2xRtohdP3ruZR85XvXVaw6/6dff
AIyHfMSFBJPNbto4r5xPRFX8IE3fgosozGfJ3DA+rFA+F6iADClnd1D2xasBrR1YSaYbXKi3zLC4
9Mth02IDopBDrXPLkotlPR14Tb0InjPZpaeWf+JxwJ7HkJLkoTfYZ0/ggLRtFOvlOV2ZGyEUSfmW
zkZNVmSv3oFdx6UAAAAAAAA=


--=-mwUHL/XVwlLuImBgcrJZ--
