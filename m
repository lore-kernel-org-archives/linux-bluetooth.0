Return-Path: <SRS0=pDNe=VM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BC5C7618F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 17:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EF22080A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 17:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbfGORAA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:00:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:43061 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730436AbfGORAA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jul 2019 13:00:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 09:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="p7s'?scan'208";a="318732847"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga004.jf.intel.com with ESMTP; 15 Jul 2019 09:59:59 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.186]) with mapi id 14.03.0439.000;
 Mon, 15 Jul 2019 09:59:59 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ 00/10 v3] mesh: Configuration storage re-org
Thread-Topic: [PATCH BlueZ 00/10 v3] mesh: Configuration storage re-org
Thread-Index: AQHVOpsjTTsYd8zyFEamJHERh+G4nKbLyMqAgACUygA=
Date:   Mon, 15 Jul 2019 16:59:58 +0000
Message-ID: <6155440ebc5a3bfd987a48b0b26c132449a3b3c0.camel@intel.com>
References: <20190714232320.20921-1-inga.stotland@intel.com>
         <20190715080721.a4fcaqsdcqimeajc@mlowasrzechonek2133>
In-Reply-To: <20190715080721.a4fcaqsdcqimeajc@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.157.2]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-UT+SslpGmr9de6W71dSf"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-UT+SslpGmr9de6W71dSf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Mon, 2019-07-15 at 10:07 +0200, Micha=C5=82 Lowas-Rzechonek wrote:
> Hello,
>=20
> On 07/14, Inga Stotland wrote:
> > + rebase off the tip
> >=20
> > This set of patches introduces the notion of generic mesh-config
> > API
> > that allows the daemon to be agnostic of the underlying node
> > configuration
> > directory layout and the format of the file(s) in which node
> > configuration
> > is saved.=20
> >=20
> > Currently, the daemon supports only JSON-based configuration
> > format.
> > It is expected that other configuration formats may be added in
> > future.
> >=20
> > As a result of these changes, storage.c and storage.h are obsolete
> > and are removed.
> >=20
> > Inga Stotland (10):
> >   mesh: Move network config setup from storage.c to node.c
> >   mesh: Rename mesh-db.c to mesh-config-json.c
> >   mesh: Change mesh_db prefix to mesh_config
> >   mesh: Move load from storage functionality into node.c
> >   mesh: Confine dependency on json-c to mesh-config-json.c
> >   mesh: Replace storage_save_config with mesh_config_save_config
> >   mesh: Use mesh_config APIs to store node configuration
> >   mesh: Manage node config directory in mesh-config
> >   mesh: Create or re-use a node storage directory for keyring
> >   mesh: Rename mesh_config_srv_init() to cfgmod_server_init()
> >=20
> >  Makefile.mesh                          |    3 +-
> >  mesh/appkey.c                          |   19 +-
> >  mesh/cfgmod-server.c                   |   31 +-
> >  mesh/cfgmod.h                          |    2 +-
> >  mesh/keyring.c                         |   36 +-
> >  mesh/{mesh-db.c =3D> mesh-config-json.c} | 1071 +++++++++++++++++---
> > ----
> >  mesh/mesh-config.h                     |  172 ++++
> >  mesh/mesh-db.h                         |  157 ----
> >  mesh/mesh.c                            |   15 +-
> >  mesh/mesh.h                            |    1 +
> >  mesh/model.c                           |   23 +-
> >  mesh/net.c                             |   26 +-
> >  mesh/node.c                            |  224 +++--
> >  mesh/node.h                            |   13 +-
> >  mesh/storage.c                         |  656 ---------------
> >  mesh/storage.h                         |   51 --
> >  mesh/util.c                            |   39 +-
> >  mesh/util.h                            |    1 +
> >  18 files changed, 1219 insertions(+), 1321 deletions(-)
> >  rename mesh/{mesh-db.c =3D> mesh-config-json.c} (58%)
> >  create mode 100644 mesh/mesh-config.h
> >  delete mode 100644 mesh/mesh-db.h
> >  delete mode 100644 mesh/storage.c
> >  delete mode 100644 mesh/storage.h
> >=20
> > --=20
> > 2.21.0
> >=20
>=20
> Reviewed-by: Micha=C5=82 Lowas-Rzechonek <
> michal.lowas-rzechonek@silvair.com>
>=20
>=20
> I have a style question (as usual, unrelated to this patchset ;) - do
> we
> have a preferred way for verb usage in (public) function names?
>=20
> At the moment I see:
>  - mesh_config_create vs mesh_net_new - my preference is _new/_free
>  - mesh_net_node_get vs mesh_net_get_io - my preference is to place
> verbs at the end
>=20

My preference is to have verb at the end, but it seems (and maybe I am
mistaken), that bluez in general favors this style:

uint16_t bt_att_get_mtu(struct bt_att *att);
bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu);

I personally don't relly like mixing the styles (although I am guilty
of this myself). So in this patch set tried to stick to the one that's
prevalent in bluez.

Best regards,
Inga

--=-UT+SslpGmr9de6W71dSf
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNzE1MTY1OTU0WjAjBgkqhkiG9w0BCQQxFgQU
Nm+Rk89R4A6lT+hg8RR5oGZpgUowDQYJKoZIhvcNAQEBBQAEggEASwlS97CxMgkKXteuRqa2VVSN
pV3pY41JMty/bshoQuvYdyg8re5iRz1Pi4f1QGme1p0/22csOywWyPRssnNmY+f30uSMECF1duK6
2jDMvfTItH0lNKdPZazj011zTJk6vzBCnhFmZotqs/Pu/9xjdF/SV7wZV8ZwmL0dyDYGMR3FatFZ
qY/FggaH8CqXk5P0Z/gxJzHzSNqYAHjz5bwAN3PypaniVpHEHYk4DOeO6L+k7neWU0ZkFHeYzULD
4DhkW8+6ZkE3RUBauHbNYQEgcbmN/15rJpV0AtKck4gOqot9GiDRKXY+JbHSKFeQ9e5dCugLAcif
a6deO5jX90IzUQAAAAAAAA==


--=-UT+SslpGmr9de6W71dSf--
