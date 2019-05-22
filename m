Return-Path: <SRS0=CsNs=TW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B79C072A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 06:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F5620644
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 06:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfEVGoG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 May 2019 02:44:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:17450 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfEVGoG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 May 2019 02:44:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 23:44:05 -0700
X-ExtLoop1: 1
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga004.fm.intel.com with ESMTP; 21 May 2019 23:44:04 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 21 May 2019 23:44:04 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.165]) with mapi id 14.03.0415.000;
 Tue, 21 May 2019 23:44:04 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Add App and Net Key Refresh keyring back-end
Thread-Topic: [PATCH BlueZ] mesh: Add App and Net Key Refresh keyring
 back-end
Thread-Index: AQHVD/bgIVWaLte3MkSjs43Eo9GmlaZ3KOeA
Date:   Wed, 22 May 2019 06:44:04 +0000
Message-ID: <cac7634e3fae82e060728b9cfe096a31a9e86c70.camel@intel.com>
References: <20190521170135.32057-1-brian.gix@intel.com>
In-Reply-To: <20190521170135.32057-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.201.100]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-7NffFT/lddEvhkmKa4Fo"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-7NffFT/lddEvhkmKa4Fo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Tue, 2019-05-21 at 10:01 -0700, Brian Gix wrote:
> Fill in skeleton App Key and Net Key KeyRing methods that are
> affected
> by the Key Refresh Procedure.

Would be nice to list the implemented methods here.
I would strongly recommned breaking this in to two, maybe even three
patches:
net key methods, app key methods, phase method


