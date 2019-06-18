Return-Path: <SRS0=UCBE=UR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51072C31E5B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 15:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8AB20673
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 15:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfFRPtv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:49:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:28849 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbfFRPtv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jun 2019 11:49:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 08:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,389,1557212400"; 
   d="p7s'?scan'208";a="170263491"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga002.jf.intel.com with ESMTP; 18 Jun 2019 08:49:50 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Jun 2019 08:49:50 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX121.amr.corp.intel.com ([169.254.10.250]) with mapi id 14.03.0439.000;
 Tue, 18 Jun 2019 08:49:50 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Clean up includes
Thread-Topic: [PATCH BlueZ] mesh: Clean up includes
Thread-Index: AQHVJVUZfzUwJDVn802Jjyb6kK5cYqahe6CAgACJ+AA=
Date:   Tue, 18 Jun 2019 15:49:49 +0000
Message-ID: <6b160fc3a67b72495bd533a884ae7edd2d39c47b.camel@intel.com>
References: <20190617213847.21705-1-inga.stotland@intel.com>
         <20190618073559.tmpaj2oellkf5354@mlowasrzechonek2133>
In-Reply-To: <20190618073559.tmpaj2oellkf5354@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.137.5]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-w7iVM/j2rtAPzrBkt7YX"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-w7iVM/j2rtAPzrBkt7YX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Tue, 2019-06-18 at 09:35 +0200, Micha=C5=82 Lowas-Rzechonek wrote:
> Hi Inga,
>=20
> On 06/17, Inga Stotland wrote:
> > This adds #include for json-c/json.h in mesh-db.h and removes this
> > include from the other files that don't need to reference json-c.
>=20
> While I agree about removal from cfgmod-server, model and node, I
> don't
> think we should remove the include from storage and move it to mesh-
> db.
>=20
> I'd rather see #includes follow https://include-what-you-use.org/
> approach, that is:
>=20
>     (...) for every symbol (type, function variable, or macro) that
> you
>     use in foo.cc, either foo.cc or foo.h should #include a .h file
> that
>     exports the declaration of that symbol.
>=20
> Moreover, I think headers should only be included as-needed (mostly
> in
> .c files), and headers should contain forward declarations of various
> types, to make them opaque.
>=20
> Such an approach cuts implicit dependencies, making code maintenance
> easier: when, for example, someone decides to refactor mesh-db not to
> use json_object anymore, they shouldn't need to suddenly deal with
> missing declarations in other modules (in this case, storage).
>=20
> Moreover, each header should be self-sufficient: in order to use API
> exposed by a given header, it should be enough to include that header
> only. At the moment, this is not the case.
>=20
> A minor side-effect would be faster builds and less rebuilds when
> code
> is being worked on.
>=20
> If you agree, I am more than happy to fix this throughout the mesh/
> codebase.
>=20

I don't disagree, this was sort of an "intermediate" patch. I'd prefer
to remove the reference to json from storage.c and the rest of the code
 and localize it in only one file that would deal with json-related
processing.

So I might just as well go ahead and make mesh-db.h a generic API to
allow for different storage formats (even though for now we have only
json defined format).

Best regards,

Inga

--=-w7iVM/j2rtAPzrBkt7YX
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNjE4MTU0OTQ4WjAjBgkqhkiG9w0BCQQxFgQU
WpBozvuYhCTf0C+aEeEYF5fNN5swDQYJKoZIhvcNAQEBBQAEggEADKtAWk9qSRAK0beIcAE88k5w
3laM/s55Du9ndFJ/A39AFdzoCP4fzahvoegNbYfVXljrwQUJsxwupOwlbBC7v5E2ftf38lI7ps/9
T2/ftEvtTTjiU9cwz+lFMwdsn2q6T2vxo/k0IHzSjfZwBpJibc4eE9j3TJrcucjbSp8Y73+nINp6
q5SCDSiuLFPluHIYzkNh6KZ2/eW5eak5EaP9oUozhoOnvSv+rNP45GvYdWdrYH9GyoFm3s+R85HR
A3JBAg3khM/Z8zFOLakSl1vgllTn3p9Q/5GeR315jTVCIdP+kXt9aHM2rNu1ScrQ0zWd8FfZRWFR
2hazqhiRPzLdeQAAAAAAAA==


--=-w7iVM/j2rtAPzrBkt7YX--
