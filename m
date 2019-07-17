Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38AEC7618F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 19:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B874F218D3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 19:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfGQTgj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:36:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:33305 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbfGQTgj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 15:36:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 12:36:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,275,1559545200"; 
   d="p7s'?scan'208";a="343136759"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2019 12:36:38 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 17 Jul 2019 12:36:38 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.114]) with mapi id 14.03.0439.000;
 Wed, 17 Jul 2019 12:36:37 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ v5 1/4] mesh: Add ImportLocalNode API documentation
Thread-Topic: [PATCH BlueZ v5 1/4] mesh: Add ImportLocalNode API
 documentation
Thread-Index: AQHVPHrRSRdWVWuYrkOiqop882Ac1KbPqkcA
Date:   Wed, 17 Jul 2019 19:36:36 +0000
Message-ID: <915ea1c10883aaf1e4d42c5a749bfda964b54b51.camel@intel.com>
References: <20190717083650.26346-1-michal.lowas-rzechonek@silvair.com>
         <20190717083650.26346-2-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190717083650.26346-2-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.159.19]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-CaZftizhwAEjUnAkOG1Q"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-CaZftizhwAEjUnAkOG1Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mical, Jakub, Brian...


On Wed, 2019-07-17 at 10:36 +0200, Micha=C5=82 Lowas-Rzechonek wrote:
> From: Jakub Witowski <jakub.witowski@silvair.com>
>=20
> This updates the mesh-api.txt with new ImportLocalNode() API.
> ---
>  doc/mesh-api.txt | 52 ++++++++++++++++++++++++++++++++++++++------
> ----
>  1 file changed, 41 insertions(+), 11 deletions(-)
>=20
> diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
> index 0ac2fdfd1..7c2a1fafa 100644
> --- a/doc/mesh-api.txt
> +++ b/doc/mesh-api.txt
> @@ -151,16 +151,31 @@ Methods:
>  			org.bluez.mesh.Error.InvalidArguments
>  			org.bluez.mesh.Error.AlreadyExists,
> =20
> -	 uint64 token ImportLocalNode(string json_data)
> +	uint64 token ImportLocalNode(object app_root, array{byte}[16]
> uuid,
> +							string
> data_type, array{byte} import_data)


I apologize for the backtracking, but I would like to revisit this API.

I feel like having "object app_root" is unnecessary and also, creates
some gnarly pathways within the code.

What exactly is the problem for requiring the composition data to be
part of the import_data? It's just weird to say "oh, it may be there or
it may be not".

Getting rid of the app_root and mandating the composition to be part of
the import_data allows:

1) Avoid checking whether this is a "full" configuration or the
"minimal" one

2) Efficiently re-use the existing code:
Adding an API call like this one may be sufficient

mesh_config_import(const char *cfg_dir,
                   const uint8_t uuid[16],
                   const uint8 *import_data, <import__len>?,
                   mesh_config_node_func_t cb,
                   void *user_data)

We can just re-factor the code that parses and populates a single node
from the stored configuration. user_data may contain whatever we need
to preserve in order to respond to d-bus call.

> =20
>  		This method creates a local mesh node based on node
>  		configuration that has been generated outside
> bluetooth-meshd.
> =20
> -		The json_data parameter is a full JSON representation
> of a node
> -		configuration file. The format must conform to the
> schema
> -		defined in "Mesh Node Configuration Schema" section.
> Any
> -		included token will be ignored in favor of a locally
> generated
> -		token value.
> +		The app_root parameter is a D-Bus object root path of
> the
> +		application that implements org.bluez.mesh.Application1
> +		interface.
> +
> +		The import_data parameter contains a representation of
> a
> +		provisioned node. Format of this representation depends
> on
> +		value of data_type parameter.
> +
> +		Allowed data_type values are: "json".
> +
> +		When data_type is "json", bluetooth-meshd daemon treats
> +		import_data is a JSON document following <TBD> schema.
> See the
> +		examples at the end of this document.
> +
> +		The import_data parameter can contain either minimal,
> or
> +		complete representation of a provisioned node.
> +
> +		When a complete representation is provided, it is
> validated
> +		against composition data provided by the application.
> =20
>  		The returned token must be preserved by the application
> in
>  		order to authenticate itself to the mesh daemon and
> attach to
> @@ -173,8 +188,8 @@ Methods:
> =20
>  		PossibleErrors:
>  			org.bluez.mesh.Error.InvalidArguments,
> -			org.bluez.mesh.Error.AlreadyExists
> -			org.bluez.mesh.Error.NotFound,
> +			org.bluez.mesh.Error.AlreadyExists,
> +			org.bluez.mesh.Error.NotSupported,
>  			org.bluez.mesh.Error.Failed
> =20
>  Mesh Node Hierarchy
> @@ -1064,6 +1079,21 @@ Properties:
>  		Uniform Resource Identifier points to out-of-band (OOB)
>  		information (e.g., a public key)
> =20
> -Mesh Node Configuration Schema
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -<TBD>
> +Mesh Node Configuration Examples
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Minimal JSON representation for ImportLocalNode():
> +
> +{
> +	"IVindex":0,
> +	"IVupdate":0,
> +	"unicastAddress":"0012",
> +	"deviceKey":"7daa45cd1e9e11a4b86eeef7d01efa11",
> +	"netKeys":[
> +		{
> +			"index":"0000",
> +			"key":"2ddfef86d67144c394428ea3078f86f9",
> +			"keyRefresh":0
> +		}
> +	],
> +	"sequenceNumber":15  /* optional */
> +}

Regards, Inga

--=-CaZftizhwAEjUnAkOG1Q
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNzE3MTkzNjM2WjAjBgkqhkiG9w0BCQQxFgQU
BG6dVACujfVfxGFPWxDQUxGPO9EwDQYJKoZIhvcNAQEBBQAEggEAJKht1w7qUswNxN3zaKrXF1I1
wFcxYKFe3IG3d1PdpxW+YqyWV6bjUkSdQmuPuYvuHKfI3mhmC6hcrJaCPFunWdLmEH6UNzS2JvwS
+7/YjjaLbXdfUlax+bpQMQuYz3u/Wgesbfl0qetdS5sAHdsL58P2qEtqzLxXsYxjbCd2TK/bNchC
+dYE3lsXXtHb/eTeXiglntYC38eQSUL4MSSRwXk+FXsJMUuDonADBOdTLhUPB+rn8C0Rw1lMlvR+
0jpM7IQqc58MorICve+a9kFZRtqv2m2OfNpXL9VuvKhCwU3ExPrB0i/qTDv3WRNaumxFsFT5H10+
AGCUPJiTEdo4mQAAAAAAAA==


--=-CaZftizhwAEjUnAkOG1Q--
