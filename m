Return-Path: <SRS0=LpJm=NT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5BFECDE4B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Nov 2018 18:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CC6204FD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Nov 2018 18:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CC6204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKIEXX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:23:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:44236 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeKIEXX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Nov 2018 23:23:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 10:46:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="p7s'?scan'208";a="94725755"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Nov 2018 10:46:35 -0800
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 8 Nov 2018 10:46:35 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.166]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.106]) with mapi id 14.03.0415.000;
 Thu, 8 Nov 2018 10:46:34 -0800
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ] doc: Initial Bluetooth Mesh API
Thread-Topic: [PATCH BlueZ] doc: Initial Bluetooth Mesh API
Thread-Index: AQHUdjPOFfcPMtpxg0mqvkcMU8kOyqVGOeYAgACGiYA=
Date:   Thu, 8 Nov 2018 18:46:34 +0000
Message-ID: <c2485caca3145e8aaaa1a8396b294b46a55b97e3.camel@intel.com>
References: <20181107004950.9153-1-inga.stotland@intel.com>
         <4DBB63ED-41C4-4F27-B2BC-1ADB090B1656@gmail.com>
In-Reply-To: <4DBB63ED-41C4-4F27-B2BC-1ADB090B1656@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.188.27]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-DP2o56Ii2MHCYW2OtQ90"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-DP2o56Ii2MHCYW2OtQ90
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Thu, 2018-11-08 at 12:45 +0200, Johan Hedberg wrote:
> Hi Inga,
>=20
> At first glance this looks quite good to me, just some cosmetic
> comments:
>=20
> > On 7 Nov 2018, at 2.49, Inga Stotland <inga.stotland@intel.com>
> > wrote:
> > +Service	org.bluez.mesh1
>=20
> I don=E2=80=99t think we=E2=80=99ve had the habit of versioning well-know=
n bus names
> so far. Or did you see this somewhere? So I=E2=80=99d just leave away the
> version here.
>=20

=46rom D-Bus Api Design Guidelines: (
https://dbus.freedesktop.org/doc/dbus-api-design.html#api-versioning):

"In summary, version numbers should be included in all service names,
interface names and object paths:

    com.example.MyService1

    com.example.MyService1.InterestingInterface

    com.example.MyService1.OtherInterface

    /com/example/MyService1/Manager

    /com/example/MyService1/OtherObject
"

I chose to do the name versioning based on the official guidelines.
However, if we want to preserve the historical bluez approach, I don't
mind changing it.


> > +Interface	org.bluez.mesh1.Network
>=20
> The way the existing interfaces do versioning is to have the version
> at the very end, so this should be org.bluez.mesh.Network1
>=20
> > +Object path	/org/bluez/mesh1
>=20
> I don=E2=80=99t think we have the habit of versioning object paths either=
.
> They=E2=80=99re anyway (for the most part) irrelevant - it=E2=80=99s the =
interfaces
> an object has that defines its type.
>=20
>=20
> > +			PossibleErrors:
> > +				org.bluez.mesh1.Error.Failed,
> > +				org.bluez.mesh1.Error.Canceled,
> > +				org.bluez.mesh1.Error.InvalidArguments
> > +				org.bluez.mesh1.Error.Timeout
>=20
> We=E2=80=99ve never versioned errors either, or did you see this done
> somewhere? So just leave it out from here.

So you can see a number of services following the above mentioned D-Bus=20
API Guidelines by running d-feet: e..g., org.freedesktop.GeoClue2 or
org.freedesktop.UDisks2 or org.fedoraprojectFirewallD1


>=20
> > +		(object node, array{byte, array{(uint16, dict}}
> > configuration) Attach(
> > +								=09
> > object app_defined_root, uint64 token)
> >=20
>=20
> This is a bit hard to read due to the long & complex return value.
> I=E2=80=99d suggest doing the line break before =E2=80=9CAttatch=E2=80=9D=
 (a common C coding-
> style as well).

Agree

>=20
> > +		void Send(object element_path, uint16_t destination,
> > uint16 key_index,
> > +								array{b
> > yte} data)
>=20
> Minor inconsistency: should be uint16 instead of uint16_t

Agree

>=20
> Johan

Thank you for the review.

Regards,
Inga

--=-DP2o56Ii2MHCYW2OtQ90
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
qgeHX9huE/RglO+l2pX/ibOvV3KbK72H0uI+Ko6K4x0iujCJdP2dWTFQYCnqmbc0erfLAgMBAAGj
ggIxMIICLTAdBgNVHQ4EFgQUGwd2DaCkW69Bb0Ax9i/qo3OUn/EwHwYDVR0jBBgwFoAUHmkqtNwo
/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5jb20vcmVw
b3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwNEEu
Y3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRlbC5jb20v
cmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRlbC5jb20vMAsGA1Ud
DwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9TgpHACWeB
3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsGAQQBgjcV
CgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBLBgNVHREERDBCoCcGCisGAQQBgjcUAgOg
GQwXaW5nYS5zdG90bGFuZEBpbnRlbC5jb22BF2luZ2Euc3RvdGxhbmRAaW50ZWwuY29tMA0GCSqG
SIb3DQEBBQUAA4IBAQAE0b0TS/W2TRjCL3GGHZWPQmaRY2a1hjS3Vej/JH5Mb/VI7V4xZ3/goERD
dtst/nrbf7bNXLod0Zvod8Aw+KgeyaNpvB8Qe+mkp9q6smeL8Xn7FTh+wXM00CWDXiiBB6z2bLeh
liq9LDXsz8aFC01FEKkrxYdGG8Yh8dZjj1d0h9d1k+kOAll79iNJrNRytzHPbKHI0elxsQwBQ+sF
W3QapqJf4LrCDkXRk3VJXet78Q/3Fc8/nX4YFHPmmoggHLfeZCipGmnvRjJwhonK+98UtQMqNi9I
y/wm+mH1uSd2qcWKKvexa4IiDkjiC4BshSlIFril/12kbU152Amp3yPfMYICFzCCAhMCAQEwgZAw
eTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UE
ChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3Vp
bmcgQ0EgNEECEzMAAMFNnLH9Ee8ZkVEAAAAAwU0wCQYFKw4DAhoFAKBdMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MTEwODE4NDYzMVowIwYJKoZIhvcNAQkEMRYE
FJkq4eSUWZtvjlDWVTYbh3mFuUNJMA0GCSqGSIb3DQEBAQUABIIBAIYuMF2tVfsLusW1iEn8o+Sy
1dh/52QxVIoYTDKVhBNxjlY63nZcxSx7ddB21dcNPFkrPzHhENoYDlclg+6DZa42i6KxZBcRTiIN
1vUMnCc5/96/7zVcgdRZMWHgubkht7Bp181EP78n/Qz9E6fEc5D3PDrMxLtSw5WDWcsJSdYkGICB
3sBJBbiNdtuZ5+5IPYf9+w7svOarlFN36v2kvhY/dHYzp+6npkFhfBgJ4Fa1pshN+4UXL1SPduAs
miijS+++fR8DgYfKROBcUZqIzjZ84y1GeWD8dmuYIvLOm5ab1OeBoL0Xec2N3cRahzBAwou/n7U4
licMPyVLoT4Rxo4AAAAAAAA=


--=-DP2o56Ii2MHCYW2OtQ90--
