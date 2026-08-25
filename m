Received: from sonic310-13.consmr.mail.bf2.yahoo.com (sonic310-13.consmr.mail.bf2.yahoo.com [74.6.135.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192C0470451
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663825; cv=none; b=biSEUhOjrtPqVyZtDJogFHXub6ZhKOwmAGiQklcfy2vj5TCwKeGdC2atJNTvcyucJf5hkGZoLuEYaK+KfYSC4GFmoHa2iYiTd2dXuTptLABfjQP0ZGkKQeMnr3J0uftaKkGMX9vpvaeRgF352hvpzAeO6ic0uU1WYCOHrYlkF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663825; c=relaxed/simple;
	bh=5lvZEeePKXwKHZuxoO/Thx3xNNJOgu/CcwEwpOTY/Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=M4Rdqwd6aF5f0Zi+R3flwGIlncW65WFS+KSSPqBucQsCzDCloMP+vMP/eNY4UJ5FlD6amRTVPIHy65oVj2kFc7OliITFZYE2jcAfGsh+1JH8eE1XThrC4SM0dIZp+Yik8cBkCDcLhAT/v8fT39n0D3qRGlowcNsWuV9ZQOa9ETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tcNnqf37; arc=none smtp.client-ip=74.6.135.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tcNnqf37"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787663823; bh=umZdVvWx241cVezu8JBxBuYEdMvYR7wur4xPHDhW2gQ=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=tcNnqf37NsqDkChRIn2wua9al5rqqkXigfal95YE1ZmsiVmeAhkJRLaGMGf+3c5fDYzUqg0YPOSLcvIOsi2F5sVxVqUJA5w/GqQS1fipDdSdvtyWi6bMo0IU79+AW8Rw2i2+ac2wrsJwX3RVejAuaMwV03q/tphAs6we0P0+HgLRxLwViI/MViCMPtPey/Rro7YnqQBuUYPwnWX1cfx/C4NJaNVNZPLG5YqBqvTf9Vwgp0WuAO8FbsLazn2/WLsK9cWC0U7R1STbzdFFUFIsfD/zc2z8tlIdXjiWz47dhwXeR3T4+9mXpNQlOhZR83zi1W4Oe5BYgNe7aLymTl8kNw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787663823; bh=xd9VXl8Z1vrsEwP/eD80ZyzaWXluPJt2z0YBQIPO//O=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lkgrQ6UTKrDdYoY0XRp3mHWk/7cairLmsFTHIor1wq06jG7GyBIoXSAzGJfg238b8YA0NjFmywZHy2+F3pyUYGg2MMZgRVTTfdzeCKe6tvzVCarItgSXuCKM0B1EnqglVg5uQzuUmjPiN+xSGoXhM7fu1hSnrPyOZbdix21dJihlQbEYf9nthuAZcn/HrULBmjdoO+uXpc/CXSuhwLKrFHadWSaK5fSiPRSAcEKV5oAe9Bs+eL6TJ2ZVLaO10bQQgS7WVZcUnQ+WexvqXMnIA/kUzlMY7/MFxXX7ADpvc1idkW0A6UzRT+MoYp2o2spDimVF74eiLpIyGQqdmp6fEQ==
X-YMail-OSG: hAPoh.EVM1mu4toK3C3q4iYcCYhSvE55_gfq7T0u_leffywuPo7PwJsFih1U0LN
 cTaSMrObfwP7k3m2dqW2EntXRjRsCxCmC62PnYzjD3vFfWi.yafcdU2itSASIUU9eczmCNy87PL8
 L4yGDPYYaEmvGK.wmB9DGCjRU78w77HEK.nkgh_p1i0drxtvI76HkWG6t8RzfMTKAx9xG6KyTsVA
 v_uN9uQE06XlJsN.49ricMlQbybi4sZnbHd7WKKLylON2YKf2T0hoQogibYmqx8NrrTlVGkrD14g
 Yfo_7gqQwtgKYfwCDssSJdKAOaxXOjildXbarD6Q9o6k9TLRzVLtYqxZJjxeftOdGHEL8Z6IcLgj
 sdOqLvHqS8Z0rAmFKz0zJTMFe7ULoIAhrURZmw1D.R7eC5tZHd11jfLhJTmiC4oTMTc_Tjeaif_n
 MYLN0lbW2L2SDz_piOmCdNtbHO36dejWJfn6PHw6PJabPnCyBEitc0BfKEydSgwCvvtyWqztiQJ7
 CTK9Vp08sjGU3gbOEuoDxMkGAH7qm_mfw394dRQBAeLjwK4zktAUjBJAXZMOQvjvV.bABgl2hwU4
 b1d6bihJAcfJ5FAQjhdUd6px7TocAMktTRQP8dMGS4O4fYy30iWELoWrc_aA0.a2oMQgRAHHn6.z
 YYfALG4Gv75RZuUFn3tWyjrbqnLUle9VRTjUJeaC0QnSBymTqcTmrUs3cWgMYGX0U8LcIfm_HNCr
 7nZ9rMPrJYD4_Ilynnd8SbVn7CgI0Qns6pSzHM2aTHhBEAfeioPfl9CbSL1sZYhvbxqKGbV5KEG8
 yAVmj5kqJY6marviMoHaP3C2PqfPxpOi09iaOclJCRruIbl4f3voPuKme9J2BGEBRwr0wBx_YCkN
 zxgOOZew94QwxpI_0XSNZJQfh3LZni7Bht7g.gkUOHII2LAGkXLX9ThzXUEQtd4iCnSDJkoFLchv
 nCd1qVFsHOTOiHoJPzbQQPpuHz2zc7gU1MCmHer7.rwipBC2ec2AVRn7UkFPpa4XxhNoIIdunakh
 M23wkaw5lJ3NZw9YVkRhLDLtpaMg0n6ur12oAp5iqLDyfy414Xh.n77YXnvqFCvoOeJrP6tcAHCy
 3vthc2g0ZbvF3shjzUgU7eZy_IDL377gv2Z2WF8WZFNIJWBVmlhiAFpRBPL03vKzu.jSTVxRFZEJ
 ZoLuMhjS.4U5sYTci05RRx.xRX3lDm4akfvd78Quj1rx0U6HoCcYwiWKTM7lD2kO_wxeIgT_Owtj
 ODMDGCmCQJoVo.dLO73c7fUVm2gA4vycu1.u9klWql1A0WzsFi3aBEjYQs5GMq_q._XXWkVvm0Vl
 mT2BD4oNUfZg1kPTmVW1YxaH4qUkfKxY_UlSGZ6S7jdQH7Kxhti88oM5m8os8_Rt9w98cA0XROcT
 TNEI_ORpGLOM4kzeF.f.eySWyMHpltpy5Z9p_MKBcYwvO_gVw5R6V38JUy.JxUAHsbXGr_07_FxW
 KBYkBonsPQBWP6iUd3MZlF6XCZvvEI0Cl4KLrpMuNyT0VdV..JR4jmRebxHfcuH.BnIDmIdd_aR7
 8UN5dk_eVcDxrnfRVAmGdoHbJCAZcYs.8U0Ug0LKabVTGGhcqGI10rGVH112rGv5txZS75IHCix6
 0Qb1_uutgT2LzUmgrwUUKrdWp9u8dUSiVqliJVm7Wx3_BJy9AC.CVMDPcjselXs6EHPxjl8ajLoN
 KVWm7LVH4xO3geT3Vzgiv231pSCxRUyQKAC_IyCyqP5zc7m624gHNFyiWVmKFrQR0evYWT.8G1h6
 IFYVNAjCa_.ImB61z5TM4xeiqwz614Eq8xzYr4cS1SrR7lXO3NpUhK_tus.PHOtg1R4Vebnx6JSa
 YtB.dwXBIYz5hsXQt5MqvlGf_XcfEdg6XtuIHN5yA7_NM_tmZKVwmh7qs44RFriJCrFofsc52wOP
 QI67ns2HZvMgY.wbNmeHa84RkCRbGfaPJqKXZJ2rsAoWBcH.YnGeZzj29JGNmwtNFT0VbTtxCjrR
 .f1Wrl_Ts63DV2c6.13YVUGjyVtRs1jDMQSDWIqai2W1j2ho0fSU.HvQwjRJmoktIeyLzcdNERvV
 kFzHszEU9pGqrP6aJAM_N0.P_0ZUBoFkoYGOQCPyf_Lj4R.W3C.YOGCsxe58pt__CtUVD9Pt04P2
 C_lspQtK3WNb7p7B_3ZMggraPObD.ap.PEjJ807vtpFIIwEO8e5jm9AbYmo45PeeLaVGHxAUpZtg
 BTHPvOxPTwK3xLqgCSmzWGJl6O2j.4p9nUrlklH7Cwnhx
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: dcf8469c-e44d-49a7-9d65-360637aec76f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Tue, 25 Aug 2026 13:17:03 +0000
Received: by hermes--production-bf1-54b5569bdc-6kxfq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bb20fdf1390791c517a7d411121feb0f;
          Tue, 25 Aug 2026 12:22:18 +0000 (UTC)
From: Jeremy Dean <deaner92@yahoo.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Jeremy Dean <deaner92@yahoo.com>
Subject: [PATCH v3] Bluetooth: Fix code style error
Date: Tue, 25 Aug 2026 12:22:07 +0000
Message-ID: <20260825122207.101868-1-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260825122207.101868-1-deaner92.ref@yahoo.com>

checkpatch.pl flags the zero-length array members in struct
qca_dump_hdr:

    ERROR: Use C99 flexible arrays - see
    https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
    #3110: FILE: drivers/bluetooth/btusb.c:3110:
    + u8 data0[0];

Replace them with DECLARE_FLEX_ARRAY(), since C99 flexible array
members are not permitted inside unions or as the sole member of
a struct.

The struct layout is unchanged, and everything compiles with the
change.

Link: https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
Signed-off-by: Jeremy Dean <deaner92@yahoo.com>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8f7ed469cac6..b78c4a0e75fd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3103,10 +3103,10 @@ struct qca_dump_hdr {
 	__le16 seqno;
 	u8 reserved;
 	union {
-		u8 data[0];
+		DECLARE_FLEX_ARRAY(u8, data);
 		struct {
 			__le32 ram_dump_size;
-			u8 data0[0];
+			DECLARE_FLEX_ARRAY(u8, data0);
 		} __packed;
 	};
 } __packed;
-- 
2.43.0

