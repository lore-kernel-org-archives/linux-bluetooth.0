Return-Path: <SRS0=CXZ/=PT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32A4C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 22:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9422084C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 22:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfAKW52 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:57:28 -0500
Received: from mga07.intel.com ([134.134.136.100]:38366 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAKW51 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jan 2019 17:57:27 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 14:51:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,467,1539673200"; 
   d="p7s'?scan'208";a="127011245"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga001.jf.intel.com with ESMTP; 11 Jan 2019 14:51:25 -0800
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 11 Jan 2019 14:51:25 -0800
Received: from orsmsx106.amr.corp.intel.com ([169.254.1.179]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.248]) with mapi id 14.03.0415.000;
 Fri, 11 Jan 2019 14:51:24 -0800
From:   "An, Tedd" <tedd.an@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ] tools/btproxy: Update options list in help
Thread-Topic: [PATCH BlueZ] tools/btproxy: Update options list in help
Thread-Index: AQHUqgAtayhB0jY0+kW3zQvmDBnw1A==
Date:   Fri, 11 Jan 2019 22:51:24 +0000
Message-ID: <574756600dfe0748c19d4eeae88392ee9f477b63.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.9.31]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-nOyWgKm7VrHg0xdTuDsB"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-nOyWgKm7VrHg0xdTuDsB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates help content with all available options.
---
 tools/btproxy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index fb67a5735..b3b22ec23 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -746,6 +746,7 @@ static void usage(void)
 		"Usage:\n");
 	printf("\tbtproxy [options]\n");
 	printf("Options:\n"
+		"\t-r, --redirect              Use redirect\n"
 		"\t-c, --connect <address>     Connect to server\n"
 		"\t-l, --listen [address]      Use TCP server\n"
 		"\t-u, --unix [path]           Use Unix server\n"
@@ -753,7 +754,9 @@ static void usage(void)
 		"\t-i, --index <num>           Use specified
controller\n"
 		"\t-a, --amp                   Create AMP controller\n"
 		"\t-e, --ecc                   Emulate ECC support\n"
+		"\t-z, --skip                  Skip the first zero\n"
 		"\t-d, --debug                 Enable debugging
output\n"
+		"\t-v, --version               Show version\n"
 		"\t-h, --help                  Show help options\n");
 }
=20
@@ -766,6 +769,7 @@ static const struct option main_options[] =3D {
 	{ "index",    required_argument, NULL, 'i' },
 	{ "amp",      no_argument,       NULL, 'a' },
 	{ "ecc",      no_argument,       NULL, 'e' },
+	{ "skip",     no_argument,       NULL, 'z' },
 	{ "debug",    no_argument,       NULL, 'd' },
 	{ "version",  no_argument,       NULL, 'v' },
 	{ "help",     no_argument,       NULL, 'h' },
--=20
2.17.2


--=-nOyWgKm7VrHg0xdTuDsB
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
mQ8Nc0cf8YX0KNe9Se45mSuRf2YGFxOoGeRs3dBfMxaq4MTS4Zu1AgMBAAGjggIlMIICITAdBgNV
HQ4EFgQU2lrTUsaOQ+pzCNc1GXgG/yV5/5owHwYDVR0jBBgwFoAU2kEjnFqPca9Xgz4g0+Nl2wzL
C9swZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9DUkwv
SW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwNEIuY3JsMIGfBggrBgEF
BQcBAQSBkjCBjzAiBggrBgEFBQcwAYYWaHR0cDovL29jc3AuaW50ZWwuY29tLzBpBggrBgEFBQcw
AoZdaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBF
eHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwNEIuY3J0MAsGA1UdDwQEAwIHgDA8Bgkr
BgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJ
MB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsGAQQBgjcVCgQcMBowCgYIKwYB
BQUHAwQwDAYKKwYBBAGCNwoDDDA/BgNVHREEODA2oCEGCisGAQQBgjcUAgOgEwwRdGVkZC5hbkBp
bnRlbC5jb22BEXRlZGQuYW5AaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQA4uDaGiZq6z9ib
GrjiOAznkFzELLICrPuNm1qPY6X1ZQBBCCN3Gh3TlSCZCd1Sz31/3nQBmlisuERbNuPUnc9LHu1n
ymIZs2rKk1E6Wcq9KoA6XkKN5Tl0FfDHKV+kjI5zAf6P8xPqblW50sJDZelHbbxFFTDu073N4lZj
9t8JU17xSIDbdBuzQv1j2BZfbVZ9EnFoPMJpvyNtNAoiNmPbp/6p/YAvrU7fZyCgFnAqojvO9zHQ
jQamlfkgbxKXE5Q/E4kpgRAJ7uK17oV0wI2m8Qe46HQd3VtU4gQwcMB9SovpfX4yKlB1Bq4W1/N5
8nuXiGqxR0eJnF51x1AKmQ2BMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgT
AkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzAp
BgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEICEzMAAHC9gKttJzlJhwIA
AAAAcL0wCQYFKw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE5MDExMTIyNTEyMlowIwYJKoZIhvcNAQkEMRYEFIZi1xhJ/zx5HhCiLH+dTg3pflLLMA0G
CSqGSIb3DQEBAQUABIIBAEwXtUI9eKQ77P0fqyS7nRPMDJsxQ8Oc/DUBkXpQ8idViE27DCU9dlOi
8l743RuUzUoZkj6GTvgP2VodfeivOUgfjMDyhqWUEiaPJFaFFBAOmDr1MxKJmAwDsN7vPeTVdQb2
pTBj+tylFSUpgw1wJSbRFgQHNIe4hbVwUbn2h9wqvVx5rDF21UbKIksRAR2dErp5dHF8WxkDhYNe
IANz2DWbPNj3DSHbjLTLphlreJp4YVKRJ7XhYHKJLEMubuNqDqngoPvNM3LtpsbAZt2ijzdRdag9
qyG/gmhUzXeROmKp7FRudiQaeE9hrOA6b9f+fohyXan9ryUkr2CHEsZDRPIAAAAAAAA=


--=-nOyWgKm7VrHg0xdTuDsB--
