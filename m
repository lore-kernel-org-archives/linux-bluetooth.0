Received: from sonic317-27.consmr.mail.bf2.yahoo.com (sonic317-27.consmr.mail.bf2.yahoo.com [74.6.129.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D081B4F0C
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738015891; cv=none; b=m2u8jFjqgvovZhxJjWuY/3mShHgzUeCptRq+ZrRACM0P/2Fs81N8fM7d1ZIVsbIJFL0toIU6YZZuB9r+psnPXTUOAitHz9qxtl7G7avyi+jbRc/CAmsZDg6zAsgRgTR88J1C50vT5JrJ1G4JHpWmJeWnpx0HZocpWEcA9vlTZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738015891; c=relaxed/simple;
	bh=CBOHhSyFqzQd8/OpQEQo6urg2FsWsjl3H7Ft1+T5+Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=KftP7eX8R5bcntYbu/D6e5yGhylH3k1hv/vqSK7clGKTbF4mfgcsu4ppzS3Kq3C9omJFQnHwlcrjrt29ZCplDmrA9/zGoEYTEtsxofcNWnU5j/5TeswvyFUIkdiHJ6TYsuOx2nsMiXa0z5yuBxXAb75QJiGtwswrZMEnn+tlHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JVQwXayB; arc=none smtp.client-ip=74.6.129.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JVQwXayB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738015889; bh=Il6HVX7bFBftH1cuTeC6ivhLQHYS8wHuABBCTP5CJAE=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=JVQwXayBDILxVYQ3TX6ucxlGhxFQQk8Q3oL6HhTLHzMoUK4QM9U+DS6yArOMuDXBedQ9EW+cJ79kjK9x85yzeXAVj4PqZwwdnanpfmF3FB6PnnKsLpGY0w1LslntEn5a7BB/5knHjuosIfZ2TB5IlFkElIPmRAlI+4Fbv0fkLt5wruOYVHD/OPkbezCq/Mk7+6hUEmyGTF+xovgIb2T2E7iDqBU+pX1qtRe7gB0C5DwdQcg8IUFM7qwlC/lzx+tmPK+azYJ0ST32Ec3UdxyHasoHrZPL4kUyF0m7vjb2jYPbTUDF7D71508If47Fu2NTBo6UciC2bn9RJEYaMr5Q0A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738015889; bh=yZ8/8LZo9Lvu8aE8Cv4oKfIhlsOXmde/FyFYdOf84DD=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mm/dNFcOMWZkOLmnYfSEK+vwRxZY3SthM6w5/A0AFdqDUSr0ADcPjsJ7uwDhqOi97xM0Wc2t9cm//WHI6eLGwL9fLcYx5/iIsQOK9siHxJfXtmEu5StUk/7mLicdObU4nPf0/LVNu5iFduh3884Wk5YpXaDG+qd/1vpjCyT40Yf0lsVxpNBIhUfGS5yVks1javKHzHFav7BNyA4sg/1jbZR/mzIbfHbYlktj5kya2zv6W8z976J61y28IVBgg13gAo6n2OtolIffYB+5hakJyP2EEkFnvhNQoA0V/LvCeLWBskLP2whUip83m/9kh4cdxOOefw8k5LhZpTf5rwZSDQ==
X-YMail-OSG: RhkY734VM1nMS62CT0qhyInlwuXKzIKCW1u.P5dn4sa3C.TO9mglDvINMFgz9pG
 vcuIQKLMC_xiMzsSspzB.SDf0CilUJZt8m4.I_F9A98VNCI0kkD68bq_Nis7xHXwr1taLzv0NHCb
 zDVcp_Cwz_TKMgtMy8iU9kURtJW5j4kUoE7Mt.HFuqhaPD9b6H53Ob1IXB667jI4GXetOv7P_059
 CvWKDC44Ia6RRFmosVYnuR_8QgKxWi9misEe_6CK6TiHzQpHr3JGWJtU2yjj_HJA3zBltR314hC6
 BELhCJ3z9NIROJ6yDBxArgK6zIyWHm_NBMJr5Y4_DB4uk8BumRszy0J2p4OOMiVV2Vv4sR5x0ACd
 2yVPagCABCiZyQ345U39phq_sgSv3rKA6t0uFranwUamMhFENL4n35nOGRMiK57kImFlWg7tc_aP
 7MZp3sNULTKt.IdJFGlW4sF7g0_eui1fOJwfCo1aPiDmKF3swm7W.pn.wT2xaWy_7AiimzCDPtb.
 LLftFUYit6ZPQTkEZNXr86OsdjKyFCAZnZOtVatb7qNUsMH2Od5229iVm14nLmGU7pV4KOk6X4pP
 m9kHXfvJ1CwCekHc25gWTPdkxuFzTj5JflhmxKR5AAIYxAxe5vN_ZkJ0nfa0WtWnzb3_EMuaC577
 3NWL0bNkuhlyTWQHNFOD7zHGezSmX0vkINqAw6n2SQa8dEBWejj3qa64S5FEM5k3B6d2ua9md1ga
 SnRNc1YYBMLm5n_HZ640T0wx3ITkKEBi_aLWGNLDTHDbkZdgq6Vexzj.7mj_qtxkoTCBeSTaoxB5
 rC47OvVi015TQ3neuK2Q9R.hyuC3ui4.fz9lJ9EHophUH1.wwUE6bcL3YSpkBvClwvkeI_2cwF6S
 96XEcRIJI7WX2cFZO0Q973JRQdSUabDhsRsQYTAeUtPg46DIiEv3zHkQnWNTvowOMPgFWufhmZAz
 dQ6HC6YVVzLjhJhBU6fX7WqmOU36Ms0U2TgBJr8tq.Rr8r6a801Be.1iOypItVaRlLRXxWZdil58
 TykYT9x3IwVwPGn.vHqEGjLeqWwDgB9Q2v9d2eQThjIxWg.HSDtLa4usUUjOxiiUAr3jJX.ckRZO
 IDnqONL0l7h3vM6aUUd6m.LNRjORv5hxVUYp4rgxPSEuOUZ6LjGQaXttmD9608mepvDlefHjAgpc
 ogjX7msiK0PfwjolFhAUCPps0MGijL9Efb0p3hoNxXy1f5YFpHl5eL0wAKe6ebBtxVeuFeauhMbK
 3R6iFGdetUfWchxQULeCFNoCLkELVkCjqTKIsdMWrStAsdy_g6PFGGnRVcBjKR7AyTEOU4KcxRSl
 G3g8T6WN_zCD6ixFJ3mL1nFJcycAzKVygDyJf6JFfdiSbeshc7b3Q72e2FC3O23NnoQ_Q0FsXObb
 wds_Gb3_xUTVRqnIZps.EOsmNcHMfuyfTcE25JBPesvLCK11tiMR0XF_qz4FIjwrKSwJ_Tb4lHDJ
 PoJ7VQzRSnSoPWSnLe5RpfpsOlipqPlDWwmsdp_9GMDF5IPtElxGlO6r0e0fouwyZie45rY235ah
 yxTr1iCRfaTJiqgQun4ickaAQNEVTAJly7szaI8FXuGhHC0xB0B6NOCRY4KNX9muloDu.IEVduLz
 e25B6SU62hvGRJ5Otn5.oCAnqY_YfPzw7qiUbKlrzxmdLnR6kMg2cJ3bt2vtyG2m5ZS22Ijsky99
 Upr3Rm_c9K6h4wYvxPZVHQfhx4sz8cBWFu_p7zwAgQhRRqrJGG1vPhm2ob6_2qPTPj9PX7L3wtG5
 SE.I6k4m__0GayDCGnrwaXEEZ39RjFecZFxqbYN71yDmJtFDB8v1erPILA06YLi_zKnDZQxjgdY.
 tIlMu9xi.isCzeMOFx5EeDPIpzb1QdTI7Cm2B9F2lpBFgYicF3fnvc9e.b9..cYuYSPEstapy6MS
 vRxzwbPr2w30xNvrI2ndsrZeoDvVN12X.zXRGoVkS9fAGiNQHnj25OcauU92ZfOYoVlI8rQbJ1nb
 _SB2ldJytYvOGPS9aAHqI85_RW_QhejtcKWuvywGBy04CAxhZKyGfCpzi4iv2XyHmU2FRrH4aU2D
 7I0iSV0NVi0TEpXllNMWRvNWe.TLXdvP2jRvQcsYSypqjCxy.WDj_3aaMi_RkygoE7rzJF.G99ia
 yyxz7ANTHiPZUg9lDWLVpPqMtYkOJJzYrumxT5wLtOyloCJLCgCpmeranelGODwXpNBRE1KjWIol
 HS8qmeFt1DOZtLXxRP36v9v.IrUIZscpFWWou
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: d41b19b2-7aff-48b5-8b4e-6c9b9f3efd8b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Mon, 27 Jan 2025 22:11:29 +0000
Received: by hermes--production-ir2-c694d79d9-d879w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ed331bd1b501c76ea5c16f45057da5f0;
          Mon, 27 Jan 2025 22:11:26 +0000 (UTC)
From: deaner92@yahoo.com
To: 
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	markus.elfring@web.de,
	patchwork-bot@kernel.org,
	Jeremy Clifton <deaner92@yahoo.com>
Subject: [PATCH] Bluetooth: Remove unnecessary braces around single line statement
Date: Mon, 27 Jan 2025 23:10:37 +0100
Message-ID: <20250127221052.197899-2-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250127221052.197899-2-deaner92.ref@yahoo.com>

From: Jeremy Clifton <deaner92@yahoo.com>

Warning found with checkpatch.pl script. Remove unnecessary braces.

Signed-off-by: Jeremy Clifton <deaner92@yahoo.com>
---
 drivers/bluetooth/bfusb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index cab93935cc7f..0d6ad50da046 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -365,9 +365,8 @@ static void bfusb_rx_complete(struct urb *urb)
 			buf   += 3;
 		}
 
-		if (count < len) {
+		if (count < len)
 			bt_dev_err(data->hdev, "block extends over URB buffer ranges");
-		}
 
 		if ((hdr & 0xe1) == 0xc1)
 			bfusb_recv_block(data, hdr, buf, len);
-- 
2.43.0

