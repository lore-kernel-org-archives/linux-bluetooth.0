Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C54C7618F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 20:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FA721851
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 20:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfGQUZS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 16:25:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:43864 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbfGQUZS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 16:25:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 13:25:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,275,1559545200"; 
   d="p7s'?scan'208";a="187628495"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2019 13:25:17 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 17 Jul 2019 13:25:16 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.77]) with mapi id 14.03.0439.000;
 Wed, 17 Jul 2019 13:25:16 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Check address range passed to
 ImportRemoteNode
Thread-Topic: [PATCH BlueZ] mesh: Check address range passed to
 ImportRemoteNode
Thread-Index: AQHVPNauHzkyEEMCR0qyfKiG0DErU6bPtyYA
Date:   Wed, 17 Jul 2019 20:25:15 +0000
Message-ID: <40457f631498e71c072f3db29faf74fa3cb0b3e0.camel@intel.com>
References: <20190717193429.14155-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190717193429.14155-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.159.19]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-/aVzDoA3Kgs0xJZMygpV"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-/aVzDoA3Kgs0xJZMygpV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Wed, 2019-07-17 at 21:34 +0200, Micha=C5=82 Lowas-Rzechonek wrote:
> This patch disallows importing device key for:
>  - non-unicast addresses
>  - unicast addresses overlapping with local node address range
> ---
>  doc/mesh-api.txt |  8 ++++++++
>  mesh/keyring.c   | 11 +++++++++++
>  mesh/manager.c   | 12 ++++++++++++
>  3 files changed, 31 insertions(+)
>=20
> diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
> index 7c2a1fafa..e5d246ae4 100644
> --- a/doc/mesh-api.txt
> +++ b/doc/mesh-api.txt
> @@ -607,9 +607,13 @@ Methods:
> =20
>  		This call affects the local bluetooth-meshd key
> database only.
> =20
> +		It is an error to call this with address range
> overlapping
> +		with local element addresses.
> +
>  		PossibleErrors:
>  			org.bluez.mesh.Error.Failed
>  			org.bluez.mesh.Error.InvalidArguments
> +			org.bluez.mesh.Error.NotAuthorized
> =20
>  	void DeleteRemoteNode(uint16 primary, uint8 count)
> =20
> @@ -624,8 +628,12 @@ Methods:
> =20
>  		This call affects the local bluetooth-meshd key
> database only.
> =20
> +		It is an error to call this with address range
> overlapping
> +		with local element addresses.
> +
>  		PossibleErrors:
>  			org.bluez.mesh.Error.InvalidArguments
> +			org.bluez.mesh.Error.NotAuthorized
> =20
>  Properties:
>  	dict Features [read-only]
> diff --git a/mesh/keyring.c b/mesh/keyring.c
> index 3ea83194c..0b2474139 100644
> --- a/mesh/keyring.c
> +++ b/mesh/keyring.c
> @@ -128,6 +128,9 @@ bool keyring_put_remote_dev_key(struct mesh_node
> *node, uint16_t unicast,
>  	bool result =3D true;
>  	int fd, i;
> =20
> +	if (!IS_UNICAST(unicast) || !IS_UNICAST(unicast + count - 1))
> +		return false;
> +
>  	if (!node)
>  		return false;
> =20
> @@ -218,10 +221,14 @@ bool keyring_get_remote_dev_key(struct
> mesh_node *node, uint16_t unicast,
>  	bool result =3D false;
>  	int fd;
> =20
> +	if (!IS_UNICAST(unicast))
> +		return false;
> +
>  	if (!node)
>  		return false;
> =20
>  	node_path =3D node_get_storage_dir(node);
> +
>  	snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
> dev_key_dir,
>  								unicast
> );
> =20
> @@ -280,10 +287,14 @@ bool keyring_del_remote_dev_key(struct
> mesh_node *node, uint16_t unicast,
>  	char key_file[PATH_MAX];
>  	int i;
> =20
> +	if (!IS_UNICAST(unicast) || !IS_UNICAST(unicast + count - 1))
> +		return false;
> +

I wonder if this deserves its own macro that can be used for validation
in the number of situations, e.g. node import, config parsing...


>  	if (!node)
>  		return false;
> =20
>  	node_path =3D node_get_storage_dir(node);
> +
>  	for (i =3D 0; i < count; i++) {
>  		snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
>  						dev_key_dir, unicast +
> i);
> diff --git a/mesh/manager.c b/mesh/manager.c
> index 77d7b7516..564a848d1 100644
> --- a/mesh/manager.c
> +++ b/mesh/manager.c
> @@ -282,6 +282,7 @@ static struct l_dbus_message
> *import_node_call(struct l_dbus *dbus,
>  						void *user_data)
>  {
>  	struct mesh_node *node =3D user_data;
> +	struct mesh_net *net =3D node_get_net(node);
>  	struct l_dbus_message_iter iter_key;
>  	uint16_t primary;
>  	uint8_t num_ele;
> @@ -297,6 +298,11 @@ static struct l_dbus_message
> *import_node_call(struct l_dbus *dbus,
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
>  							"Bad device
> key");
> =20
> +	if (mesh_net_is_local_address(net, primary) ||
> +			mesh_net_is_local_address(net, primary +
> num_ele - 1))
> +		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED,
> +					"Cannot overwrite local device
> key");
> +
>  	if (!keyring_put_remote_dev_key(node, primary, num_ele, key))
>  		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
> =20
> @@ -308,12 +314,18 @@ static struct l_dbus_message
> *delete_node_call(struct l_dbus *dbus,
>  						void *user_data)
>  {
>  	struct mesh_node *node =3D user_data;
> +	struct mesh_net *net =3D node_get_net(node);
>  	uint16_t primary;
>  	uint8_t num_ele;
> =20
>  	if (!l_dbus_message_get_arguments(msg, "qy", &primary,
> &num_ele))
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
> =20
> +	if (mesh_net_is_local_address(net, primary) ||
> +			mesh_net_is_local_address(net, primary +
> num_ele - 1))
> +		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED,
> +					"Cannot remove local device
> key");
> +
>  	keyring_del_remote_dev_key(node, primary, num_ele);
> =20
>  	return l_dbus_message_new_method_return(msg);

--=-/aVzDoA3Kgs0xJZMygpV
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNzE3MjAyNTE0WjAjBgkqhkiG9w0BCQQxFgQU
y6MHkeONJjOgvCpaMAJ6CAwsIa0wDQYJKoZIhvcNAQEBBQAEggEAmYg462DZv8RmHYuHlfYSHOLI
Sy3A+APKWGjyBVwIH2i1v1LZWAZVKX8OjIaX5m4rFgOxTbbzIEHojx+CJqTnqgWoghacLFrp3fW+
+VoswEyuWIN4u+UBUOUIztOMFB06LEQbC72fyEa00W4NFOjluSdmLFGpChYY0bQtTCijF/1CK45s
aZ1qUSCP3hbcMXaNrweJw7kBvM2UqsMGTjnTW/a9krZ5oYNpStLePg5Wct934HAbjTkiJq7QjACD
mLyvza6VXyon+fry4yV+Keuci0Tr2Y3yfXDzG5xwijkhe2x4K0n4W2BQh/B6QVo/VESfQyweD65g
PNOza4fUVPtf1gAAAAAAAA==


--=-/aVzDoA3Kgs0xJZMygpV--
