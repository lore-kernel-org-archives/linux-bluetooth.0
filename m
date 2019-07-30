Return-Path: <SRS0=cftP=V3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA23C32750
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jul 2019 23:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0AE206A2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jul 2019 23:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfG3XSJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:18:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:59875 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfG3XSJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jul 2019 19:18:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 16:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="p7s'?scan'208";a="191069011"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2019 16:18:08 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.29]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.170]) with mapi id 14.03.0439.000;
 Tue, 30 Jul 2019 16:18:07 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ v6 1/3] mesh: Extract read_* functions in
 mesh-config-json
Thread-Topic: [PATCH BlueZ v6 1/3] mesh: Extract read_* functions in
 mesh-config-json
Thread-Index: AQHVRhNIYJrBBkPOhESzHIm3oi0086bkQ0mA
Date:   Tue, 30 Jul 2019 23:18:07 +0000
Message-ID: <5805488b1228a044dd5c9261b7fafd53acdd467b.camel@intel.com>
References: <20190729134047.21033-1-michal.lowas-rzechonek@silvair.com>
         <20190729134047.21033-2-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190729134047.21033-2-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.229.74]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-6OsKnQ+fCQROjZ9UBo/H"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-6OsKnQ+fCQROjZ9UBo/H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Mon, 2019-07-29 at 15:40 +0200, Micha=C5=82 Lowas-Rzechonek wrote:
> From: Jakub Witowski <jakub.witowski@silvair.com>
>=20
> This is a small improvement of read_node function readability.
> ---
>  mesh/mesh-config-json.c | 68 +++++++++++++++++++++++++++++--------
> ----
>  1 file changed, 49 insertions(+), 19 deletions(-)
>=20
> diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
> index e3baf5dc6..c63883a3d 100644
> --- a/mesh/mesh-config-json.c
> +++ b/mesh/mesh-config-json.c
> @@ -297,6 +297,51 @@ static json_object *jarray_key_del(json_object
> *jarray, int16_t idx)
>  	return jarray_new;
>  }
> =20
> +static bool read_unicast_address(json_object *jobj,
> +							uint16_t
> *unicast)
> +{
> +	json_object *jvalue;
> +	char *str;
> +
> +	if (!json_object_object_get_ex(jobj, "unicastAddress",
> &jvalue))
> +		return false;
> +
> +	str =3D (char *)json_object_get_string(jvalue);
> +	if (sscanf(str, "%04hx", unicast) !=3D 1)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool read_default_ttl(json_object *jobj,
> +								uint8_t
> *ttl)
> +{
> +	json_object *jvalue;
> +	int val;
> +
> +	if (!json_object_object_get_ex(jobj, "defaultTTL", &jvalue))
> +		return false;
> +
> +	val =3D json_object_get_int(jvalue);
> +
> +	if (val < 0 || val =3D=3D 1 || val > DEFAULT_TTL)
> +		return false;

New line here to separate from "if" statement

> +	*ttl =3D (uint8_t) val;
> +
> +	return true;
> +}
> +
> +static bool read_seq_number(json_object *jobj, uint32_t *seq_number)
> +{
> +	json_object *jvalue;
> +
> +	if (!json_object_object_get_ex(jobj, "sequenceNumber",
> &jvalue))
> +		return false;
> +
> +	*seq_number =3D json_object_get_int(jvalue);
> +	return true;
> +}
> +
>  static bool read_iv_index(json_object *jobj, uint32_t *idx, bool
> *update)
>  {
>  	int tmp;
> @@ -424,7 +469,7 @@ fail:
>  	return false;
>  }
> =20
> -static bool read_net_keys(json_object *jobj,  struct
> mesh_config_node *node)
> +static bool read_net_keys(json_object *jobj, struct mesh_config_node
> *node)
>  {
>  	json_object *jarray;
>  	int len;
> @@ -1294,7 +1339,6 @@ static bool read_net_transmit(json_object
> *jobj, struct mesh_config_node *node)
>  static bool read_node(json_object *jnode, struct mesh_config_node
> *node)
>  {
>  	json_object *jvalue;
> -	char *str;
> =20
>  	if (!read_iv_index(jnode, &node->iv_index, &node->iv_update)) {
>  		l_info("Failed to read IV index");
> @@ -1318,25 +1362,11 @@ static bool read_node(json_object *jnode,
> struct mesh_config_node *node)
> =20
>  	parse_features(jnode, node);
> =20
> -	if (!json_object_object_get_ex(jnode, "unicastAddress",
> &jvalue)) {
> -		l_info("Bad config: Unicast address must be present");
> -		return false;
> -	}
> -
> -	str =3D (char *)json_object_get_string(jvalue);
> -	if (sscanf(str, "%04hx", &node->unicast) !=3D 1)
> -		return false;
> -
> -	if (json_object_object_get_ex(jnode, "defaultTTL", &jvalue)) {
> -		int ttl =3D json_object_get_int(jvalue);
> +	read_unicast_address(jnode, &node->unicast);
> =20

The return status needs to be checked: unicast must be present


> -		if (ttl < 0 || ttl =3D=3D 1 || ttl > DEFAULT_TTL)
> -			return false;
> -		node->ttl =3D (uint8_t) ttl;
> -	}
> +	read_default_ttl(jnode, &node->ttl);
> =20
I would prefer to keep ttl and sequesnce number parsing as they are
now:
they are not mandatory, but we don't want to allow for bad format,
i.e., we dont want to fail if the fields are absent, but we do want to
fail if the format is wrong.

> -	if (json_object_object_get_ex(jnode, "sequenceNumber",
> &jvalue))
> -		node->seq_number =3D json_object_get_int(jvalue);
> +	read_seq_number(jnode, &node->seq_number);
> =20
>  	/* Check for required "elements" property */
>  	if (!json_object_object_get_ex(jnode, "elements", &jvalue))

Regards,
Inga

--=-6OsKnQ+fCQROjZ9UBo/H
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNzMwMjMxODA3WjAjBgkqhkiG9w0BCQQxFgQU
qk3zBHyex/A3RPG/tgprWkeAYmowDQYJKoZIhvcNAQEBBQAEggEAYroejR2fbuvSZJ9sKyFHQ4TK
XktvLMfjrUaKvpnVHWjAlHZZuzC/7pzOhybqg5CqWpTrlOGCvlIb2h84fnqpzdaw0C4guxynMuIP
OCc+c81po1LsBzcB81O58HjCkMzjNJ419sgQ0/YIsmuzEEbKSWq5vIApsOTqDTKv9euKyqc5V6w/
jMX1Caguk9eFfe5WX1iNVb59zPSgOSKE0cufNNPZNqm81aj+FPd4LhFfUlQxFZEpKIaf55mesCBn
YBxNbz3FOo/HxgXGYAxT2argeeJ0W89GHmwPm5E7SV9LrEbXP7INd9wLhRbtQnGH+1DGrGoKxEJH
VLaa8coc/jANjwAAAAAAAA==


--=-6OsKnQ+fCQROjZ9UBo/H--
