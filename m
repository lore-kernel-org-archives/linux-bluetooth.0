Return-Path: <SRS0=vBm7=XV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E32EC4360C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 20:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F687222C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 20:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfIZUkw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:40:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:18723 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfIZUkw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Sep 2019 16:40:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 13:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,553,1559545200"; 
   d="p7s'?scan'208";a="201781252"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga002.jf.intel.com with ESMTP; 26 Sep 2019 13:40:51 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 13:40:50 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.5]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.218]) with mapi id 14.03.0439.000;
 Thu, 26 Sep 2019 13:40:50 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ v3 2/3] mesh: Explicit Remote/Local Device key
 usage
Thread-Topic: [PATCH BlueZ v3 2/3] mesh: Explicit Remote/Local Device key
 usage
Thread-Index: AQHVdJZcl+jjDXdot0aZAbg8fHHFRKc+4YiA
Date:   Thu, 26 Sep 2019 20:40:50 +0000
Message-ID: <3750c6bf249398efb5a84c44fdc9c2e6c83b4d8b.camel@intel.com>
References: <20190926181444.4916-1-brian.gix@intel.com>
         <20190926181444.4916-3-brian.gix@intel.com>
In-Reply-To: <20190926181444.4916-3-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.132.116]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-YJONW2UH7rLC3CWS92YN"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-YJONW2UH7rLC3CWS92YN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Thu, 2019-09-26 at 11:14 -0700, Brian Gix wrote:
> When sending or receiving Device Key (privileged) mesh messages, the
> remote vs local device key must be specified. This allows Apps to
> specify Key Ring stored device keys, and sanity checks that the
> correct
> key exists before allowing the transmission. Loopback messages to
> local
> servers *must* use keys from the Key Ring to indicate privilege has
> been
> granted.
> ---
>  mesh/model.c | 11 +++++++----
>  mesh/node.c  | 25 +++++++++++++++----------
>  2 files changed, 22 insertions(+), 14 deletions(-)
>=20
> diff --git a/mesh/model.c b/mesh/model.c
> index a06b684a5..e9b346102 100644
> --- a/mesh/model.c
> +++ b/mesh/model.c
> @@ -735,14 +735,16 @@ static int add_sub(struct mesh_net *net, struct
> mesh_model *mod,
>  }
> =20
>  static void send_dev_key_msg_rcvd(struct mesh_node *node, uint8_t
> ele_idx,
> -					uint16_t src, uint16_t net_idx,
> -					uint16_t size, const uint8_t
> *data)
> +					uint16_t src, uint16_t app_idx,
> +					uint16_t net_idx, uint16_t
> size,
> +					const uint8_t *data)
>  {
>  	struct l_dbus *dbus =3D dbus_get_bus();
>  	struct l_dbus_message *msg;
>  	struct l_dbus_message_builder *builder;
>  	const char *owner;
>  	const char *path;
> +	bool remote =3D (app_idx !=3D APP_IDX_DEV_LOCAL);
> =20
>  	owner =3D node_get_owner(node);
>  	path =3D node_get_element_path(node, ele_idx);
> @@ -758,6 +760,7 @@ static void send_dev_key_msg_rcvd(struct
> mesh_node *node, uint8_t ele_idx,
>  	builder =3D l_dbus_message_builder_new(msg);
> =20
>  	l_dbus_message_builder_append_basic(builder, 'q', &src);
> +	l_dbus_message_builder_append_basic(builder, 'b', &remote);
>  	l_dbus_message_builder_append_basic(builder, 'q', &net_idx);
>  	dbus_append_byte_array(builder, data, size);
> =20
> @@ -936,8 +939,8 @@ bool mesh_model_rx(struct mesh_node *node, bool
> szmict, uint32_t seq0,
>  			else if (decrypt_idx =3D=3D APP_IDX_DEV_REMOTE ||
>  				(decrypt_idx =3D=3D APP_IDX_DEV_LOCAL &&
>  				 mesh_net_is_local_address(net, src,
> 1)))
> -				send_dev_key_msg_rcvd(node, i, src, 0,
> -						forward.size,
> forward.data);
> +				send_dev_key_msg_rcvd(node, i, src,
> decrypt_idx,
> +						0, forward.size,
> forward.data);
>  		}
> =20
>  		/*
> diff --git a/mesh/node.c b/mesh/node.c
> index b6824f505..833377e99 100644
> --- a/mesh/node.c
> +++ b/mesh/node.c
> @@ -1976,7 +1976,8 @@ static struct l_dbus_message
> *dev_key_send_call(struct l_dbus *dbus,
>  	const char *sender, *ele_path;
>  	struct l_dbus_message_iter iter_data;
>  	struct node_element *ele;
> -	uint16_t dst, net_idx, src;
> +	uint16_t dst, app_idx, net_idx, src;
> +	bool remote;
>  	uint8_t *data;
>  	uint32_t len;
> =20
> @@ -1987,8 +1988,12 @@ static struct l_dbus_message
> *dev_key_send_call(struct l_dbus *dbus,
>  	if (strcmp(sender, node->owner))
>  		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED,
> NULL);
> =20
> -	if (!l_dbus_message_get_arguments(msg, "oqqay", &ele_path,
> &dst,
> -							&net_idx,
> &iter_data))
> +	if (!l_dbus_message_get_arguments(msg, "oqbqay", &ele_path,
> &dst,
> +						&remote, &net_idx,
> &iter_data))
> +		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> +
> +	/* Loopbacks to local servers must use *remote* addressing */
> +	if (!remote && mesh_net_is_local_address(node->net, dst, 1))
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> =20
>  	ele =3D l_queue_find(node->elements, match_element_path,
> ele_path);
> @@ -1999,13 +2004,13 @@ static struct l_dbus_message
> *dev_key_send_call(struct l_dbus *dbus,
>  	src =3D node_get_primary(node) + ele->idx;
> =20
>  	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data,
> &len) ||
> -					!len || len > MAX_MSG_LEN)
> +						!len || len >
> MAX_MSG_LEN)
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
>  							"Incorrect
> data");
> =20
> -	/* TODO: use net_idx */
> -	if (!mesh_model_send(node, src, dst, APP_IDX_DEV_REMOTE,
> net_idx,
> -							DEFAULT_TTL,
> data, len))
> +	app_idx =3D remote ? APP_IDX_DEV_REMOTE : APP_IDX_DEV_LOCAL;
> +	if (!mesh_model_send(node, src, dst, app_idx, net_idx,
> DEFAULT_TTL,
> +								data,
> len))
>  		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);

