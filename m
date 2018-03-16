Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Stotland, Inga" <inga.stotland@intel.com>
To: "a.rai@samsung.com" <a.rai@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "anupam.r@samsung.com" <anupam.r@samsung.com>,
        "sachin.dev@samsung.com" <sachin.dev@samsung.com>
Subject: Re: [PATCH] Mesh: Close net session on device disconnection
Date: Fri, 16 Mar 2018 18:26:45 +0000
Message-ID: <1521224803.3021.1.camel@intel.com>
References: <CGME20180316074208epcas2p22e43ea7190d2ce88a5cf952269c8939a@epcas2p2.samsung.com>
         <1521186117-12216-1-git-send-email-a.rai@samsung.com>
In-Reply-To: <1521186117-12216-1-git-send-email-a.rai@samsung.com>
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-82WioPYKsE1vzq3tf6Ya"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-82WioPYKsE1vzq3tf6Ya
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Atul,

On Fri, 2018-03-16 at 13:11 +0530, Atul Rai wrote:
> On device disconnection, net session is not closed. On next
> attempt to provision/connect a device, net session proxy is
> not updated by net_session_open() as proxy_in is not NULL.
> This causes meshctl to use invalid proxy resulting in below
> crash.
>=20
> 0  strlen () at ../sysdeps/x86_64/strlen.S:106
> 1  0x00007f3a3c8b1ac4 in _dbus_string_init_const () from libdbus-
> 1.so.3
> 2  0x00007f3a3c89ed15 in ?? () from libdbus-1.so.3
> 3  0x00007f3a3c89fba0 in dbus_message_new_method_call () from
> libdbus-1.so.3
> 4  0x0000000000419880 in g_dbus_proxy_method_call at
> gdbus/client.c:997
> 5  0x000000000040ab9d in mesh_gatt_write at mesh/gatt.c:347
> 6  0x000000000040d761 in send_mesh_pkt at mesh/net.c:1227
> 7  send_seg at mesh/net.c:1325
> 8  0x000000000040fa60 in net_access_layer_send at mesh/net.c:2163
> 9  0x0000000000413c74 in config_send at mesh/config-client.c:418
> 10 0x0000000000414886 in cmd_composition_get at mesh/config-
> client.c:470
> 11 0x000000000041ffd9 in cmd_exec at src/shared/shell.c:356
> 12 menu_exec at src/shared/shell.c:383
> 13 0x00000000004203a5 in shell_exec at src/shared/shell.c:426
> 14 0x0000000000420d24 in rl_handler (input=3D0x2259aa0 "composition-get=
=20
> ")
> at src/shared/shell.c:571
> 15 0x00007f3a3c45d6f5 in rl_callback_read_char () from
> libreadline.so.6
> 16 0x0000000000420229 in input_read at src/shared/shell.c:1034
> 17 0x0000000000421655 in watch_callback at src/shared/io-glib.c:170
> 18 0x00007f3a3cb1a04a in g_main_context_dispatch () from libglib-
> 2.0.so.0
> 19 0x00007f3a3cb1a3f0 in ?? () from libglib-2.0.so.0
> 20 0x00007f3a3cb1a712 in g_main_loop_run () from libglib-2.0.so.0
> 21 0x0000000000421bf5 in mainloop_run () at src/shared/mainloop-
> glib.c:73
> 22 0x000000000042115a in bt_shell_run () at src/shared/shell.c:962
> 23 0x0000000000405c5d in main at mesh/main.c:1992
> ---
>  mesh/main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/mesh/main.c b/mesh/main.c
> index 7c72f49..d991c9f 100644
> --- a/mesh/main.c
> +++ b/mesh/main.c
> @@ -949,7 +949,6 @@ static void mesh_session_setup(GDBusProxy *proxy)
>  		data_out_notify(connection.data_out, true,
> notify_prov_out_cb);
> =20
>  	} else if (connection.type !=3D CONN_TYPE_INVALID){
> -
>  		connection.data_in =3D get_characteristic(proxy,
>  						MESH_PROXY_DATA_IN_U
> UID_STR);
>  		if (!connection.data_in)
> @@ -1202,8 +1201,10 @@ static void property_changed(GDBusProxy
> *proxy, const char *name,
>  				if (connected && connection.device
> =3D=3D NULL)
>  					set_connected_device(proxy);
>  				else if (!connected &&
> -						connection.device =3D=3D
> proxy)
> +						connection.device =3D=3D
> proxy) {
> +					net_session_close(connection
> .data_in);
>  					set_connected_device(NULL);
> +				}
>  			} else if ((strcmp(name, "Alias") =3D=3D 0) &&
>  						connection.device =3D=3D
> proxy) {
>  				/* Re-generate prompt */

This looks fine.

Regards,
Inga
--=-82WioPYKsE1vzq3tf6Ya
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDMxNjE4MjY0M1owIwYJKoZIhvcNAQkEMRYE
FMfj0SZH8vf9avstswWN3ZZcp4T/MA0GCSqGSIb3DQEBAQUABIIBAF575nvCh2vCrsNKMMx/yyOj
JUC7Vmd6TX7PUZe1DQ9xQVt5qfnJp2W1go7W2Bp9nLfd1zsPO3867AWUAKHlYv329PxDLLrj3z0g
PcxyH0/No+fayYXlpz0sP+bvhICpOqtjnH5ueoBkp63W/Isu31nbxe3WLjq3NG1HyPGhn1gDDpNz
thBWWbPhs8qbX7LFZm/Ojuq5/G9FGGCn+7V/fZ0/jlQ3I5JTnWPqQYv5tkLKZ51ENzMzyo5a3jrL
80CVssvTQGk6oyHFG/jDOcdYmVALFrgcSPQMhi/dfZBl+39MHLMDkeVN4UICPHtlclXf15q0Qkf+
ULsDoAyq+ELHEvYAAAAAAAA=


--=-82WioPYKsE1vzq3tf6Ya--
