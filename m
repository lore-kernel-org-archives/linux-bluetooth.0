Return-Path: <SRS0=tYwc=UC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5704C04AB5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jun 2019 22:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB2826AB7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jun 2019 22:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfFCWpy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:45:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:22136 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfFCWpy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Jun 2019 18:45:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 15:45:53 -0700
X-ExtLoop1: 1
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jun 2019 15:45:52 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.200]) with mapi id 14.03.0415.000;
 Mon, 3 Jun 2019 15:45:52 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "ludwig.nussel@suse.de" <ludwig.nussel@suse.de>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Fix installations to pkglibexecdir
Thread-Topic: [PATCH] Fix installations to pkglibexecdir
Thread-Index: AQHU8Tkr2yvnS21+wUuimJhTyK5FN6aLTw+A
Date:   Mon, 3 Jun 2019 22:45:51 +0000
Message-ID: <5faedea051cf7c168c551311872db2643024356d.camel@intel.com>
References: <20190412140741.28565-1-ludwig.nussel@suse.de>
In-Reply-To: <20190412140741.28565-1-ludwig.nussel@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.151.20]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-vETqa1S6irshxW2l9GnF"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-vETqa1S6irshxW2l9GnF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludwig,

On Fri, 2019-04-12 at 16:07 +0200, Ludwig Nussel wrote:
> In 78bce4800 pkglibexecdir was used instead of libexecdir. Make sure
> Makefile and service files match, so install to pkglibexecdir
> actually.

Could we please rephrase it here slightly:
In 78bce4800 libexecdir was switched to pkglibexecdir. To use the
matching installation script, use pkglibexec_Programs instead of
libexec_Programs.

> ---
>  Makefile.am    | 4 ++--
>  Makefile.mesh  | 2 +-
>  Makefile.obexd | 2 +-
>  Makefile.tools | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/Makefile.am b/Makefile.am
> index f84a1faba..33baa66ff 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -22,7 +22,7 @@ EXTRA_DIST =3D
> =20
>  pkglibexecdir =3D $(libexecdir)/bluetooth
> =20
> -libexec_PROGRAMS =3D
> +pkglibexec_PROGRAMS =3D
> =20
>  pkgincludedir =3D $(includedir)/bluetooth
> =20
> @@ -238,7 +238,7 @@ plugins_external_dummy_la_LDFLAGS =3D $(AM_LDFLAGS)
> -module -avoid-version \
>  plugins_external_dummy_la_CFLAGS =3D $(AM_CFLAGS) -fvisibility=3Dhidden
>  endif
> =20
> -libexec_PROGRAMS +=3D src/bluetoothd
> +pkglibexec_PROGRAMS +=3D src/bluetoothd
> =20
>  src_bluetoothd_SOURCES =3D $(builtin_sources) \
>  			$(attrib_sources) $(btio_sources) \
> diff --git a/Makefile.mesh b/Makefile.mesh
> index 76e424b92..12653ccb1 100644
> --- a/Makefile.mesh
> +++ b/Makefile.mesh
> @@ -26,7 +26,7 @@ mesh_sources =3D mesh/mesh.h mesh/mesh.c \
>  				mesh/prov-acceptor.c mesh/prov-
> initiator.c \
>  				mesh/pb-adv.h mesh/pb-adv.c \
>  				mesh/mesh-defs.h
> -libexec_PROGRAMS +=3D mesh/bluetooth-meshd
> +pkglibexec_PROGRAMS +=3D mesh/bluetooth-meshd
> =20
>  mesh_bluetooth_meshd_SOURCES =3D $(mesh_sources) mesh/main.c
>  mesh_bluetooth_meshd_LDADD =3D src/libshared-ell.la $(ell_ldadd)
> -ljson-c
> diff --git a/Makefile.obexd b/Makefile.obexd
> index 1c1e500fe..d36874770 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -51,7 +51,7 @@ obexd_builtin_modules +=3D mns
>  obexd_builtin_sources +=3D obexd/client/mns.c obexd/src/map_ap.h \
>  				obexd/client/map-event.h
> =20
> -libexec_PROGRAMS +=3D obexd/src/obexd
> +pkglibexec_PROGRAMS +=3D obexd/src/obexd
> =20
>  obexd_src_obexd_SOURCES =3D $(btio_sources) $(gobex_sources) \
>  			$(obexd_builtin_sources) \
> diff --git a/Makefile.tools b/Makefile.tools
> index 379e127b6..7d5361bcd 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -43,7 +43,7 @@ monitor_btmon_LDADD =3D lib/libbluetooth-internal.la
> \
>  endif
> =20
>  if LOGGER
> -libexec_PROGRAMS +=3D tools/btmon-logger
> +pkglibexec_PROGRAMS +=3D tools/btmon-logger
> =20
>  tools_btmon_logger_SOURCES =3D tools/btmon-logger.c
>  tools_btmon_logger_LDADD =3D src/libshared-mainloop.la