I think that mesh_model_send() should be modified to return an error
code (int) instead of boolean. Otherwise, it may fail for a different
reason than a mismatch in device key and the returned error is
misleading.
In fact, the Send() call returns D-Bus "Failed" error upon getting
"false" from mesh_model_send() and this is not documented in the API
doc.

This probably should go a separate fix.

> =20
>  	return l_dbus_message_new_method_return(msg);
> @@ -2226,9 +2231,9 @@ static void setup_node_interface(struct
> l_dbus_interface *iface)
>  						"element_path",
> "destination",
>  						"key_index", "data");
>  	l_dbus_interface_method(iface, "DevKeySend", 0,
> dev_key_send_call,
> -						"", "oqqay",
> "element_path",
> -						"destination",
> "net_index",
> -						"data");
> +						"", "oqbqay",
> "element_path",
> +						"destination",
> "remote",
> +						"net_index", "data");
>  	l_dbus_interface_method(iface, "Publish", 0, publish_call, "",
> "oqay",
>  					"element_path", "model_id",
> "data");
>  	l_dbus_interface_method(iface, "VendorPublish", 0,
> vendor_publish_call,

--=-YJONW2UH7rLC3CWS92YN
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwOTI2MjA0MDQ5WjAjBgkqhkiG9w0BCQQxFgQU
sGcbCiDPxMkUjrl1/pRl+rvGxQUwDQYJKoZIhvcNAQEBBQAEggEAgN1aV7Pck8x5J+E5tK5hEava
G8aXzW1pi88SsGIGzCdGV1h1R1GIda6s2FKH6TZhN+bSB+ZN6rzB+lPTCTNe37g5xMQ/0Wf3GLlK
xsUDKMW3G6OXkz254KIgjzQQwKIVEBrOGUg+6oFEOxtHnUrCTiM6biIC0Jz2fz+A4jUeX4kYLR7v
P0RlU/HcqqH5bGy6Y7PWCYmlm0/g5UtKCpZnBH5LaWkfkfWXer7XX0EXdrC5XNEw7Vdai3vwuyeq
3H6roOpdifW0VPLY6Jho0G2pf0l2tB2w6AJeEaABOMRJMi1cjsgO/Jf3GMMM86pv3z6BJTTwQyI7
5EqHs9CipYcCBQAAAAAAAA==


--=-YJONW2UH7rLC3CWS92YN--