> ---
>  doc/mesh-api.txt |   2 +
>  mesh/manager.c   | 198
> ++++++++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 170 insertions(+), 30 deletions(-)
>=20
> diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
> index 112990a5d..9644553e8 100644
> --- a/doc/mesh-api.txt
> +++ b/doc/mesh-api.txt
> @@ -434,6 +434,7 @@ Methods:
>  		PossibleErrors:
>  			org.bluez.mesh.Error.InvalidArguments
>  			org.bluez.mesh.Error.DoesNotExist
> +			org.bluez.mesh.Error.Busy
> =20
>  	void DeleteSubnet(uint16 net_index)
> =20
> @@ -527,6 +528,7 @@ Methods:
>  		PossibleErrors:
>  			org.bluez.mesh.Error.InvalidArguments
>  			org.bluez.mesh.Error.DoesNotExist
> +			org.bluez.mesh.Error.Busy
> =20
>  	void DeleteAppKey(uint16 app_index)
> =20
> diff --git a/mesh/manager.c b/mesh/manager.c
> index d990ceec2..8ef32d735 100644
> --- a/mesh/manager.c
> +++ b/mesh/manager.c
> @@ -24,9 +24,12 @@
>  #define _GNU_SOURCE
>  #include <ell/ell.h>
> =20
> +#include "mesh/mesh-defs.h"
>  #include "mesh/dbus.h"
>  #include "mesh/error.h"
>  #include "mesh/mesh.h"
> +#include "mesh/node.h"
> +#include "mesh/keyring.h"
>  #include "mesh/manager.h"
> =20
>  static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
> @@ -86,51 +89,110 @@ static struct l_dbus_message
> *cancel_scan_call(struct l_dbus *dbus,
>  	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
>  }
> =20
> +static struct l_dbus_message *store_new_subnet(struct mesh_node
> *node,
> +					struct l_dbus_message *msg,
> +					uint16_t net_idx, uint8_t
> *new_key)
> +{
> +	struct keyring_net_key key;
> +
> +	if (net_idx > MAX_KEY_IDX)
> +		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> +
> +	if (keyring_get_net_key(node, net_idx, &key)) {
> +		/* Allow redundent calls only if they match */

Allow redundant calls only if the key values match

> +		if (!memcmp(key.old_key, new_key, 16))
> +			return l_dbus_message_new_method_return(msg);
> +
> +		return dbus_error(msg, MESH_ERROR_ALREADY_EXISTS,
> NULL);
> +	}
> +
> +	memcpy(key.old_key, new_key, 16);
> +	key.net_idx =3D net_idx;
> +	key.phase =3D KEY_REFRESH_PHASE_NONE;
> +
> +	if (!keyring_put_net_key(node, net_idx, &key))
> +		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
> +
> +	return l_dbus_message_new_method_return(msg);
> +}
> +
>  static struct l_dbus_message *create_subnet_call(struct l_dbus
> *dbus,
>  						struct l_dbus_message
> *msg,
>  						void *user_data)
>  {
> +	struct mesh_node *node =3D user_data;
> +	uint8_t key[16];
>  	uint16_t net_idx;
> =20
> -	if (!l_dbus_message_get_arguments(msg, "q", &net_idx))
> +	if (!l_dbus_message_get_arguments(msg, "q", &net_idx) ||
> !net_idx)


Maybe use explicit value for net_idx check, i.e.,=20
net_idx =3D=3D MESH_PRIMARY_NET_INDEX_DEFAULT

Currently DEFAULT_PRIMARY_NET_INDEX is defined in node.c
WE should move it into mesh-defs.h and rename accordingly

>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> =20
> -	/* TODO */
> -	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
> +	/* Generate key and submit */
> +	l_getrandom(key, sizeof(key));
> +
> +	return store_new_subnet(node, msg, net_idx, key);
>  }
> =20
>  static struct l_dbus_message *update_subnet_call(struct l_dbus
> *dbus,
>  						struct l_dbus_message
> *msg,
>  						void *user_data)
>  {
> +	struct mesh_node *node =3D user_data;
> +	struct keyring_net_key key;
>  	uint16_t net_idx;
> =20
> -	if (!l_dbus_message_get_arguments(msg, "q", &net_idx))
> +	if (!l_dbus_message_get_arguments(msg, "q", &net_idx) ||
> +						net_idx > MAX_KEY_IDX)
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> =20
> -	/* TODO */
> -	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
> +	if (!keyring_get_net_key(node, net_idx, &key))
> +		return dbus_error(msg, MESH_ERROR_DOES_NOT_EXIST,
> NULL);
> +
> +	switch (key.phase) {
> +	case KEY_REFRESH_PHASE_NONE:
> +		/* Generate Key and update phase */
> +		l_getrandom(key.new_key, sizeof(key.new_key));
> +		key.phase =3D KEY_REFRESH_PHASE_ONE;

line break?

> +		if (!keyring_put_net_key(node, net_idx, &key))
> +			return dbus_error(msg, MESH_ERROR_FAILED,
> NULL);

Wouldn't we want to revert the key phase back to KEY_REFRESH_PHASE_NONE
in case of failure?

> +
> +		/* Fall Through */
> +
> +	case KEY_REFRESH_PHASE_ONE:
> +		/* Allow redundent calls to start Key Refresh */

"redundant"

> +		return l_dbus_message_new_method_return(msg);
> +
> +	default:
> +		break;
> +	}
> +
> +	/* All other phases mean KR already in progress over-the-air */
> +	return dbus_error(msg, MESH_ERROR_BUSY, "KR in progress");

KR -> Key refresh

>  }
> =20
>  static struct l_dbus_message *delete_subnet_call(struct l_dbus
> *dbus,
>  						struct l_dbus_message
> *msg,
>  						void *user_data)
>  {
> +	struct mesh_node *node =3D user_data;
>  	uint16_t net_idx;
> =20
> -	if (!l_dbus_message_get_arguments(msg, "q", &net_idx))
> +	if (!l_dbus_message_get_arguments(msg, "q", &net_idx) ||
> +						net_idx > MAX_KEY_IDX)
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> =20
> -	/* TODO */
> -	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
> +	keyring_del_net_key(node, net_idx);
> +
> +	return l_dbus_message_new_method_return(msg);
>  }
> =20
>  static struct l_dbus_message *import_subnet_call(struct l_dbus
> *dbus,
>  						struct l_dbus_message
> *msg,
>  						void *user_data)
>  {
> -	uint16_t net_idx;
> +	struct mesh_node *node =3D user_data;
>  	struct l_dbus_message_iter iter_key;
> +	uint16_t net_idx;
>  	uint8_t *key;
>  	uint32_t n;
> =20
> @@ -142,55 +204,116 @@ static struct l_dbus_message
> *import_subnet_call(struct l_dbus *dbus,
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
>  							"Bad network
> key");
> =20
> -	/* TODO */
> -	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
> +	return store_new_subnet(node, msg, net_idx, key);
> +}
> +
> +static struct l_dbus_message *store_new_appkey(struct mesh_node
> *node,
> +					struct l_dbus_message *msg,
> +					uint16_t net_idx, uint16_t
> app_idx,
> +					uint8_t *new_key)
> +{
> +	struct keyring_net_key net_key;
> +	struct keyring_app_key app_key;
> +
> +	if (net_idx > MAX_KEY_IDX || app_idx > MAX_KEY_IDX)
> +		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> +
> +	if (!keyring_get_net_key(node, net_idx, &net_key))
> +		return dbus_error(msg, MESH_ERROR_DOES_NOT_EXIST,
> NULL);

NULL -> "Bound net key not found"
Also, I don't think "org.bluez.mesh.Error.DoesNotExist" error is
documented in mesh-api.txt for either CreateAppKey() or ImportAppKey(),
needs to be added.

> +
> +	if (keyring_get_app_key(node, app_idx, &app_key)) {
> +		/* Allow redundent calls with identical data */

"Allow redundant calls with identical values"

> +		if (!memcmp(app_key.old_key, new_key, 16) &&
> +						app_key.net_idx =3D=3D
> net_idx)
> +			return l_dbus_message_new_method_return(msg);
> +
> +		return dbus_error(msg, MESH_ERROR_ALREADY_EXISTS,
> NULL);
> +	}
> +
> +	memcpy(app_key.old_key, new_key, 16);
> +	app_key.net_idx =3D net_idx;
> +	app_key.app_idx =3D app_idx;
> +
> +	if (!keyring_put_app_key(node, app_idx, net_idx, &app_key))
> +		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
> +
> +	return l_dbus_message_new_method_return(msg);
>  }
> =20
>  static struct l_dbus_message *create_appkey_call(struct l_dbus
> *dbus,
>  						struct l_dbus_message
> *msg,
>  						void *user_data)
>  {
> +	struct mesh_node *node =3D user_data;
>  	uint16_t net_idx, app_idx;
> +	uint8_t key[16];
> =20
>  	if (!l_dbus_message_get_arguments(msg, "qq", &net_idx,
> &app_idx))
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> =20
> -	/* TODO */
> -	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
> +	l_getrandom(key, sizeof(key));
> +
> +	return store_new_appkey(node, msg, net_idx, app_idx, key);
>  }
> =20
>  static struct l_dbus_message *update_appkey_call(struct l_dbus
> *dbus,
>  						struct l_dbus_message
> *msg,
>  						void *user_data)
>  {
> -	uint16_t net_idx, app_idx;
> +	struct mesh_node *node =3D user_data;
> +	struct keyring_net_key net_key;
> +	struct keyring_app_key app_key;
> +	uint16_t app_idx;
> =20
> -	if (!l_dbus_message_get_arguments(msg, "qq", &net_idx,
> &app_idx))
> +	if (!l_dbus_message_get_arguments(msg, "q", &app_idx) ||
> +						app_idx > MAX_KEY_IDX)
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> =20
> -	/* TODO */
> -	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
> +	if (!keyring_get_app_key(node, app_idx, &app_key) ||
> +			!keyring_get_net_key(node, app_key.net_idx,
> &net_key))
> +		return dbus_error(msg, MESH_ERROR_DOES_NOT_EXIST,
> NULL);
> +
> +	switch (net_key.phase) {
> +	case KEY_REFRESH_PHASE_NONE:
> +	case KEY_REFRESH_PHASE_ONE:
What if the net key is in key refresh phase one and This method has
been called mre than once? i.e., do we want to protect the application
from potentially overwriting already updated application key?

> +		/* Generate Key if in acceptable phase */
> +		l_getrandom(app_key.new_key, sizeof(app_key.new_key));

line break

> +		if (!keyring_put_app_key(node, app_idx,
> app_key.net_idx,
> +								&app_ke
> y))
> +			return dbus_error(msg, MESH_ERROR_FAILED,
> NULL);
> +
> +		return l_dbus_message_new_method_return(msg);
> +
> +	default:
> +		break;
> +	}
> +
> +	/* Don't allow Updates from invalid phase */
> +	return dbus_error(msg, MESH_ERROR_BUSY, "KR in progress");

KR -> Key refresh

>  }
> =20
>  static struct l_dbus_message *delete_appkey_call(struct l_dbus
> *dbus,
>  						struct l_dbus_message
> *msg,
>  						void *user_data)
>  {
> -	uint16_t net_idx, app_idx;
> +	struct mesh_node *node =3D user_data;
> +	uint16_t app_idx;
> =20
> -	if (!l_dbus_message_get_arguments(msg, "qq", &net_idx,
> &app_idx))
> +	if (!l_dbus_message_get_arguments(msg, "q", &app_idx))
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> =20
> -	/* TODO */
> -	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
> +	keyring_del_app_key(node, app_idx);
> +
> +	return l_dbus_message_new_method_return(msg);
>  }
> =20
>  static struct l_dbus_message *import_appkey_call(struct l_dbus
> *dbus,
>  						struct l_dbus_message
> *msg,
>  						void *user_data)
>  {
> -	uint16_t net_idx, app_idx;
> +	struct mesh_node *node =3D user_data;
>  	struct l_dbus_message_iter iter_key;
> +	uint16_t net_idx, app_idx;
>  	uint8_t *key;
>  	uint32_t n;
> =20
> @@ -203,22 +326,37 @@ static struct l_dbus_message
> *import_appkey_call(struct l_dbus *dbus,
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
>  							"Bad
> application key");
> =20
> -	/* TODO */
> -	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
> +	return store_new_appkey(node, msg, net_idx, app_idx, key);
>  }
> =20
>  static struct l_dbus_message *set_key_phase_call(struct l_dbus
> *dbus,
>  						struct l_dbus_message
> *msg,
>  						void *user_data)
>  {
> +	struct mesh_node *node =3D user_data;
> +	struct keyring_net_key key;
>  	uint16_t net_idx;
>  	uint8_t phase;
> =20
> -	if (!l_dbus_message_get_arguments(msg, "qy", &net_idx, &phase))
> +	if (!l_dbus_message_get_arguments(msg, "qy", &net_idx, &phase)
> ||
> +					phase =3D=3D KEY_REFRESH_PHASE_ONE
> ||
> +					phase >
> KEY_REFRESH_PHASE_THREE)
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> =20
> -	/* TODO */
> -	return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED, NULL);
> +	if (!keyring_get_net_key(node, net_idx, &key))
> +		return dbus_error(msg, MESH_ERROR_DOES_NOT_EXIST,
> NULL);
> +
> +	if (phase =3D=3D KEY_REFRESH_PHASE_THREE &&
> +					key.phase !=3D
> KEY_REFRESH_PHASE_NONE) {
> +		memcpy(key.old_key, key.new_key, 16);
> +		key.phase =3D KEY_REFRESH_PHASE_NONE;
> +	} else
> +		key.phase =3D phase;
> +
> +	if (!keyring_put_net_key(node, net_idx, &key))
> +		return dbus_error(msg, MESH_ERROR_FAILED, NULL);

Restore the phase to the previous value in case of failure?

> +
> +	return l_dbus_message_new_method_return(msg);
>  }
> =20
>  static void setup_management_interface(struct l_dbus_interface
> *iface)
> @@ -242,9 +380,9 @@ static void setup_management_interface(struct
> l_dbus_interface *iface)
>  	l_dbus_interface_method(iface, "CreateAppKey", 0,
> create_appkey_call,
>  					"", "qq", "", "net_index",
> "app_index");
>  	l_dbus_interface_method(iface, "UpdateAppKey", 0,
> update_appkey_call,
> -					"", "qq", "", "net_index",
> "app_index");
> +					"", "q", "", "app_index");
>  	l_dbus_interface_method(iface, "DeleteAppKey", 0,
> delete_appkey_call,
> -					"", "qq", "", "net_index",
> "app_index");
> +					"", "q", "", "app_index");
>  	l_dbus_interface_method(iface, "ImportAppKey", 0,
> import_appkey_call,
>  				"", "qqay", "", "net_index",
> "app_index",
>  								"app_ke
> y");


Thank you,


Inga

--=-7NffFT/lddEvhkmKa4Fo
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNTIyMDY0NDAzWjAjBgkqhkiG9w0BCQQxFgQU
i+R2meIkjxK6cpbK0sxl4hK1C28wDQYJKoZIhvcNAQEBBQAEggEAgFKZS3l6lOTPA+MuyiR1GzE0
kSGKYgNW6Xs7I27gTYvJJhYnoy41M7RrNziwZt4U4a9S0Wn8SX09L1GTkrbAcarSUMRFm1jBprW9
7YWVNdXL0DCc90BZADjsjRG8eIDkGww38OwsxSUEd1Ym5E8BX2JOxdkYVcz49heYkS60vEutSU17
9xyhOaaq1FoQ2OU4axJ+GpqgNc7ymbdu6D0SZaaI+cI3x9oxwNv0eOZwUVWKYYAT06EX4xDm3MSr
1SGC78zjfBvN8xjHa5sxt6/WKhFmlATGnfQymDVaIke9DivB9KU4yGdMvFq4KWn42BLbizYZTWIP
7lfiIESPuyOB1gAAAAAAAA==


--=-7NffFT/lddEvhkmKa4Fo--
