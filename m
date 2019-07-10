Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683B2C73C7C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 07:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0A620651
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 07:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfGJHiM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:38:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:55103 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfGJHiM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 03:38:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 00:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
   d="p7s'?scan'208";a="170835510"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2019 00:38:11 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.65]) with mapi id 14.03.0439.000;
 Wed, 10 Jul 2019 00:38:11 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ v4 1/4] mesh: Add ImportLocalNode api documentation
Thread-Topic: [PATCH BlueZ v4 1/4] mesh: Add ImportLocalNode api
 documentation
Thread-Index: AQHVNj8+AzUm65x0BkK7GV8qht700abD7ayA
Date:   Wed, 10 Jul 2019 07:38:10 +0000
Message-ID: <3b87bcfc2659702f998ea32c717e0adbd84dafe8.camel@intel.com>
References: <20190709101522.10623-1-jakub.witowski@silvair.com>
In-Reply-To: <20190709101522.10623-1-jakub.witowski@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.91.91]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-scIGqsOXa39c1GQOma1V"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-scIGqsOXa39c1GQOma1V
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Tue, 2019-07-09 at 12:15 +0200, Jakub Witowski wrote:
> This updates the mesh-api.txt with new ImportLocalNode() API.
> ---
>  doc/mesh-api.txt | 104 ++++++++++++++++++++++++++++++++++++++++++---
> --
>  1 file changed, 93 insertions(+), 11 deletions(-)
>=20
> diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
> index 893a1a6c0..f2ba164a9 100644
> --- a/doc/mesh-api.txt
> +++ b/doc/mesh-api.txt
> @@ -151,16 +151,36 @@ Methods:
>  			org.bluez.mesh.Error.InvalidArguments
>  			org.bluez.mesh.Error.AlreadyExists,
> =20
> -	 uint64 token ImportLocalNode(string json_data)
> +	uint64 token ImportLocalNode(object app_root, array{byte}[16]
> uuid,
> +							string
> data_type, array{byte} import_data)
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
> +		interface, and a org.bluez.mesh.Provisioner1 interface.

"the application that implements org.bluez.mesh.Application1 interface"
I don't think that supporting Provisioner1 interface is a requirement?

> +
> +		The data_type parameter defines the import_data type.
> Supported
> +		data_type parameters:

"The following values are supported:"

> +			- =E2=80=9Cjson=E2=80=9D
> +
> +		The import_data parameter can be either:
> +			- Simplified representation of node
> configuration with
> +			  provisioning data only
> +			- Full representation of node configuration
> with both
> +			  provisioning and composition data
> +
> +		sequenceNumber parameter int the import_data is
> optional.
> +
> +		The format must conform to the schema defined in
> +		"Mesh Node Configuration Examples" section. Any
> included token will
> +		be ignored in favor of a locally generated token value.
> If
> +		import_data contains composition data (determined by
> the presence of
> +		Elements) it is validated against composition data
> provided by
> +		the application. Otherwise, new node is created based
> on
> +		composition data provided by the application using
> provisioning data
> +		from import_data parameter.
> =20


The description of import_data parameter needs to be re-written.
The above description is too skewed towards JSON format and imo is more
detiled than needed.

we definitely need to mention that the interpretation of the
import_data parameter depends on the value of data_type. Then we can
say that "for the case when data_type has value "json", the import_data
contains a string that describes node configuration in JSOn notation,
following the <TBD> schema. See the examples at the end of this
documents." =20



>  		The returned token must be preserved by the application
> in
>  		order to authenticate itself to the mesh daemon and
> attach to
> @@ -173,8 +193,8 @@ Methods:
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
> @@ -1061,6 +1081,68 @@ Properties:
>  		Uniform Resource Identifier points to out-of-band (OOB)
>  		information (e.g., a public key)
> =20
> -Mesh Node Configuration Schema
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -<TBD>


Line break
> +Mesh Node Configuration Examples
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Example of Json format for ImportLocalNode():


Minimum required configuration:
> +	{
> +		"IVindex":0,
> +		"IVupdate":0,
> +		"unicastAddress":"0012",
> +		"deviceKey":"7daa45cd1e9e11a4b86eeef7d01efa11",
> +		"netKeys":[
		"sequenceNumber":15
No sequence number

> +		{
> +			"index":"0000",
> +			"key":"2ddfef86d67144c394428ea3078f86f9",
> +			"keyRefresh":0
> +		}]
> +	}
> +
> +	Import full node operation:
> +	{
> +		"cid":"fee5",
> +		"crpl":"2710",
> +		"relay":{
> +			"mode":"disabled",
> +			"count":0,
> +			"interval":0
> +		},
> +		"lowPower":"unsupported",
> +		"friend":"unsupported",
> +		"proxy":"unsupported",
> +		"beacon":"disabled",
> +		"defaultTTL":255,
> +		"elements":[
> +		{
> +			"elementIndex":0,
> +			"location":"002a",
> +			"models":[
> +			{
> +				"modelId":"0008",
> +				"bind":[
> +				"0000"]
> +			}]
> +		}],
> +		"IVindex":0,
> +		"IVupdate":0,
> +		"unicastAddress":"0010",
>=20
		"token":"bba7c60afaa85fc1",

No token
> +		"deviceKey":"56325fd145f3d5eee1b82136dc3e1454",
> +		"netKeys":[
> +		{
> +			"index":"0000",
> +			"key":"2ddfef86d67144c394428ea3078f86f9",
> +			"keyRefresh":0
> +		}],
> +		"appKeys":[
> +		{
> +			"index":"0000",
> +			"boundNetKey":"0000",
> +			"key":"43886b02ca4343beaae26dc4b6773ba4"
> +		}],
> +		"sequenceNumber":15

no sequence number
> +	}


Actually, I don't like the full configuration exmple. It's not realy
"full". Better to provide a schema. We'll get to the schema in time.


--=-scIGqsOXa39c1GQOma1V
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNzEwMDczODA1WjAjBgkqhkiG9w0BCQQxFgQU
spBgN5M9tfJW1q7qPV6uME1jMx4wDQYJKoZIhvcNAQEBBQAEggEAO7S70Y9RqD5IzYexL8erCfZg
n+f1slpqW1v27D0dhXd9Vxs+KpP2zpOzFVyfLJOLBrDvkjDpqQljnSxweAXsgYquHNMOzuhtPEhn
/hLDB7UmnMJyRPytS//b7nzNWvecdLFyvR6yuuvriFmL2qdSct5/+L9ojbwm0mwYeHg88yh2OTxu
qwNNwVSsRveXH26OlfKa9hCnvihVuGkbbfzd/TiVMHqu/4timQvqIaDnQfvnY/fX4RG4TTrk7Ilg
ItUry53LbRKryyYCsvHxNoVTwpsmjEWekKQVaQXTryA88S95h97/p8qVVFAfxcwQP+xHsUsHtANu
P8NiKt/RQdLPFAAAAAAAAA==


--=-scIGqsOXa39c1GQOma1V--
