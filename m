Return-Path: <SRS0=G1Nt=XZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7B7C32792
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 16:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733532168B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 16:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbfI3Qe0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:34:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:38166 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731976AbfI3Qe0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Sep 2019 12:34:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 09:34:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,567,1559545200"; 
   d="p7s'?scan'208";a="366052064"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga005.jf.intel.com with ESMTP; 30 Sep 2019 09:34:25 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 09:34:25 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.5]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.201]) with mapi id 14.03.0439.000;
 Mon, 30 Sep 2019 09:34:25 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Gix, Brian" <brian.gix@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Topic: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Index: AQHVX2LEtJoH6czNyE6Xu9DaIe4hzqcxs2yAgAuqpwCAAVPggIAAWhSAgADMPACAAHTCAIAAGquAgAAhmoCAA+uugIAAm3EA
Date:   Mon, 30 Sep 2019 16:34:24 +0000
Message-ID: <f690abe8480c06b2f942465c68705b92bf4a34b4.camel@intel.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
         <20190918085239.xhahxoeqjkcrk3bl@mlowasrzechonek2133>
         <3c5858c94b3e08a61c5ff8493f9b00f5f77d0aac.camel@intel.com>
         <4b57242b15ccb44ac123858ce7bdf6e0e526b3e0.camel@intel.com>
         <a0442c7485fef2bfde9bc52283a5c9dfc0b43515.camel@intel.com>
         <20190927085208.sxy2x5656ci3opo6@mlowasrzechonek2133>
         <01c84f55db98fbcc2790d11fd6090589881c36cf.camel@intel.com>
         <856d4e6bfdbe84b7b7ac3742ebede263c7801346.camel@intel.com>
         <86e707237937cfb5c4e8fea8e96924f4590ab0a3.camel@intel.com>
         <20190930071803.nvp3ema26ynuiwz3@mlowasrzechonek2133>
In-Reply-To: <20190930071803.nvp3ema26ynuiwz3@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.134.73]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-p2HasnkqaJB1oW8UqnRQ"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-p2HasnkqaJB1oW8UqnRQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal, Brian,
On Mon, 2019-09-30 at 09:18 +0200, michal.lowas-rzechonek@silvair.com
wrote:
> Brian, Inga,
>=20
> On 09/27, Gix, Brian wrote:
> > > For a single MessageReceived() method, the cleanest way is to
> > > have the
> > > subscription address parameter as a variant (suggested by Michal)
> > > or as
> > > a dictionary.
> > > An array introduces an extra consideration of byte ordering for
> > > group
> > > addresses.
> >=20
> > If variants are easy to sort in scripting languages like python3,
> > than I
> > suppose I could live with this.
>=20
> Last time I checked, it was C that had issues with  any type of
> 'dynamic' typing, so I wouldn't worry about client languages.
> Handling
> D-Bus variants in python is trivial.
>=20
> > Or is this still a two step process of:
> > 1. Determining the u16 vs u128
> > 1.1 unmarshalling the correct type...
> >=20
> > What would the signature of the method look like?
>=20
> Something like this:
>=20
> 	void MessageReceived(uint16 source, uint16 key_index,
> 					 variant destination,
> array{byte} data)
>=20
> and on the Python side, the handling would look somewhat like this
> (since Python doesn't do overloading, at all):
>=20
> class ElementInterface:
> 	def MessageReceived(source, key_index, destination, data):
> 	    if type(destination) =3D=3D dbus.types.UINT16:
> 	        group_destination =3D destination
> 	    elif type(destination) =3D=3D dbus.types.ARRAY:
> 	        virtual_destination =3D uuid.UUID(destination)
> 	    else:
> 	        raise DBusError('Unrecoenized destination type')
>=20
> > > What I mostly about is that the represenation of the subscription
> > > address in the MessageReceived() method corresponds to the
> > > representation in the configuration dictionaries for the Attach()
> > > and
> > > UpdateModelConfiguration() methods.
>=20
> Agreed.
>=20


I am fine with this version.
Regards,
Inga

--=-p2HasnkqaJB1oW8UqnRQ
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwOTMwMTYzNDI0WjAjBgkqhkiG9w0BCQQxFgQU
FNuj+nLRGoVM7KgCZl1vK/yzmxUwDQYJKoZIhvcNAQEBBQAEggEAE+W9W2t89mPIXYX7WhOfbFPs
XODf6Xq/547NoYHp1WZhXAR0FyIOe2u/HklN3Ye4s5fuNkOzQBvbSW3rXm03CAVOOjpnku2gZfKO
b4HfzCuvBjNc5h8RfST6ybdszQY5kORJqiajZHdn5CRSALT2bpvQg9JDb6d/dDfL9eGjg1b0+Roz
xGeOxNWaelkjfBwVpuw/3/kADxWbevhaADmxnywDyUyhnSZ7cleiU81/vgJqsxIq5ROMdd0ibvRp
pNSMdCNV16dC1W6dOEs8UBdGonkRUNi93Vn7lgxo8goVxGz6IgZVgQJvul7mZOHAkfUDeY0NkGuO
CiqiuuiIC+onHgAAAAAAAA==


--=-p2HasnkqaJB1oW8UqnRQ--
