Return-Path: <SRS0=p1bJ=U7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE75C5B57D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 05:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B502721479
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 05:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfGBFYB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Jul 2019 01:24:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:35925 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfGBFYA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Jul 2019 01:24:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 22:23:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,442,1557212400"; 
   d="p7s'?scan'208";a="166063799"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga003.jf.intel.com with ESMTP; 01 Jul 2019 22:23:35 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jul 2019 22:23:34 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX123.amr.corp.intel.com ([169.254.1.46]) with mapi id 14.03.0439.000;
 Mon, 1 Jul 2019 22:23:34 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] mesh: Allow to set-up the CRPL with application
Thread-Topic: [PATCH] mesh: Allow to set-up the CRPL with application
Thread-Index: AQHVMAIfSSEJOTZgEEqXsSD6WFMDw6a3QeUA
Date:   Tue, 2 Jul 2019 05:23:33 +0000
Message-ID: <c043adad8ba346ab95278d753be314cea54ec83e.camel@intel.com>
References: <20190701114239.8792-1-jakub.witowski@silvair.com>
In-Reply-To: <20190701114239.8792-1-jakub.witowski@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.207.138]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-0S/YZf1fDba4DdqdE0lD"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-0S/YZf1fDba4DdqdE0lD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Mon, 2019-07-01 at 13:42 +0200, Jakub Witowski wrote:
> This implementation adds possibility of adding CRPL to the node
> via application in the same way as CIP VID or PID.

Basically, you're exposing CRPL as a property so let's rephrase
the commit message as something like:
"This adds an optional CRPL property to org.bluez.mesh.Application1
interface, allowing to indicate the depth of reply protection list."

> ---
>  doc/mesh-api.txt |  4 ++++
>  mesh/node.c      | 12 ++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
> index 4e0a8bff1..45fc431fa 100644
> --- a/doc/mesh-api.txt
> +++ b/doc/mesh-api.txt
> @@ -724,6 +724,10 @@ Properties:
> =20
>  		A 16-bit vendor-assigned product version identifier
> =20
> +	uint16 CRPL [read-only]

[read-only] -> [read-only, optional]

I'd prefer this to be an optional property. If not found, the daemon
uses its default setting (see comment below)

> +
> +		A 16-bit reply protection value

 A 16-bit minimum number of replay protection list entries

> +
> =20
>  Mesh Element Hierarchy
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/mesh/node.c b/mesh/node.c
> index 4e35bb3ff..9372d540a 100644
> --- a/mesh/node.c
> +++ b/mesh/node.c
> @@ -55,7 +55,6 @@
>  /* Default element location: unknown */
>  #define DEFAULT_LOCATION 0x0000
> =20
> -#define DEFAULT_CRPL 10

Let's keep the default value and make the property optional.

>  #define DEFAULT_SEQUENCE_NUMBER 0
> =20
>  #define REQUEST_TYPE_JOIN 0
> @@ -1302,7 +1301,6 @@ static void set_defaults(struct mesh_node
> *node)
>  	if (!node->comp)
>  		node->comp =3D l_new(struct node_composition, 1);
> =20
> -	node->comp->crpl =3D DEFAULT_CRPL;

Let's remove the node->comp allocation here altogether.
Instead, in get_app_properties, add the default value setting:

if (is_new) {
  	node->comp =3D l_new(struct node_composition, 1);
	node->comp->crpl =3D DEFAULT_CRPL;
}

If CRPL property is present, the default is overwritten.

>  	node->lpn =3D MESH_MODE_UNSUPPORTED;
>  	node->proxy =3D MESH_MODE_UNSUPPORTED;
>  	node->friend =3D MESH_MODE_UNSUPPORTED;
> @@ -1359,6 +1357,16 @@ static bool get_app_properties(struct
> mesh_node *node, const char *path,
>  				return false;
> =20
>  			node->comp->vid =3D value;
> +
> +		} else if (!strcmp(key, "CRPL")) {
> +			if (!l_dbus_message_iter_get_variant(&variant,
> "q",
> +								=09
> &value))
> +				return false;
> +
> +			if (!is_new && node->comp->crpl !=3D value)
> +				return false;
> +
> +			node->comp->crpl =3D value;
>  		}
>  	}
> =20

