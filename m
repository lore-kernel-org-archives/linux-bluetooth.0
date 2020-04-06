Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7AFC2BA18
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 07:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5544C20719
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 07:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bshg.com header.i=@bshg.com header.b="gWsRocCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgDFHRK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 03:17:10 -0400
Received: from de-deferred1.bosch-org.com ([139.15.180.216]:32820 "EHLO
        de-deferred1.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgDFHRJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 03:17:09 -0400
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by si0vms0224.rbdmz01.com (Postfix) with ESMTPS id 48whgQ5mBFz1ML
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2020 09:17:06 +0200 (CEST)
Received: from fe0vm1649.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 48whgP16nfz1XLm4F;
        Mon,  6 Apr 2020 09:17:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bshg.com;
        s=key3-intmail; t=1586157425;
        bh=tF3Iaog7iytoGaxAknjdxA+N7vcyg4dkRoAgB/KBIfc=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=gWsRocCeE3Bc1EyqGqttt2bEDFlXSSutHz2DFhZB+OcGL3RFsE3zGea34TCz8qSfB
         IlF4qX/BtaZFib1yvUhv7vk9FKJhMBWZQuOUs1qfi40ybD730Xqu3iY9HDVr/RxAik
         Vwumf33mDgXai30TsF/fDnqogMnU02VqzCsQaW4k=
Received: from fe0vm02900.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1649.rbesz01.com (Postfix) with ESMTPS id 48whgP0mdRz1Mx;
        Mon,  6 Apr 2020 09:17:05 +0200 (CEST)
X-AuditID: 0a3aad0c-935ff70000004734-a9-5e8ad7709b4e
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm02900.rbesz01.com (SMG Outbound) with SMTP id 59.79.18228.077DA8E5; Mon,  6 Apr 2020 09:17:04 +0200 (CEST)
Received: from SI0SWIEXHC01.bsh.corp.bshg.com (si0swiexhc01.bsh.corp.bshg.com [10.49.76.137])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 48whgN499KzB15;
        Mon,  6 Apr 2020 09:17:04 +0200 (CEST)
Received: from SI0SWIEXMB1B.bsh.corp.bshg.com (10.49.76.130) by
 SI0SWIEXHC01.bsh.corp.bshg.com (10.49.76.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 6 Apr 2020 09:17:04 +0200
Received: from SI0SWIEXMB2B.bsh.corp.bshg.com (10.49.76.132) by
 SI0SWIEXMB1B.bsh.corp.bshg.com (10.49.76.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1913.5; Mon, 6 Apr 2020 09:17:04 +0200
Received: from SI0SWIEXMB2B.bsh.corp.bshg.com ([fe80::5154:c3ab:d4e0:8272]) by
 SI0SWIEXMB2B.bsh.corp.bshg.com ([fe80::5154:c3ab:d4e0:8272%5]) with mapi id
 15.01.1913.010; Mon, 6 Apr 2020 09:17:04 +0200
From:   "Ryll, Jan (GED-SDD2)" <Jan.Ryll@bshg.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "Klein, Thorsten (BSH)" <kleinkastel@googlemail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Klein, Thorsten (GED-SDD2)" <Thorsten.Klein@bshg.com>
Subject: RE: [PATCH BlueZ] Fix error code in case of invalid offset
Thread-Topic: [PATCH BlueZ] Fix error code in case of invalid offset
Thread-Index: AQHWCYsOfMsc6P8aUk2YqfYJZ61xv6hnzQkAgAPmavA=
Date:   Mon, 6 Apr 2020 07:17:03 +0000
Message-ID: <6d8b670966a54eeb84e0a18b7c5255bb@bshg.com>
References: <1585899568-14564-1-git-send-email-thorsten.klein@bshg.com>
 <CABBYNZL25S=U3kF=oLygOc9ktvtFK94+BWzzqFujDDgF22HBwg@mail.gmail.com>
In-Reply-To: <CABBYNZL25S=U3kF=oLygOc9ktvtFK94+BWzzqFujDDgF22HBwg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.49.87.38]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-Brightmail-Tracker: H4sIAAAAAAAAA22Te0xTdxTH+fWWcilcd1t5HKqwcLMlwyAWmVAeISZj+CBmTLP94ZRZ4VIq
        tEALihoGGAijPIOdkw6YEAhsQkBeEwUcTUFspAYNDBzoNt6oyEuQDcZaLgh/7J+b8zvf8znf
        8zu/XBzjt+MCXCqPoxVycRTF4bK5PtWOe2N+U4UIs2o/ErW05iBRYV8OJhqdV5sfxA43a4Ys
        Do/mXbU4PF/nFIyd5PqF0VHS87Rin/8ZbkTaQB6KGbRM6Jz9nZOMWixVyBIH8mOoLEllqxAX
        55MFLBjP7MCYgx6BvrBmQ0lhwZDhNYc5rCAoWK5mMYduBMtzbzimZhxSCH2qQcwU25BSqOpY
        W8cxMgXBd9eurws7yU+gIV9tzhQFQH9/hQUT+4Cus3c9ZpMfQHf6S7YpJkgvqB3r2rDOQTCs
        LV8XLMnPobdtYB1ApCPU1j5aN8BIe6gbWzJnrkdCWQuTB9IWJof/3ci/Dzn6SWMf3FjvAjV3
        9jGoM6gz/7RgfHnwoGCEzZT7QkX9HygPOWi2OWi2aM02WrONvoHYPyO7cFp4Xibc7y0UuinO
        0spLQne30GhZHWJe1Po20mfNuGkRC0dadABnUbZEk1YVwt9xNjrsYoRYGfG1Ij6KVlICIull
        xmn+zndpZfxZmVSplEbLtQhwjLIhBNkZIXwiTHzxEq2IZjAt2oWzKXvClns5hE9KxHF0JE3H
        0IpN1RfHKSCme42GPAUtoRPCpVFxmzLlSCAzMzO+3XZluy0Lt9QiD9za6E0YjC0IZYxYppRK
        NnAHBudvZrdQPfoMz5ssKsXw9o5i41dXVF6K8dnyaDktsCfumcYhTVREvPzdNILdxJdNxgva
        bhO2Ok6hQYQjaichN8HWxv9maw4gkk2r420kt6D9lUaGLMOg+PYbBDUjk2yoed5lDv0qHRem
        lu5ZQddq/Q7oGuoRQIW20xXK7j1xhfslDUK4+eJbD1h4sOoJuidaL5ioHRJBw6sRX9DlVvvD
        Ylb2Eai8NXwU+t+2BcHale5gmGi4+wXkzRd9Bc81C6chL6VZDBP/FMng6fVGGRS2PlVC17L6
        Agw0ziaZitMQLGSPqRDkZ2TmoinjnlnGPXPk6aY9x4nj/mfPG9mtCwqSWblptrm7xXS+9w3P
        qBP8x6n2Ug+vUNFixTV76LH2n37VFOncXqEPmDrIm1d7JEoP3aqTcFeWfp0NWnNQG5we+jys
        r9csIZ3A/b7K/o6FkvKbC/KTBIraeR+6FwWUp2dS04F3+Z71ewXHYr8nTs/fXbFCJbwJz7c3
        Fd4vRuLyY4428zqEfS5t1xIbq2xOth2TSI4cWEw7F6sqMtArHoeu/H0Ca8WaI3/iDST/Qhmq
        Uqc/Tb0gk5cm/DAWGhvIUZ9qPJ6kmrmV++y90OBd7uE9o8OJTpcDl+cCzhSv7nGhmp/NvH40
        /mOEXQE4uxqSawxpflbHR73HHg+Nt0We6/rrm1MUWxkhdt+DKZTi/wDzobxfVAUAAA==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0Kd2hhdCBpcyBtaXNzaW5nPw0KDQpSZWdhcmRzDQpKYW4NCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGxpbnV4LWJsdWV0b290aC1vd25lckB2Z2VyLmtlcm5l
bC5vcmcgPGxpbnV4LWJsdWV0b290aC1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFsZiBP
ZiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQpTZW50OiBGcmlkYXksIEFwcmlsIDMsIDIwMjAgMTE6
NDMgUE0NClRvOiBLbGVpbiwgVGhvcnN0ZW4gKEJTSCkgPGtsZWlua2FzdGVsQGdvb2dsZW1haWwu
Y29tPg0KQ2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7IEtsZWluLCBUaG9yc3Rl
biAoR0VELVNERDIpIDxUaG9yc3Rlbi5LbGVpbkBic2hnLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0ggQmx1ZVpdIEZpeCBlcnJvciBjb2RlIGluIGNhc2Ugb2YgaW52YWxpZCBvZmZzZXQNCg0KSGkg
VGhvcnN0ZW4sDQoNCk9uIEZyaSwgQXByIDMsIDIwMjAgYXQgMTI6NDMgQU0gS2xlaW4sIFRob3Jz
dGVuIChCU0gpIDxrbGVpbmthc3RlbEBnb29nbGVtYWlsLmNvbT4gd3JvdGU6DQo+DQo+IEZpeCBk
YnVzIGVycm9yIGNvZGUgaW4gY2FzZSBvZiBpbnZhbGlkIG9mZnNldCAob3JnLmJsdWV6LkVycm9y
LkludmFsaWRPZmZzZXQpLg0KPg0KPiBSeWxsLCBKYW4gKEJTSCkgKDEpOg0KPiAgIGZpeCBkYnVz
IGVycm9yIGNvZGUgaW4gY2FzZSBvZiBpbnZhbGlkIG9mZnNldA0KPiAgICAgKG9yZy5ibHVlei5F
cnJvci5JbnZhbGlkT2Zmc2V0KQ0KPg0KPiAgY2xpZW50L2dhdHQuYyB8IDQgKysrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPg0KPiAtLQ0KPiAyLjcuNA0KDQpTb21ldGhp
bmcgaXMgbWlzc2luZyBoZXJlLg0KDQoNCi0tDQpMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo=
