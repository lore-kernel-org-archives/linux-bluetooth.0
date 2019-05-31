Return-Path: <SRS0=aznX=T7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C866C04AB6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 May 2019 23:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3AD207E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 May 2019 23:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEaXyW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 May 2019 19:54:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:38732 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfEaXyW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 May 2019 19:54:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 16:54:22 -0700
X-ExtLoop1: 1
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2019 16:54:22 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 31 May 2019 16:54:21 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.150]) with mapi id 14.03.0415.000;
 Fri, 31 May 2019 16:54:21 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "denkenz@gmail.com" <denkenz@gmail.com>
Subject: Re: [PATCH BlueZ 0/1] mesh: Convert all crypto to ELL
Thread-Topic: [PATCH BlueZ 0/1] mesh: Convert all crypto to ELL
Thread-Index: AQHVFkPxZn6H44r5j0SrN+eCfmOIKqaGYSQA
Date:   Fri, 31 May 2019 23:54:20 +0000
Message-ID: <84279310ecdc7b6b9a0bb81ff8faff1cd4d44d91.camel@intel.com>
References: <20190529172818.8844-1-brian.gix@intel.com>
In-Reply-To: <20190529172818.8844-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.90.242]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-KzfqhPGjHRV8Dh2/NZct"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-KzfqhPGjHRV8Dh2/NZct
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patch Applied

On Wed, 2019-05-29 at 10:28 -0700, Brian Gix wrote:
> I am copying a larger than normal list of "interested parties" of
> this patch to (finally) convert the Bluetooth Mesh daemon to using
> the ELL cipher and checksum APIs.
>=20
> This will have one major side effect in that it will no longer
> support kernels older than v4.9 (I am personally using v5.0.17).  I
> am told that (some?) Freescale platforms also will have problems
> regardless of kernel version.
>=20
> This does not change any functionality in the mesh daemon otherwise.
>=20
> Brian Gix (1):
>   mesh: Convert crypto to use ELL wrappers
>=20
>  Makefile.am   |   4 +
>  mesh/crypto.c | 518 ++++++----------------------------------------
> ------------
>  2 files changed, 58 insertions(+), 464 deletions(-)
>=20

--=-KzfqhPGjHRV8Dh2/NZct
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
/2uO+36toXJIrkRSOXG2qYEzQI5kZ0sbLp1dcxHIXP6hMhpL7+m2bT6VgQIDAQABo4ICKTCCAiUw
HQYDVR0OBBYEFIZVvEpBGkcRsJgSGlrm4o7AsTA9MB8GA1UdIwQYMBaAFB5pKrTcKP5HGE4hCz+8
rBEv8Jj1MGUGA1UdHwReMFwwWqBYoFaGVGh0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkv
Q1JML0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDRBLmNybDCBnwYI
KwYBBQUHAQEEgZIwgY8waQYIKwYBBQUHMAKGXWh0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRv
cnkvY2VydGlmaWNhdGVzL0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUy
MDRBLmNydDAiBggrBgEFBQcwAYYWaHR0cDovL29jc3AuaW50ZWwuY29tLzALBgNVHQ8EBAMCB4Aw
PAYJKwYBBAGCNxUHBC8wLQYlKwYBBAGCNxUIhsOMdYSZ5VGD/YEohY6fU4KRwAlngd69OZXwQwIB
ZAIBCTAfBgNVHSUEGDAWBggrBgEFBQcDBAYKKwYBBAGCNwoDDDApBgkrBgEEAYI3FQoEHDAaMAoG
CCsGAQUFBwMEMAwGCisGAQQBgjcKAwwwQwYDVR0RBDwwOqAjBgorBgEEAYI3FAIDoBUME2JyaWFu
LmdpeEBpbnRlbC5jb22BE2JyaWFuLmdpeEBpbnRlbC5jb20wDQYJKoZIhvcNAQEFBQADggEBACuN
3bQTKWnPqjCfAI95E3JEdS7jc7y7fY2FiTcofo0hiDYjZ97kdpZo7BwqWvOcMEPWfst7YQyy4naa
uS8RvC2+BM8rYtvYj0uvUj/AbwZTnlQILUtyOykV3GzyauRwq6H3fPpZeOrMbbHSsJICjGvoAUQ1
aOiV1qgLYnlrTzis6UQx+7JjzYkmRajfnMR1NcD5rNa5n8CcmvwrhYxPptvyo9FKMw5Dtwri7DUs
7bl/ls14Ie8Sf8LLJBwGUOMWtDcEToMqjBZgPhC/6CBuI74UfFLbOt9tg6QMNFtbCy5H8HQUjq+P
tLltdkaAwpAE894tf9fUhD+oz7s/o6NV49IxggIXMIICEwIBATCBkDB5MQswCQYDVQQGEwJVUzEL
MAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRowGAYDVQQKExFJbnRlbCBDb3Jwb3Jh
dGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWluZyBDQSA0QQITMwAAyrfo
9lLjvkm/BgAAAADKtzAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMTkwNTMxMjM1NDIwWjAjBgkqhkiG9w0BCQQxFgQUxDCr9JdnIq0EoU1L0DC3
5xE55pwwDQYJKoZIhvcNAQEBBQAEggEAMBee0x/KR7YjzQYN6GpTV0qPZQaBWn+/dFTMFfOcYWwl
Sm+U6LJzddTSGI68pLeuGQzjok5TUHFna9pf1kmNeYa1eu/mxvmIp8FXlh02iErPQZdVUbbl9d8x
arzzGe55habOTzfFYRNkym0eHd7iLM+mIrvPYxvnlTBHnrguLotJvYP+MxiszOFV7HYvCa1vyjhQ
8dB9Xr+xNQejAmRxYOfLXukceQONrg/R8pJIGOGIPHCf+jn/hyDp4+ahug6/xINzTYb6zFhsgT38
H6pZAfm2DtxX2hmE3PHUhPe7b03qQyuThWkIEBAbNWCKfIp0jVS4F4VHYhWafsGbzgoUGQAAAAAA
AA==


--=-KzfqhPGjHRV8Dh2/NZct--
