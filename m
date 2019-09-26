Return-Path: <SRS0=vBm7=XV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A6FC4360C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 20:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C940822459
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 20:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfIZUlN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:41:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:58553 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfIZUlN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Sep 2019 16:41:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 13:41:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,553,1559545200"; 
   d="p7s'?scan'208";a="341577443"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga004.jf.intel.com with ESMTP; 26 Sep 2019 13:41:11 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.5]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.204]) with mapi id 14.03.0439.000;
 Thu, 26 Sep 2019 13:41:10 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Topic: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Index: AQHVX2LEtJoH6czNyE6Xu9DaIe4hzqcxs2yAgAuqpwCAAVPggIAAWhSA
Date:   Thu, 26 Sep 2019 20:41:09 +0000
Message-ID: <a0442c7485fef2bfde9bc52283a5c9dfc0b43515.camel@intel.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
         <20190918085239.xhahxoeqjkcrk3bl@mlowasrzechonek2133>
         <3c5858c94b3e08a61c5ff8493f9b00f5f77d0aac.camel@intel.com>
         <4b57242b15ccb44ac123858ce7bdf6e0e526b3e0.camel@intel.com>
In-Reply-To: <4b57242b15ccb44ac123858ce7bdf6e0e526b3e0.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.132.116]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-yZO7n1SYOylM/xkxdo9B"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-yZO7n1SYOylM/xkxdo9B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian, Michal,

Pairing down the cc list since we are down to implementation details.

On Thu, 2019-09-26 at 15:18 +0000, Gix, Brian wrote:
> Hi Inga, Micha=C5=82,
>=20
> On Wed, 2019-09-25 at 19:02 +0000, Stotland, Inga wrote:
> > Hi Michal,
> >=20
> > On Wed, 2019-09-18 at 10:52 +0200, Micha=C5=82 Lowas-Rzechonek wrote:
> > > Hi Brian,
> > >=20
> > > > Imagine a dot-matrix, where each pixel is a mesh node.
> > > >=20
> > > > Each of these pixels implements two models:
> > > >     on element 0, a GenericOnOffServer controlling the light
> > > > output
> > > >     on element 1, a Blinkenlights Server model
> > > >=20
> > > > Blinkenlights Server extends GenericOnOff Server and
> > > > GenericOnOff
> > > > Client, and on top of that contains a translation table mapping
> > > > group
> > > > address to either 'ON' or 'OFF'.
> > > >=20
> > > > Now, when Blinkenlights Server receives a GenericOnOff Set
> > > > message,
> > > > it
> > > > looks up the destination address at the translation table, and
> > > > sends a
> > > > *different* GenericOnOff Set to *its own* element 0, with
> > > > target
> > > > value
> > > > determined by the translation entry.
> > > >=20
> > > > This allows users to configure each node in such a way, that
> > > > sending a
> > > > *single* message to a group address causes all pixels to switch
> > > > to
> > > > a
> > > > preconfigured pattern *at the same time*.
> > >=20
> > > Per conversation with Piotr, I'd like to revisit the discussion
> > > and
> > > provide more details about our use case for models knowing the
> > > destination address.
> > >=20
> > > Please see a diagram at http://ujeb.se/BmTIW.
> > >=20
> > > The main reason we map scenes using destination addresses is that
> > > such a
> > > setup consumes much less unicast addresses.
> > >=20
> > > Assuming that:
> > >  S - number of switches
> > >  B - number of buttons (elements) on a switch
> > >  N - nunber of lamps
> > >=20
> > > With a 'regular' case, number of consumed unicast addresses is
> > >     S*B + N*(B+1)
> > >=20
> > > With the destination mapping, it becomes
> > >     S*B + N*2
> > >=20
> > > Since we typically use 4 button switches (B=3D4), without
> > > translation
> > > we
> > > consume unicast address space at a *much* faster rate.
> > >=20
> > > reagrds
> >=20
> > Okay, this is a good argument for exposing the subscription address
> > in
> > MessageReceived().
> > It's better to separate the method into two, e.g. MessageReceived()
> > and
> > MessageReceivedVirtual().
>=20
> I wonder if we could still do this with a single method.  I can think
> of 2 methodologies:
>=20
> 1. A simple way that just uses the U16 DST field instead of
> the "subscription" boolean (not a 100% reliable differentiator
> for Virtuals, but may be sufficient for the use cases given).
>=20
> 2. Replacing the subscription boolean with a u32 "Subscription ID".
> A subscription ID value of 0x000000000 would indicate that the
> message was received with the Unicast address, and values from
> 1 - 0xFFFFFFFF mean a Subscription that can be queried for. This
> would be accompanied by a new daemon method which could look up
> the details of the subscription:
>=20
> {dict subcription}  LookupSubscription(u32 Sub_ID)
>=20
> Both of these methodologies would allow an App to be simpler,
> with no added D-Bus Methods required.
>=20
> With the 2nd methodology, the subscription only needs to be
> looked up once (or not at all) to 100% differentiate between
> discrete subscriptions.
>=20
> I *really* do not want an additional mandatory App Method. Most
> Apps will be simpler than that, and truely not care to
> differentiate between subscriptions...   Particularily Client
> based Apps.

