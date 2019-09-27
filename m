Return-Path: <SRS0=evP7=XW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42486C4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 02:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1442520872
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 02:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfI0Cu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Sep 2019 22:50:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:21067 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfI0Cu0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Sep 2019 22:50:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 19:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,553,1559545200"; 
   d="p7s'?scan'208";a="219621729"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga002.fm.intel.com with ESMTP; 26 Sep 2019 19:50:25 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 19:50:25 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.5]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.237]) with mapi id 14.03.0439.000;
 Thu, 26 Sep 2019 19:50:25 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ v3 3/3] mesh: Fix Key Ring permissions for local
 nodes
Thread-Topic: [PATCH BlueZ v3 3/3] mesh: Fix Key Ring permissions for local
 nodes
Thread-Index: AQHVdJZoFMOUUqc+tEyrdZ8iI4HYlac+4ZOAgAAuiwCAADisAA==
Date:   Fri, 27 Sep 2019 02:50:25 +0000
Message-ID: <112b44e9e00c909a1d98997df1eeed0c2151eb0b.camel@intel.com>
References: <20190926181444.4916-1-brian.gix@intel.com>
         <20190926181444.4916-4-brian.gix@intel.com>
         <3c389010afa470574d5a90a4dc31a2bad9c26e84.camel@intel.com>
         <0a384749e155689d7981a443059d6cb5a6522f75.camel@intel.com>
In-Reply-To: <0a384749e155689d7981a443059d6cb5a6522f75.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.130.16]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-+E6D3b31g91Q0upBf1Vb"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-+E6D3b31g91Q0upBf1Vb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Thu, 2019-09-26 at 23:27 +0000, Gix, Brian wrote:
> On Thu, 2019-09-26 at 20:41 +0000, Stotland, Inga wrote:
> > Hi Brian,
> >=20
> > On Thu, 2019-09-26 at 11:14 -0700, Brian Gix wrote:
> > > We do *not* automatically create populated key rings for imported
> > > or
> > > joined nodes,
> >=20
> > Why not for Import()? Since both the DevKey and NetKey are in the
> > possesion of the node...
>=20
> There are two (known) use cases for Import()
>=20
> 1. Node previously existed on a different physical piece of hardware,
> and is being migrated to this daemon.
>=20
> 2. Node was newly provisioned Out-Of-Band, and this is the net result
> of the provisioning.
>=20
> In *neither* case is it a given that the Node should be able to
> provision another node (the effect of adding
> the Net Key to the key ring). In neither case is it a given that the
> Node should be able to modify it's own
> Config Server states (the effect of adding it's Device Key to the key
> ring).
>=20
> However, if it *is* the case that one or more of these operations
> should be available to the Node, the
> Application that performed the Import may call the ImportSubnet()
> and/or the ImportRemoteNode() methods. In
> actuality, if this was the intent (particularily on a Node being
> migrated) a key-ring of some sort should have
> existed on the other physical piece of hardware.
>=20
>=20
> The point of this larger patch-set is to no longer assume that every
> Node has the ability to use it's own
> network keys to provision other nodes, or use it's own Device Key to
> change it's own Config Server states.
>=20
> Yes, that can still happen (as it can with non BlueZ nodes) but it
> should be by a deliberate mechanism, not as
> a "time saving default".
>=20
>=20
>=20

Sounds good. Could you please add this description to the commit
message?

