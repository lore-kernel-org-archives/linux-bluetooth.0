Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569A3C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 16:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192D4214C6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 16:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c927x+pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfAJQsA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:48:00 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40630 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbfAJQsA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 11:48:00 -0500
Received: by mail-wm1-f48.google.com with SMTP id f188so12699401wmf.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jan 2019 08:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:openpgp:autocrypt:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=b4s2cEyKd5Lbbhrm3838tItWK1bLYUNgstHLzvAAS4g=;
        b=c927x+pu3KDMIJB6+o539u7HcH7YLi3REU8GsHKOQ8mpe4gypJKOOsBeX+zC5gHIha
         D6bFvWFed2cDl6f9A1dmNB3lq5aGpRPPS5m9Om+YdtJuNgkwyScTLnxgXtXY1yfP7i3+
         l7VINPYHiWr/ZebKFv2pSj6kxVzeJmWQiqJ7KXDutXP/MCP6CLjVTaGkq/EsptLeToz+
         J2M5wRkDLXn8O8d4vMTLYK6JTn58/E76+l0S0ctwgeWVoaev88kaR8vxva26NmvOucd+
         3HxfybVjf+azgtiINpujhHUqstOvUqr0Uj4AnzAf117sDjRqA/YSuEI2tr4Rp2kXGlj7
         48Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
         :date:mime-version:content-language:content-transfer-encoding;
        bh=b4s2cEyKd5Lbbhrm3838tItWK1bLYUNgstHLzvAAS4g=;
        b=AU35KHy9e1CDvf7y7ckveYhiXVh2hux1PAF4UY4OOxtcVuvGBcvhZ8qLvjpw1iQwcd
         Mr8qjjVHWlwUYxpcVUrs0M5VnVrJM/ur3fMkaBDE4CqEq7gsItBH0YWEUun7qCCeLSMh
         UyCNxjOjVVpv9mjk8KoPdL83m1mpiDASqnAvu4xT360pVpIASin+uKcwR3iukkhEGJn7
         cY8imFA8Qcd/RpmWzWfiN103m24i6aoWadzKk+RWBYPs/1I9wWC3RRq4H1FRx8JF0uBS
         m/r5isNFqhnNf7G0TlU+pkK0Au43TzL3J79x/p3BdJ1gc54lLiWvATtuQ/+AeJKDsQM8
         Rieg==
X-Gm-Message-State: AJcUukeDeL6PYt4dyqxvhqR+M86unDY8igy7eIrYQlm48+uYbqlD4zLe
        qRAi0VWLApBCsnzebHgm/LMvwocc
X-Google-Smtp-Source: ALg8bN4P9YiNOY3cXus1LSe986Klw3KqgFjnH0Pjc+kygaopZ4aTzaZzYXFrvUIycmdv3ClvfbDB/g==
X-Received: by 2002:a7b:c852:: with SMTP id c18mr10105013wml.49.1547138876365;
        Thu, 10 Jan 2019 08:47:56 -0800 (PST)