While I am still in favor of two distinct methods (given choice, I'd
always go with self-explanatory API), one method approach would work as
well if accompanied by detailed and clear description in the mesh-
api.txt doc.

I vote against u16 destination field since there is no reason to
create address space collision even though the chances are small.

A single method "MessageReceived" method can be modified to include a
subscription parameter as:
1) a dictionary with keys "Group" and "Label" (self explanatory if a
bit cumbersome).
or
2) a u32 subscription ID that represents a subscription. This=20
requires the daemon to maintain the relationship between "id" and the
actual address. I believe the daemon does this anyway for virtual
labels, but from the API design perspective this is not very clean
IMHO, since it has a whiff of implementation details leaking into user
interface API.=20

No matter which approach is chosen, the subscriptions must be included
in the model configuration dictionary for UpdateModelConfiguration()
and in the corresponding dictionary for node configuration returned on
successful execution of Attach().

If we go with a single method and a u32 subscription id, the
disctionary representation of the subscriptions should be a pair {id,
actual subscription address}. This way there is no need for an
additional daemon method.

Michal, any comments?

>=20
> > Then it makes sense to add model subscription array as a dictionary
> > entry in the UpdateModelConfiguration() as well as for the node
> > configuration returned when calling Attach() method.
> > Probably will have to have separate keys: "Groups" and "Virtuals".
> >=20

Regards,
Inga



--=-yZO7n1SYOylM/xkxdo9B
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwOTI2MjA0MTA5WjAjBgkqhkiG9w0BCQQxFgQU
OzGs7NbDFE3gGDNSk1QQeiWi5CIwDQYJKoZIhvcNAQEBBQAEggEAoKsVutQdYnohTrmXregZa1UL
r2ruOj/1AgMd8R8drtftJt1ol+ySHfMqdCTujKixf+qRl7SLEOvgZrm992aM1AtgZNwkURj7Gbnh
leUUkmRz6axrCCChF5K+6yp+9mpCHeuAZd52bNpVx9VQ3YfuX2q/FnL+4btLf7YP22dQBQMMGHoz
KnXLxFM2PUGri1u/+JAyac9QYToXu8o3Ccuiv6sg99gCR5tCFJHQmN3yAcM3NDmGdNd9YSHVILW9
1paxuyN/l9HJxGhmzDWt4/rUARsfan+eOwRKVTPqpuwen+bFLugOTUfy7a/B6qO/zhCDQ/8LL4FO
yafSgeNhuV0KxwAAAAAAAA==


--=-yZO7n1SYOylM/xkxdo9B--
