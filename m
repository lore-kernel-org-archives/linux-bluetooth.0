Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3866BC7618B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B15208C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 14:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfGZOYs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:24:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:28022 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfGZOYr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jul 2019 10:24:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 07:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="p7s'?scan'208";a="161320707"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2019 07:24:46 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.29]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.170]) with mapi id 14.03.0439.000;
 Fri, 26 Jul 2019 07:24:46 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ v6 0/5] Use composition data to validate app
 against the
Thread-Topic: [PATCH BlueZ v6 0/5] Use composition data to validate app
 against the
Thread-Index: AQHVQ3xvBn6rMzF7yUOrj0zlGROxhqbdah6A
Date:   Fri, 26 Jul 2019 14:24:45 +0000
Message-ID: <6a64704d5d247f969758149a0df77c4465aadade.camel@intel.com>
References: <20190726063606.19359-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190726063606.19359-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.41.210]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-E2cqHTIRKQq5igTHQrDI"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-E2cqHTIRKQq5igTHQrDI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Fri, 2019-07-26 at 08:36 +0200, Micha=C5=82 Lowas-Rzechonek wrote:
> Thanks for your patience :)
>=20
> + Fix brace style
> + Fix comment style
> + Fix typo when assigning element paths in attach_req_node
> + Fix setting app_path and owner during Attach()
> + Fix typo CompanyID property validation
> + Added comments about temporary node usage during Attach()
> + Keep element's Location property optional according to API
>   documentation
>=20
> ---
>=20
> This patchset streamlines app validation by creating a temporary node
> during Attach, Join and CreateNetwork calls, then validating its
> composition data to:
>  - fit in Config Model Composition Data Get message
>  - declare mandatory models on primary element
>  - declare consecutive element indexes
>=20
> During Attach call, temporary composition data is also compared with
> data generated for existing node, guaranteeing immutablity required
> by
> the specification.
>=20
> Micha=C5=82 Lowas-Rzechonek (5):
>   mesh: Convert void pointers to anonymous unions in
> managed_obj_request
>   mesh: Validate application by comparing composition data
>   mesh: Keep element and model lists sorted and unique
>   mesh: Check that element indexes are consecutive
>   mesh: Check that config server is present in primary element
>=20
>  mesh/mesh-defs.h |   2 +
>  mesh/node.c      | 556 ++++++++++++++++++++++++---------------------
> --
>  2 files changed, 290 insertions(+), 268 deletions(-)
>=20

The patch set looks good.
Thanks,
Inga

--=-E2cqHTIRKQq5igTHQrDI
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNzI2MTQyNDQ1WjAjBgkqhkiG9w0BCQQxFgQU
3BJ3qVh7nteE0Pc8xDzucJMAT60wDQYJKoZIhvcNAQEBBQAEggEAFwXa122TnNnnnS0+lG3T0LTL
1gujNWgMcgFfyYPbQkhAwLSMDXa3Y51FZS8najxAKrBCvo4035Umgm0t1kvD9xxgjdTxrakPx4GA
b/KdQoA0FRvW05DJqUHzo1pnD+iMJCLMOmgH1i5AdLYsT0zWGW+M7H7x2xALTPJaBPRRQpSyxFCz
R4edjYQ6QwPTz3aFkOdvfWK9+xF3OogP+hY3Dr9qKsnyB+lSCaFqy1P4zUBQrqStMAMSN8v4PJw+
BUXs5sK1OLu82UuoqEj7Mj+Psr3lqNh1KwnJqtxhAqXumN/PpapTM9Gz6K4Ifg/J2gCkhGri4BEa
iIpr2PovH1ywHwAAAAAAAA==


--=-E2cqHTIRKQq5igTHQrDI--
