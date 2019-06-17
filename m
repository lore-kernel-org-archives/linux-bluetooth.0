Return-Path: <SRS0=uXJ1=UQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E0FC31E5B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jun 2019 22:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70992080A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jun 2019 22:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfFQWTY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:19:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:57565 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfFQWTY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Jun 2019 18:19:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 15:19:23 -0700
X-ExtLoop1: 1
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga005.jf.intel.com with ESMTP; 17 Jun 2019 15:19:23 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 17 Jun 2019 15:19:23 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.136]) with mapi id 14.03.0439.000;
 Mon, 17 Jun 2019 15:19:23 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH] mesh: Return dbus error code on Leave() with invalit
 token given
Thread-Topic: [PATCH] mesh: Return dbus error code on Leave() with invalit
 token given
Thread-Index: AQHVJRJrlD83R3pSxEWh/SZGMOaHeaag4I+A
Date:   Mon, 17 Jun 2019 22:19:22 +0000
Message-ID: <5a3a7c681e92d613a35f5c9b3abe5c27df867b4a.camel@intel.com>
References: <20190617134141.575-1-jakub.witowski@silvair.com>
In-Reply-To: <20190617134141.575-1-jakub.witowski@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.55.111]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-nvvrVnzzuTlBkQD1Eo7R"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-nvvrVnzzuTlBkQD1Eo7R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Mon, 2019-06-17 at 15:41 +0200, Jakub Witowski wrote:
> This implements MESH_ERROR_NOT_FOUND error when we try to call
> Leave()
> from dbus api with incorrect token value (ex. Leave(0))
> ---
>  mesh/mesh.c    | 10 +++++-----
>  mesh/node.c    |  7 +++++--
>  mesh/node.h    |  2 +-
>  mesh/storage.c |  4 ++--
>  4 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/mesh/mesh.c b/mesh/mesh.c
> index 231a6bca4..f10b73331 100644
> --- a/mesh/mesh.c
> +++ b/mesh/mesh.c
> @@ -65,7 +65,7 @@ struct bt_mesh {
>  	uint8_t max_filters;
>  };
> =20
> -struct join_data{
> +struct join_data {
>  	struct l_dbus_message *msg;
>  	struct mesh_agent *agent;
>  	const char *sender;
> @@ -355,7 +355,7 @@ static void free_pending_join_call(bool failed)
>  	mesh_agent_remove(join_pending->agent);
> =20
>  	if (failed)
> -		node_remove(join_pending->node);
> +		(void)node_remove(join_pending->node);
> =20
>  	l_free(join_pending);
>  	join_pending =3D NULL;
> @@ -530,8 +530,7 @@ static void node_init_cb(struct mesh_node *node,
> struct mesh_agent *agent)
> =20
>  	if (!acceptor_start(num_ele, join_pending->uuid,
> mesh.algorithms,
>  				mesh.prov_timeout, agent,
> prov_complete_cb,
> -				&mesh))
> -	{
> +				&mesh)) {
>  		reply =3D dbus_error(join_pending->msg,
> MESH_ERROR_FAILED,
>  				"Failed to start provisioning
> acceptor");
>  		goto fail;
> @@ -696,7 +695,8 @@ static struct l_dbus_message *leave_call(struct
> l_dbus *dbus,
>  	if (!l_dbus_message_get_arguments(msg, "t", &token))
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> =20
> -	node_remove(node_find_by_token(token));
> +	if (!node_remove(node_find_by_token(token)))
> +		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
> =20
>  	return l_dbus_message_new_method_return(msg);
>  }
> diff --git a/mesh/node.c b/mesh/node.c
> index e99858623..2b9978908 100644
> --- a/mesh/node.c
> +++ b/mesh/node.c
> @@ -256,11 +256,12 @@ static void free_node_resources(void *data)
>  /*
>   * This function is called to free resources and remove the
>   * configuration files for the specified node.
> + * The false is returned when there is no node to be removed
>   */
> -void node_remove(struct mesh_node *node)
> +bool node_remove(struct mesh_node *node)
>  {
>  	if (!node)
> -		return;
> +		return false;
> =20
>  	l_queue_remove(nodes, node);
> =20
> @@ -268,6 +269,7 @@ void node_remove(struct mesh_node *node)
>  		storage_remove_node_config(node);
> =20
>  	free_node_resources(node);
> +	return true;
>  }
> =20
>  static bool add_models(struct mesh_node *node, struct node_element
> *ele,
> @@ -1078,6 +1080,7 @@ static bool validate_model_property(struct
> node_element *ele,
>  		while (l_dbus_message_iter_next_entry(&ids, &vendor_id,
>  								&mod_id
> )) {
>  			struct mesh_model *mod;
> +
>  			mod =3D l_queue_find(ele->models, match_model_id,
>  				L_UINT_TO_PTR((vendor_id << 16) |
> mod_id));
>  			if (!mod)
> diff --git a/mesh/node.h b/mesh/node.h
> index 142527b30..5f045ee2d 100644
> --- a/mesh/node.h
> +++ b/mesh/node.h
> @@ -34,7 +34,7 @@ typedef void (*node_join_ready_func_t) (struct
> mesh_node *node,
>  						struct mesh_agent
> *agent);
> =20
>  struct mesh_node *node_new(const uint8_t uuid[16]);
> -void node_remove(struct mesh_node *node);
> +bool node_remove(struct mesh_node *node);
>  void node_join(const char *app_path, const char *sender, const
> uint8_t *uuid,
>  						node_join_ready_func_t
> cb);
>  uint8_t *node_uuid_get(struct mesh_node *node);
> diff --git a/mesh/storage.c b/mesh/storage.c
> index 1a9945aa8..7ae0ac5b1 100644
> --- a/mesh/storage.c
> +++ b/mesh/storage.c
> @@ -77,7 +77,7 @@ static bool read_node_cb(struct mesh_db_node
> *db_node, void *user_data)
>  	uint8_t *uuid;
> =20
>  	if (!node_init_from_storage(node, db_node)) {
> -		node_remove(node);
> +		(void)node_remove(node);
>  		return false;
>  	}
> =20
> @@ -220,7 +220,7 @@ static bool parse_config(char *in_file, char
> *out_dir, const uint8_t uuid[16])
> =20
>  	if (!result) {
>  		json_object_put(jnode);
> -		node_remove(node);
> +		(void)node_remove(node);
>  	}
> =20
>  	node_jconfig_set(node, jnode);

A better fix would be to remove the "NotFound" error from doc/mesh-
api.txt altogether: effectively, if the node wasn't found, it's been
successfully removed.

Best regards,
Inga



--=-nvvrVnzzuTlBkQD1Eo7R
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNjE3MjIxOTA3WjAjBgkqhkiG9w0BCQQxFgQU
GbTm9WmE6bmlBL63TNe7Sb2yNFwwDQYJKoZIhvcNAQEBBQAEggEAgAp7FPyerjDfz+i3gc5RTYFo
BfxXouU08wDI/CSYHYs/jUAFMfWrYEi5Hj3thoD+eFvIazXJZCVT0xNCXDmYpDW7B5h/xGM1xAap
2I3ultfQ3RLBl3kagbZcGPRE/N9EODxRR7j63HGvhfHpcZyj1GyuLkJBKPo9drUVndYWLNj5QTVR
Nw4HtoJXXL3lSnkjzwH7p127CcFlwaeVpCjpsV3ejIU+UVPyI68f14ew2eOdX8n5F2R1D+AX70M9
cEMkio4rcDMhpLn4CZsax7r2tKEEd4Hqd2uJDCEYJy1OwofN89MELCX1v2jUhWL7puJoF4uMw8a3
qyNZdS3v9eF+1AAAAAAAAA==


--=-nvvrVnzzuTlBkQD1Eo7R--
