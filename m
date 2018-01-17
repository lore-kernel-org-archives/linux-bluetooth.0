Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Stotland, Inga" <inga.stotland@intel.com>
To: "sbrown@cortland.com" <sbrown@cortland.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] mesh: meshctl: Add set heartbeat subscription command
Date: Wed, 17 Jan 2018 06:33:47 +0000
Message-ID: <1516170825.4520.12.camel@intel.com>
References: <20180112145224.26587-1-sbrown@cortland.com>
In-Reply-To: <20180112145224.26587-1-sbrown@cortland.com>
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-MxefdKCdB6mWOEZuyO8C"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-MxefdKCdB6mWOEZuyO8C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Fri, 2018-01-12 at 09:52 -0500, sbrown@cortland.com wrote:
> From: Steve Brown <sbrown@cortland.com>
>=20
> [config: Target =3D 0100]# hb-sub-set 0077 0100 2
>=20
> Heartbeat subscription status for node 0100 status: Success
> Source:		0077
> Destination:	0100
> Period:		01
> Count:		00
> Min Hops:	7f
> Max Hops:	00
> ---
>  mesh/config-client.c | 60
> +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 3 deletions(-)
>=20
> diff --git a/mesh/config-client.c b/mesh/config-client.c
> index f280441cc..e6a2e6e93 100644
> --- a/mesh/config-client.c
> +++ b/mesh/config-client.c
> @@ -318,6 +318,25 @@ static bool client_msg_recvd(uint16_t src,
> uint8_t *data,
>  		bt_shell_printf("Features:\t%4.4x\n", get_le16(data
> + 6));
>  		bt_shell_printf("Net_Idx:\t%4.4x\n", get_le16(data +
> 8));
>  		break;

Just one minor suggestion.
Since now you have support for both HB pub and sub, could you please
add a change for the printf of HB publication status to make it
publication specific (currently it prints "Set heartbeat for node"?


> +
> +	/* Per Mesh Profile 4.3.2.66 */
> +	case OP_CONFIG_HEARTBEAT_SUB_STATUS:
> +		bt_shell_printf("\nHeartbeat subscription status for
> "
> +				"node %4.4x status: %s\n",
> +				src,
> +				data[0] =3D=3D MESH_STATUS_SUCCESS ?
> "Success" :
> +						mesh_status_str(data
> [0]));
> +
> +		if (data[0] !=3D MESH_STATUS_SUCCESS)
> +			return true;
> +
> +		bt_shell_printf("Source:\t\t%4.4x\n", get_le16(data
> + 1));
> +		bt_shell_printf("Destination:\t%4.4x\n",
> get_le16(data + 3));
> +		bt_shell_printf("Period:\t\t%2.2x\n", data[5]);
> +		bt_shell_printf("Count:\t\t%2.2x\n", data[6]);
> +		bt_shell_printf("Min Hops:\t%2.2x\n", data[7]);
> +		bt_shell_printf("Max Hops:\t%2.2x\n", data[8]);
> +		break;
>  	}
> =20
>  	return true;
> @@ -946,7 +965,7 @@ static void cmd_get_app(int argc, char *argv[])
>  		bt_shell_printf("Failed to send \"GET APP GET\"\n");
>  }
> =20
> -static void cmd_set_hb(int argc, char *argv[])
> +static void cmd_hb_pub_set(int argc, char *argv[])
>  {
>  	uint16_t n;
>  	uint8_t msg[32];
> @@ -983,7 +1002,40 @@ static void cmd_set_hb(int argc, char *argv[])
>  	n +=3D 2;
> =20
>  	if (!config_send(msg, n))
> -		bt_shell_printf("Failed to send \"SET HEARTBEAT
> PUBLICATION\"\n");
> +		bt_shell_printf("Failed to send \"SET HEARTBEAT
> PUBLISH\"\n");
> +}
> +
> +static void cmd_hb_sub_set(int argc, char *argv[])
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
> +	n =3D mesh_opcode_set(OP_CONFIG_HEARTBEAT_SUB_SET, msg);
> +
> +	parm_cnt =3D read_input_parameters(argc, argv);
> +	if (parm_cnt !=3D 3) {
> +		bt_shell_printf("Bad arguments: %s\n", argv[1]);
> +		return;
> +	}
> +
> +	/* Per Mesh Profile 4.3.2.65 */
> +	/* Source address */
> +	put_le16(parms[0], msg + n);
> +	n +=3D 2;
> +	/* Destination address */
> +	put_le16(parms[1], msg + n);
> +	n +=3D 2;
> +	/* Period log */
> +	msg[n++] =3D parms[2];
> +
> +	if (!config_send(msg, n))
> +		bt_shell_printf("Failed to send \"SET HEARTBEAT
> SUBSCRIBE\"\n");
>  }
> =20
>  static void cmd_get_ttl(int argc, char *argv[])
> @@ -1033,7 +1085,9 @@ static const struct bt_shell_menu cfg_menu =3D {
>  	{"relay-
> get",           NULL,                   cmd_get_relay,
>  						"Get relay"},
>  	{"hb-pub-set", "<pub_addr> <count> <period> <features>
> <net_idx>",
> -				cmd_set_hb,     "Set heartbeati
> publish"},
> +				cmd_hb_pub_set,     "Set heartbeat
> publish"},
> +	{"hb-sub-set", "<src_addr> <dst_addr> <period>",
> +				cmd_hb_sub_set,     "Set heartbeat
> subscribe"},
>  	{"sub-add", "<ele_addr> <sub_addr> <model id>",
>  				cmd_sub_add,    "Subscription add"},
>  	{"sub-get", "<ele_addr> <model id>",

Regards,

Inga
--=-MxefdKCdB6mWOEZuyO8C
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDExNzA2MzM0NVowIwYJKoZIhvcNAQkEMRYE
FM1EvHPnFhiibIuVovhAhSwnkCh3MA0GCSqGSIb3DQEBAQUABIIBAJbYVKwyXGBNvzV2zDTWasM5
qG/Numm6BhP+6Yq9TJmEFI4EAKyHNjSMAkgc4+5I/CA8XueeWQxxIp92vCTqDZ44NzjYjarRfmne
Ff71eXiz0ckKk+I85def1nRy1eJhuezOaLc2GVgBC8SyOEWUK4LfUFLPDBXovhwvYHKTbWVNhNyl
Ts1Htj+yBKWQdAnGBPxZQH1DQGP0rEeMlE0G6OE0nq+6hRzWsf6FztE96SszyL2Y010bIylHPVtj
i+HSBi1tc3VB0owWoTCTs4gOwoKl0m3XoWF56mp1c5dAzx0q0dQDgk5zt+VPP/6VzVr0U8gmhlLl
cGMCmu5aaaiiv3kAAAAAAAA=


--=-MxefdKCdB6mWOEZuyO8C--
