Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Stotland, Inga" <inga.stotland@intel.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh/meshctl: Exit cleanly if start up fails
Date: Mon, 26 Mar 2018 15:23:53 +0000
Message-ID: <1522077832.2966.4.camel@intel.com>
References: <20180324023336.13879-1-inga.stotland@intel.com>
         <CABBYNZKSyN0KZAray2afZXyESF1BeY0LOvK0hv-AuX05vu7MSg@mail.gmail.com>
In-Reply-To: <CABBYNZKSyN0KZAray2afZXyESF1BeY0LOvK0hv-AuX05vu7MSg@mail.gmail.com>
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-pbaB6YZEweGTX7Cxgo++"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-pbaB6YZEweGTX7Cxgo++
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, 2018-03-26 at 16:31 +0300, Luiz Augusto von Dentz wrote:
> Hi Inga,
>=20
> On Sat, Mar 24, 2018 at 4:33 AM, Inga Stotland <inga.stotland@intel.c
> om> wrote:
> > When failing to start meshctl due to invalid input configuration,
> > release bt_shell resources prior to exit.
>=20
>=20
> Similar response as to Eramoto's patch, if the tool is going to exit
> there is no need to free up the resources, the exit status is still
> useful but that is a different matter. Or perhaps we just want to
> avoid false positives with static analyzers?
>=20

My motivation for this patch was quite simple: if the program exits
after bt_shell_init() has ben called but prior to calling bt_shell_run,
bash shell is all messed up (at least on my system) after that.

>=20
> > ---
> >  mesh/main.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/mesh/main.c b/mesh/main.c
> > index d991c9f8c..d0f71c2d9 100644
> > --- a/mesh/main.c
> > +++ b/mesh/main.c
> > @@ -1930,11 +1930,11 @@ int main(int argc, char *argv[])
> >         mesh_local_config_filename =3D g_malloc(len +
> > strlen("local_node.json")
> >                                                                   =20
> >      + 2);
> >         if (!mesh_local_config_filename)
> > -               exit(1);
> > +               goto fail;
> >=20
> >         mesh_prov_db_filename =3D g_malloc(len +
> > strlen("prov_db.json") + 2);
> >         if (!mesh_prov_db_filename) {
> > -               exit(1);
> > +               goto fail;
> >         }
> >=20
> >         sprintf(mesh_local_config_filename, "%s", mesh_config_dir);
> > @@ -1950,7 +1950,7 @@ int main(int argc, char *argv[])
> >         if (!prov_db_read_local_node(mesh_local_config_filename,
> > true)) {
> >                 g_printerr("Failed to parse local node
> > configuration file %s\n",
> >                         mesh_local_config_filename);
> > -               exit(1);
> > +               goto fail;
> >         }
> >=20
> >         sprintf(mesh_prov_db_filename, "%s", mesh_config_dir);
> > @@ -1965,7 +1965,7 @@ int main(int argc, char *argv[])
> >         if (!prov_db_read(mesh_prov_db_filename)) {
> >                 g_printerr("Failed to parse provisioning database
> > file %s\n",
> >                         mesh_prov_db_filename);
> > -               exit(1);
> > +               goto fail;
> >         }
> >=20
> >         dbus_conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
> > @@ -2001,5 +2001,9 @@ int main(int argc, char *argv[])
> >         g_list_free(service_list);
> >         g_list_free_full(ctrl_list, proxy_leak);
> >=20
> > -       return 0;
> > +       return EXIT_SUCCESS;
> > +
> > +fail:
> > +       bt_shell_cleanup();
> > +       return EXIT_FAILURE;
> >  }
> > --
> > 2.13.6
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
--=-pbaB6YZEweGTX7Cxgo++
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDMyNjE1MjM1MlowIwYJKoZIhvcNAQkEMRYE
FJt8eDLfhPsKSQnEx6xhGlADPomRMA0GCSqGSIb3DQEBAQUABIIBALZNAMsT3kdWuEyb/ZFQGm++
WhAiGxR3u0Nadei6CdtTxZE+nVFnklJ7kvRsKn0RW80rpelyJTScQxmt6Uz9pk2ivHBiN7qQc/41
pQPXD0FYa+MkcOIC5fXEbmns/JWIyZuGTCwHfLeIfIVC81bHrm29e0wDFhGpBGp/XjAox1EfifDq
z31PecsTWkFn96/OUrDhnw77JbcYJzeAsa7r1zx1Bq0MIcYtfq0+bT95tOPG+JaReJf3nEqMhFzD
FVyNX3QcWcmjnoqVpCDQ2rC5djt2cVvz6yT7U6wZpkA93dKDuG3+F2LPJ4Mx+QsmBgTjPjg1mGqu
1qo7yLdr8QVYlVIAAAAAAAA=


--=-pbaB6YZEweGTX7Cxgo++--