Thanks for submitting the fix.
I am guessing ther reason that your email went unnoticed for so long is
that the subject line doesn't have the correct prefix, i.e., [PATCH
BlueZ]. This  prefix has to be used to get attention of BlueZ
maintainers.

Could you please rebase the change (it's been sitting a bit too long
and now has conflicts) and modify the commit title to be prefaced with
"build:" to indicate which part of BlueZ is affected, i.e., something
like:
"build: Fix installation to use pkglibexec_Programs"

Best regards,

Inga

--=-vETqa1S6irshxW2l9GnF
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
k3sf6w6ZKbZbz2V54rncMEXM3N/P4C6ZHZR0XYqh5m1vWxZYYVzTuDEH1C8W+b3KzldrAgMBAAGj
ggIwMIICLDAdBgNVHQ4EFgQUcdzZH9M8OSxLujP+AToiD5oYMRkwHwYDVR0jBBgwFoAU2kEjnFqP
ca9Xgz4g0+Nl2wzLC9swZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5jb20vcmVw
b3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwNEIu
Y3JsMIGeBggrBgEFBQcBAQSBkTCBjjAhBggrBgEFBQcwAYYVaHR0cDovL29jc3AuaW50ZWwuY29t
MGkGCCsGAQUFBzAChl1odHRwOi8vd3d3LmludGVsLmNvbS9yZXBvc2l0b3J5L2NlcnRpZmljYXRl
cy9JbnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBJc3N1aW5nJTIwQ0ElMjA0Qi5jcnQwCwYDVR0P
BAQDAgeAMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIbDjHWEmeVRg/2BKIWOn1OCkcAJZ4He
vTmV8EMCAWQCAQkwHwYDVR0lBBgwFgYIKwYBBQUHAwQGCisGAQQBgjcKAwwwKQYJKwYBBAGCNxUK
BBwwGjAKBggrBgEFBQcDBDAMBgorBgEEAYI3CgMMMEsGA1UdEQREMEKgJwYKKwYBBAGCNxQCA6AZ
DBdpbmdhLnN0b3RsYW5kQGludGVsLmNvbYEXaW5nYS5zdG90bGFuZEBpbnRlbC5jb20wDQYJKoZI
hvcNAQEFBQADggEBALnl11xd+3X6fVS0VAKeoF0jCPLFZLCk4jMFifFzY2md3MLjVIB3lE5ffNnS
mjG9ErOO6as95K6D6hzCJMqNodOyVPRSrMNey0tzFAPLRG3s2bgfmOcvYr4O3WmpDMx8YmH6O2YI
3Xxjyp11aXl5pk6VjpZV/hjN1jwZ/c/X00KsjoMB8mGSBvbwnV0EFQUJ99xsAlqQ4edj2T9z6pF1
WX189YL64c/t3a9LWNaT2CWbBZLIFoor9TpZsIj0lGObmGA76JKn5yxN+jzxhWIAzPi5KKYgJ9EU
FDn6fGbJHisZdWX3bVamfpmPogThm1khlD7R4USu0eyym3JRh0tXJeAxggIXMIICEwIBATCBkDB5
MQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRowGAYDVQQK
ExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWlu
ZyBDQSA0QgITMwAAeRJvGZxlhdnerwAAAAB5EjAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNjAzMjI0NTQ1WjAjBgkqhkiG9w0BCQQxFgQU
hifi92LjBivMQaALGufG6lpFUOUwDQYJKoZIhvcNAQEBBQAEggEAYfyaH/cR6jgHMxx7dglrezxG
pUZlkQO9Cbk36fjzgv586abLTT9+bq3aQOQzxZY8VBuVIkNVp2o08SjooAyIZvYgYLWqQWoBmTGO
70k5+6/JZAnX1PyzF8vLHVjS/VSClQSz44kfH/v1sNN1PAIRhLx6VRGDf7PIQ4JE6e/dyLk6iknD
Fy5YKjZ/1dOwTM/CzcOwJnK7hqx2NmYq7J3J0Jmt4MHlEfJorTa1RyLK5EN/GxWj8MPhMSPH2dzZ
n8715EsFwHo/adwaLeNIgF9qAzxvBcj0j2NVS2rAJHlJkxUt5moWUCd/A3ytzy8FNmqk1+HitHQV
/Tb1YgXxdD93MwAAAAAAAA==


--=-vETqa1S6irshxW2l9GnF--