> > > but we also do not *forbid* any node from adding a key
> > > in it's possesion to the local key ring.
> > > ---
> > >  mesh/manager.c |  5 -----
> > >  mesh/node.c    | 15 ---------------
> > >  2 files changed, 20 deletions(-)
> > >=20
> > > diff --git a/mesh/manager.c b/mesh/manager.c
> > > index 501ec10fe..633597659 100644
> > > --- a/mesh/manager.c
> > > +++ b/mesh/manager.c
> > > @@ -282,7 +282,6 @@ static struct l_dbus_message
> > > *import_node_call(struct l_dbus *dbus,
> > >  void *user_data)
> > >  {
> > >  struct mesh_node *node =3D user_data;
> > > -struct mesh_net *net =3D node_get_net(node);
> > >  struct l_dbus_message_iter iter_key;
> > >  uint16_t primary;
> > >  uint8_t num_ele;
> > > @@ -298,10 +297,6 @@ static struct l_dbus_message
> > > *import_node_call(struct l_dbus *dbus,
> > >  return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
> > >  "Bad device
> > > key");
> > >=20
> > > -if (mesh_net_is_local_address(net, primary, num_ele))
> > > -return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
> > > -"Cannot overwrite local device
> > > key");
> > > -
> > >  if (!keyring_put_remote_dev_key(node, primary, num_ele, key))
> > >  return dbus_error(msg, MESH_ERROR_FAILED, NULL);
> > >=20
> > > diff --git a/mesh/node.c b/mesh/node.c
> > > index 833377e99..af45a6130 100644
> > > --- a/mesh/node.c
> > > +++ b/mesh/node.c
> > > @@ -1681,7 +1681,6 @@ static void get_managed_objects_cb(struct
> > > l_dbus_message *msg, void *user_data)
> > >=20
> > >  } else if (req->type =3D=3D REQUEST_TYPE_IMPORT) {
> > >  struct node_import *import =3D req->import;
> > > -struct keyring_net_key net_key;
> > >=20
> > >  if (!create_node_config(node, node->uuid))
> > >  goto fail;
> > > @@ -1692,23 +1691,9 @@ static void get_managed_objects_cb(struct
> > > l_dbus_message *msg, void *user_data)
> > >  import->net_idx, import-
> > > > net_key))
> > >  goto fail;
> > >=20
> > > -memcpy(net_key.old_key, import->net_key, 16);
> > > -net_key.net_idx =3D import->net_idx;
> > > -if (import->flags.kr)
> > > -net_key.phase =3D KEY_REFRESH_PHASE_TWO;
> > > -else
> > > -net_key.phase =3D KEY_REFRESH_PHASE_NONE;
> > > -
> > >  /* Initialize directory for storing keyring info */
> > >  init_storage_dir(node);
> > >=20
> > > -if (!keyring_put_remote_dev_key(node, import->unicast,
> > > -num_ele, import-
> > > > dev_key))
> > > -goto fail;
> > > -
> > > -if (!keyring_put_net_key(node, import->net_idx,
> > > &net_key))
> > > -goto fail;
> > > -
> > >  } else {
> > >  /* Callback for create node request */
> > >  struct keyring_net_key net_key;

--=-+E6D3b31g91Q0upBf1Vb
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwOTI3MDI1MDI0WjAjBgkqhkiG9w0BCQQxFgQU
u7bxyzJHXsB8n2GZP+8mzxsWCCAwDQYJKoZIhvcNAQEBBQAEggEAGJXQFHikTXVH4mNGtz5/Lwr5
FdE5q/SHXMvifFHIg5PoTDx1gjZdRr5/1OgCZLpCb7hnfmuRm2h0umdMNy73N+XY/wpwreKqeYWu
AuCxhcCCTdg6UymF8jkOOAuXMLEIA24FxGoJOhJVEuc+nwQSSWxnNMfN+iT5Tu/haoCITx4uX6+d
j4RZzGHKyOay4tLIiN/37u0wpWgyKC9uIUKKpnISSANkyHCwapwRf+fJxbUy06AwHyR37fer4SA8
4zJDNQWH4inpdfi6cMQqD4b3RLtYc4EGL8Yf9iJq7RSLLTKZwYBxUQbvrupZ2JMMc97wgVpwT6kS
d/c2L0zn7kx+AAAAAAAAAA==


--=-+E6D3b31g91Q0upBf1Vb--