--=-0S/YZf1fDba4DdqdE0lD
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKbDCCBOsw
ggPToAMCAQICEDabxALowUBS+21KC0JI8fcwDQYJKoZIhvcNAQEFBQAwbzELMAkGA1UEBhMCU0Ux
FDASBgNVBAoTC0FkZFRydXN0IEFCMSYwJAYDVQQLEx1BZGRUcnVzdCBFeHRlcm5hbCBUVFAgTmV0
d29yazEiMCAGA1UEAxMZQWRkVHJ1c3QgRXh0ZXJuYWwgQ0EgUm9vdDAeFw0xMzEyMTEwMDAwMDBa
Fw0yMDA1MzAxMDQ4MzhaMHkxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEUMBIGA1UEBxMLU2Fu
dGEgQ2xhcmExGjAYBgNVBAoTEUludGVsIENvcnBvcmF0aW9uMSswKQYDVQQDEyJJbnRlbCBFeHRl
cm5hbCBCYXNpYyBJc3N1aW5nIENBIDRCMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
yzuW/y/g0bznz8BD48M94luFzqHaqY9yGN9H/W0J7hOVBpl0rTQJ6kZ7z7hyDb9kf2UW4ZU25alC
i+q5m6NwHg+z9pcN7bQ84SSBueaYF7cXlAg7z3XyZbzSEYP7raeuWRf5fYvYzq8/uI7VNR8o/43w
PtDP10YDdO/0J5xrHxnC/9/aU+wTFSVsPqxsd7C58mnu7G4VRJ0n9PG4SfmYNC0h/5fLWuOWhxAv
6MuiK7MmvTPHLMclULgJqVSqG1MbBs0FbzoRHne4Cx0w6rtzPTrzo+bTRqhruaU18lQkzBk6OnyJ
UthtaDQIlfyGy2IlZ5F6QEyjItbdKcHHdjBX8wIDAQABo4IBdzCCAXMwHwYDVR0jBBgwFoAUrb2Y
ejS0Jvf6xCZU7wO94CTLVBowHQYDVR0OBBYEFNpBI5xaj3GvV4M+INPjZdsMywvbMA4GA1UdDwEB
/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMDYGA1UdJQQvMC0GCCsGAQUFBwMEBgorBgEEAYI3
CgMEBgorBgEEAYI3CgMMBgkrBgEEAYI3FQUwFwYDVR0gBBAwDjAMBgoqhkiG+E0BBQFpMEkGA1Ud
HwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwudHJ1c3QtcHJvdmlkZXIuY29tL0FkZFRydXN0RXh0ZXJu
YWxDQVJvb3QuY3JsMDoGCCsGAQUFBwEBBC4wLDAqBggrBgEFBQcwAYYeaHR0cDovL29jc3AudHJ1
c3QtcHJvdmlkZXIuY29tMDUGA1UdHgQuMCygKjALgQlpbnRlbC5jb20wG6AZBgorBgEEAYI3FAID
oAsMCWludGVsLmNvbTANBgkqhkiG9w0BAQUFAAOCAQEAp9XGgH85hk/3IuN8F4nrFd24MAoau7Uq
M/of09XtyYg2dV0TIPqtxPZw4813r78WwsGIbvtO8VQ18dNktIxaq6+ym2zebqDh0z6Bvo63jKE/
HMj8oNV3ovnuo+7rGpCppcda4iVBG2CetB3WXbUVr82EzECN+wxmC4H9Rup+gn+t+qeBTaXulQfV
TYOvZ0eZPO+DyC2pVv5q5+xHljyUsVqpzsw89utuO8ZYaMsQGBRuFGOncRLEOhCtehy5B5aCI571
i4dDAv9LPODrEzm3PBfrNhlp8C0skak15VXWFzNuHd00AsxXxWSUT4TG8RiAH61Ua5GXsP1BIZwl
4WjK8DCCBXkwggRhoAMCAQICEzMAAHkSbxmcZYXZ3q8AAAAAeRIwDQYJKoZIhvcNAQEFBQAweTEL
MAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMR
SW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3Vpbmcg
Q0EgNEIwHhcNMTkwMzI4MTgzOTA4WhcNMjAwMzIyMTgzOTA4WjBBMRcwFQYDVQQDEw5TdG90bGFu
ZCwgSW5nYTEmMCQGCSqGSIb3DQEJARYXaW5nYS5zdG90bGFuZEBpbnRlbC5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQC2G5M/W8NZAZ4TJB1BMvVCtoUmCavUkUo2lw8xY/EZcyre
fgklUGbk5bVeALgRgWOy/STHNpXu+LxzDICt0uPhoVrpz3WPF8akFdIve4IYMZJ3vkFOeiclseLw
Yqg3zQTabz5Z1XMx/iq2MJmC8MUdrovdLGNacPM6+dJWVsslFOBO3vuSaypGKXmKdy8vfSIXX6vK
f5VlWW2Gi3WRHfuyuWtnEJbkoPLtydTNvBzqLpe8QmcM5wXio8/mZfnPDDWR8I1FO8MWzQF6rG00
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNzAyMDUyMzMwWjAjBgkqhkiG9w0BCQQxFgQU
MBzZ3lMfV5l0HKQVbmrLBx4Vyy8wDQYJKoZIhvcNAQEBBQAEggEAr7QSnb/cTI/F+t5bRkOQaq81
yngeRXXhebnaHJEu+E5/rRbNz3SPaszWFiAPy6Y9Bn6apy4cgs2o31L77cQV6DfN8JT4CRprgXSI
Yx6w8J9Uai+8aHojnY1VEyN1TL95LpIo0ODJ58cTDKSQL1xTPecj3ObbiUWruPuN2QKNQjuUnwXa
Oj+/fNlzsfgcfaBh8rplbl2kPmIDWE5XsATHrRiRbBtZEXetedXU/2R+7/24DNKLYIlotEmaEe/C
n8EDP4LJNyOzveprlmmbrJiCQhp8wZzmKolJ55DjgfCyRli6oP0tKf7EWKcS8Uw6YmTz/ss1MIlS
Nwx6S5X4CPPQ/wAAAAAAAA==


--=-0S/YZf1fDba4DdqdE0lD--