Received: from [192.168.2.164] (p5B08A983.dip0.t-ipconnect.de. [91.8.169.131])
        by smtp.gmail.com with ESMTPSA id a12sm66257687wro.18.2019.01.10.08.47.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 08:47:55 -0800 (PST)
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
From:   Josua Mayer <josua.mayer97@gmail.com>
Subject: [RFC] bluetooth_6lowpan: search for destination address in all peers
Openpgp: preference=signencrypt
Autocrypt: addr=josua.mayer97@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFtbYt4BEACysNSF+vmzzBvR+YgJDK6X34V+WUStfjN3YqbcClZxUWe2rOt3BfxsuG+a
 cmOHVmS5ufOOXE7dsB6w9eviNOO2h/XWCdyjnrtYY4bCxmDzyHV3MZW3Z4OlJWOFffOa5HPe
 fog8Xn5wsLm+tKyMWJAqSjJrJSJmmgucT/QkHOsnUtPRPSDRsTiWBZQgtplgVYswdaGxE8sy
 XIJJfpQVX9G6rm+1Qyc8BEGcgvx9cHjzaK+NbFPo8UsZZ1YxuqPba3Kr7NlmLFp78oTBYtTY
 2bTCtNd/mBKkDd1qhEm/TqX1DElXlnWwKOEDX9FxvWIjVtVP04kdXJspb8U404GLbH3H86+D
 XAjAkXI7QY/CRsmENvi0wzxjb8PduWYslqJA6yMeoJY9iB1aiK/1LetfozUBX1nKhXCzfOz3
 dAaHhUel0dylxRndQP7lpahvZw9FLv9Ijc2gafh7hQ7PxJue1H0v5nrOkyfxr9/kZSLnKk16
 /LD88Wlu3O2oDNOc0Mcw29VGxTkHMsi5qWsYXGX4fFrIpmuZ9L1yNdY2Z0HJEMFC3oP7imts
 X05sQzIdDwlDe9afW5bI1QzYHeve1EvC3hDTjl3uAbKY5tOFs0S6bZo1mXDe7Ul6gCkMJSg3
 j1WKRC9N1fp7sW9qVxfyFYljGVeN2UpJqBXEIghLewgetxnzSwARAQABtCVKb3N1YSBNYXll
 ciA8am9zdWEubWF5ZXI5N0BnbWFpbC5jb20+iQJOBBMBCgA4FiEEBGzKTuBeYuHyxSgAY7Jb
 EByN8BkFAltbZT0CGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AACgkQY7JbEByN8Bn97w//
 WLLmSYDg2e/zlcD0cjtRDnHliDk6b/FVoqPLlY1taFAIzQzptowYLGhwaid4HpghmwmeM0t4
 auadcOPj6Cge/fW+9uTpehP+E4Knp1CpWVNNPfNcad/7wL98rBTy+3huaPnwAIeXdVdc7Jfi
 3nnvX8o1NFuivZ7SXaBKtZo1iSm2B4yn7TndjQKqJ/TzQdYp9Sb7CiG1JWT/hAH8Zax8lETx
 BVhgOPZpe9RH108NlVnVwDtIN55O7iSMAVwl3ON3khuTVFtYmVd7iOFkzUx4TCJ6YSZsWQzz
 NHawbBavHE1DsDdT1BrJsz42DJjuBJXNtEDd/KRzzOhsLDjoZpoIvgFgeNAIxvLozae1ajvT
 1g3Twgb+ewDVsmB9m2IjleNJyIlNG0vTX3/SQPsS6I3sVo1Q30rC6IUGBiK2PKJDkFcPz2xK
 YrdR49t5zBk6olXiCdoYgjlCkA8yxVaFMLMnLxzyfiD5ngT9k74j6CZV/M+M8/7tTyOOk+Ni
 wCe0NCrYk+PED9pLBQ294Z15aA0x83X4a1lmZOh7agspQ3Xsc1KwA7MpHy/P3sAZJt6P77Ft
 YbRXErbzm+ZkWGdCzEYF8khgds+4mTJFWH58Jm1rm0ZsYeyK+VyES/D1E8yCQalWYSw7yQ4I
 ivQwrzjl7HBNmSPMqHRzKSvgoGixABxKiOS5Ag0EW1ti3gEQAMngBnhTg9c0119KxFq1pJCh
 nsCNYlNQXVembZHjxCU7ui0sTJsDotJ4RZfFnIyXuDf0xPpLwxtQsdaShx66MqUEwFoni+X4
 a8j+q6osWF51vNS8VXT3D/gmAubuf0CrVPWmgeU9IvsBtUotfq6dpLkBGqFe9pXHnaUovRbc
 cdXjYBFwUrpxAwNqOJWgLQ9ePEaZ3viXvr0KwIt2YH1n3XWeVqqpGmXevsioVKbP4Jgq8GFE
 pp9VnraEiQ+U8hYGjKRFyCisDSVhQzN1J+XDSYlQ7a4AQZ+C7yO4RJe95JDhc3WN0nzvyEcr
 AFLGgCWOxfEBg++upA3BTmVxESRAGTf+zo6y9rCAgB6Tbj2VZxN82MPbs9C7znKvQR8V5cUC
 XEYlmxIGSuuvJ8hc6q46ygZlZEPD1wvCV+UiQicEv0Qi3f2q4vNQOWCxYcQLIO6eJB6lnUba
 mC9rWQqQiVHc572U7gmsUbRtL8Re8ZuFQZbYNu+kDkMm4gqDLnpM6SLBZRmjGAYkwGssycUB
 nPDRWaKTDhnLqqjlFo+GAXNxt/rG6o2UGqJYASJ96ib0d1l7RbPshDj0hYmkKG62P9C4yR5n
 jkXXnjJKbHcraT3w+WO+bq6qDGiRJGtlYr2u8Y687k/xJzgRRLDdIgO+UEgMNdc5NUzj1f+M
 SmUCySrkuVS7ABEBAAGJAjYEGAEKACAWIQQEbMpO4F5i4fLFKABjslsQHI3wGQUCW1ti3gIb
 DAAKCRBjslsQHI3wGUU9EACqTPgZ8zuH0iBhdViM/RSjXoSUEre40ZdqfX4PwvYw2LWqPO2l
 hMEFB18ljpTQGg5sMBhuzIRWlB7X7E2Pe3cNG6wtzHaaDHr3DXxir/Y+hH3x7Xh8XduzKvsf
 nYxgd8BrNXCeDzzgGzjw27mieAHmitu+TNoq8+whceZ5FVtIs5+1lovHEduAYqMNg6acAjYw
 vCJcCqMD+LwZ7MuZNmzVsmTBOXYt89G51TzEJNnixhpLfvJQv6XjfB3GSQX5t2K7eCnHQjcW
 HwZCi9+/IznvuKIdXtoXDkEYO99/hXq8PYyPzwzQuuhxD7q2y4Vepg892Wd25VXoki1QNDxb
 BSOR0JYYYYi8uUaMUwb//aVOeDSrVB6MC79HezU0U6WabAbwmDMg5RYGwBtOLOg5V4khPGBD
 S4ntspMxn6uwHmUP3bQI9i4/R3ZCbm82BKrDnumvgXA2ZjOocm4KnBUq7iFcHCHtXTF0cP3f
 CKO5ue43dppoEyy/YbY+MykMGSDds0Zo1WS7BLtY1jU57BJpeA2LyB+tlnqneBY7bSiCnLFk
 R445GWURcesv2Be076yKhbVggsu2+1yv+NbToFBhLNhqHJH0e0nUrxmvoWDYRhGIODRtk3dk
 m/pY86DbEeNK+Y8ByMRDt5Pa0RFAOeDAxA8BcPD1/koQbNgp0it70I2nNrkCDQRbW2TiARAA
 yZ4qQ+6XWKDnK8f8fHUSc5U+C8yQJwwjwq8YjTOJAGlrJPH62ap1Bs8KKd0HXLYx3Z0aAOtw
 lGWYUEJtHQAMUed8sYz08dSs5XrRQ0p50o+7Jg12XAqaCqcQjq2XS9YImBB4W2GQASiHwDpR
 ZlJT+s4CfozWMiK0yBiYyYEXv3ndkXq2DlOYXIG3HxGH881RentUS4ufRpe3jS148pKjYg5O
 p142XP9jBVO9sSqMcpQnnJaRlLxt/f3WvhOAgSui+E/VTkR++Avo16hcrM+us05YuGePzHLB
 81ZcENAts9VRBSH0yM1uA1omWgy+iVMqTTtz0KyI5huiktNkDvoT4eO0qV9bvaED+vrZR+2n
 25TuqIPoQpAW6yfdgot/2MyRGEFlBvmshFDuUBwR2HIfIrewb+pCpif9YTCXbT9k4SOwYirJ
 TvItKv/w/AVOQ5jpBd7J2+fsirNYhdC2DgEPW8aJGra0ElwJBS/bS3eIuhQt3jtoTlK9FN7Z
 eE0hpFLqlsJZ3DYunsQ59alZjHo5u9qLDDI2f916zsbI+eajQva9ax/kXWXcEHpQk20MFj7c
 AT4tCbFYy84sPqKMEccY2BrbnlzKvSwHqRJAyK0TApKJk2EG/io6SMU7Ez6O0Rv2JW2XQy8Q
 ROGvD1IwYXOGdz42CeNHTAGvWUwb+xHTAYEAEQEAAYkEbAQYAQoAIBYhBARsyk7gXmLh8sUo
 AGOyWxAcjfAZBQJbW2TiAhsCAkAJEGOyWxAcjfAZwXQgBBkBCgAdFiEEp/mKrntZgfn46C9m
 OMa81b1flPwFAltbZOIACgkQOMa81b1flPyzIw//XY+Lf7v50TDbaks2bHc7sgysIQlYMLjE
 QD4tLXeowgl6NB8uYvU3mok/mgkClXEmYUqNYZtBZ9lW5wdOlZ9tjWKshZEXtCadROAq0ux7
 J5nJMgtQRif9+QmW/DSOR02LZ1x7qGWBbMBGT8kYX4AiXo1RMORbcoXz/a6+RO8LXQeAYdrF
 QIbb5OzVKnAiVLirCUnI3ZMfgyjtAgcHYSNVggHbBOI5bJEwFQvMuD65wzbgLbNQBJXNMeZR
 R9WucRm9GcFZgX+XlwGx/Lls16iH+tgvEnoUJnukNad+EeGESBputyGhtS5tknF1CN7MxHj+
 MI+GOpkcK1+2TUcA4CEn89KiLNVvIkLemWDcBwXC3okiFXGaqmIOGHw4ngErGPbKcmChO/3h
 lRAJYVuYLStJMPcgr+Q8b5li1EzezV2NW3MNpmXEpDnA3GFoch6krI0cyys8680ToByTwRHZ
 HpD4MJNPdS60ZL75gfnO+kTHFirlvw/7Omo+CfbCxTQC2uUneSMvzpZe4nf0/UdYXbo8t7AR
 diUZzKYsfzl/wKtzLaKWvuVJZnV5j+p67uBwoqtCzwZd7srOo1zTmlcHwjcNX0ks/P02Nxne
 8fUYjDzvKm3XZSL7PHoxiQmZlcT13r3thL45SO7DTQCTgRlYPsmM45IZPdmAO03ff0uz2SaP
 HA+TYQ/5AeGp8YXeWJT0ts+7wz7Mf2ztTB/CSusQ44CiboBOKu0+ED5GzfLtk+eDZDXIIWhQ
 yxey8G9JRrthIdRuxeTKqSOePnIyBp8cNllgx7cgyL2oXCHVVOOk8mRC97GoFxw35Ls8FQzg
 knrC0xbFytCLJVIwOXYtJRc+kkqa4X8znhHtSicoUSriSab8vQR7EedXxOSt1abWVh8Y+inn
 hW8nr/lPGdcZlCff72tLlHZEgdwY1o6qKZkudiTdwTwpB+xYDv58TJKDtCUaFiKIjP6YVSwi
 OgbyzAW1diMI246jJg/x+RytRzkWkg4HvOJiUM3y2pr9KaHjFzMBSYADukTuJ6MkcvC1aqsY
 whKXMx5cWMpCisP6kZQNfsfM5UdvFghk+2bs33XNPFOilBozFo9OkEPpc8tezZqq7seZupYX
 4AsCiHxwat8Z+I6ecNNIc0O8zkzUPqJotWehO12vlTpPU4qyDjyn16Ude1Nb+y6cK3R1Bu1+
 baaDWy6Yx9bIat1koYXY0TD9hhIRdQ1Z3T0qBqm2b9oMT8XzhIhlBzwkrku5XmVfHILh6m/D
 Atc5XoeNksMaV6XsdxSAsBT6Vy5Ancd9LQ6hx2F4N/EY2K+X/j63RQwyJSrHXWHyY1if/TY3
 CKEuEwlKLbUIs14huWIjQI1HmQ9RjWe3DUkI6Y6MpmY=
