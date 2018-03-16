Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Stotland, Inga" <inga.stotland@intel.com>
To: "a.rai@samsung.com" <a.rai@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "anupam.r@samsung.com" <anupam.r@samsung.com>,
        "sachin.dev@samsung.com" <sachin.dev@samsung.com>
Subject: Re: [PATCH] Mesh: add 'node-reset' command
Date: Fri, 16 Mar 2018 19:26:47 +0000
Message-ID: <1521228405.3021.9.camel@intel.com>
References: <CGME20180316074231epcas2p40b46daed3307a524f41d8c9994912596@epcas2p4.samsung.com>
         <1521186139-12275-1-git-send-email-a.rai@samsung.com>
In-Reply-To: <1521186139-12275-1-git-send-email-a.rai@samsung.com>
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-IE76I2magrKJWwTibtQZ"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-IE76I2magrKJWwTibtQZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Atul,

On Fri, 2018-03-16 at 13:12 +0530, Atul Rai wrote:
> This patch adds 'node-reset' command which can be used to reset a
> node (other than a Provisioner) and remove it from the network.
> ---
>  mesh/config-client.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/mesh/config-client.c b/mesh/config-client.c
> index 19e617d..7cb8a37 100644
> --- a/mesh/config-client.c
> +++ b/mesh/config-client.c
> @@ -342,6 +342,17 @@ static bool client_msg_recvd(uint16_t src,
> uint8_t *data,
>  		bt_shell_printf("Min Hops\t%2.2x\n", data[7]);
>  		bt_shell_printf("Max Hops\t%2.2x\n", data[8]);
>  		break;
> +
> +	/* Per Mesh Profile 4.3.2.54 */
> +	case OP_NODE_RESET_STATUS:
> +		bt_shell_printf("Node %4.4x reset status %s\n",
> +				src, mesh_status_str(data[0]));
> +
> +		net_release_address(node_get_primary(node),
> +				(node_get_num_elements(node) - 1));
> +		/* TODO: Remove node info from database */
> +		node_free(node);
> +		break;
>  	}
> =20
>  	return true;
> @@ -1124,6 +1135,11 @@ static void cmd_ttl_get(int argc, char
> *argv[])
>  	cmd_default(OP_CONFIG_DEFAULT_TTL_GET);
>  }
> =20
> +static void cmd_node_reset(int argc, char *argv[])
> +{
> +	cmd_default(OP_NODE_RESET);
> +}
> +
>  static const struct bt_shell_menu cfg_menu =3D {
>  	.name =3D "config",
>  	.desc =3D "Configuration Model Submenu",
> @@ -1179,6 +1195,8 @@ static const struct bt_shell_menu cfg_menu =3D {
>  				cmd_sub_add,    "Add subscription"},
>  	{"sub-get", "<ele_addr> <model id>",
>  				cmd_sub_get,    "Get subscription"},
> +	{"node-reset",		NULL,                   cmd_no
> de_reset,

Please change leading white spaces to tabs in the line below and
capitalize "Reset" in the command description for consistency.=20
> +                                     "reset a node and remove it
> from network"},
>  	{} },
>  };
> =20

This looks good, just needs a little style fix.

Regards,
Inga
--=-IE76I2magrKJWwTibtQZ
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDMxNjE5MjY0NVowIwYJKoZIhvcNAQkEMRYE
FIkfmD95LpssX0kLd9S6cbMFDDn8MA0GCSqGSIb3DQEBAQUABIIBAJguvQ+O8cbB8M86r2oio63F
yKb5u54RrWNYo0rd6FfWVd14N+68++Cj9qTvJP/+clfcKGGP9dcKT2Lh25Q+BCGq/hUSmnTtEDbD
Kx+1Y2vj/+w8/z4LumA7rqCfkC+gsf+bGzFLtvPDnu01bmtYV4YHXdikCjrqF2A8HxsZ0KYTlipU
m+WZ/XjYcAJMWAmMjZ/iaOLXvxgwSseyUt1Wtwl87KwnrR6CfZZ7Ne2yKZDlNzpKhAoEsRvPL13a
asp5IcwZZ08wDl7v3AFRWslJAM1/W8qI8qw8wa2TOEjsGsPPneywn82nSifZ8b6cUA0IJBotBGpF
ZXYQQhitDziNnfAAAAAAAAA=


--=-IE76I2magrKJWwTibtQZ--