Message-ID: <edcbc506-c247-e5b7-ea78-942d7832d9ef@gmail.com>
Date:   Thu, 10 Jan 2019 17:47:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Josua Mayer <josua.mayer97@gmail.com>

Handle overlooked case where the target address is assigned to a peer
and neither route nor gateway exist.

For one peer, no checks are performed to see if it is meant to receive
packets for a given address.

As soon as there is a second peer however, checks are performed
to deal with routes and gatways for handling complex setups with
multiple hops to a target address.
This logic assumed that no route and no gatway imply that the
destination address can not be reached, which is false in case of a
direct peer.
---
 net/bluetooth/6lowpan.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 828e87fe8027..f706b8a13fad 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -187,10 +187,16 @@ static inline struct lowpan_peer
*peer_lookup_dst(struct lowpan_btle_dev *dev,
 	}

 	if (!rt) {
-		nexthop = &lowpan_cb(skb)->gw;
-
-		if (ipv6_addr_any(nexthop))
-			return NULL;
+		if (ipv6_addr_any(&lowpan_cb(skb)->gw)) {
+			/* There is neither route nor gateway,
+			 * probably the destination is a direct peer.
+			 */
+			nexthop = daddr;
+		} else {
+			/* There is a known gateway
+			 */
+			nexthop = &lowpan_cb(skb)->gw;
+		}
 	} else {
 		nexthop = rt6_nexthop(rt, daddr);

-- 
2.20.1

