Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3685A3191D3
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144273; cv=none; b=A3dPsrYBgHONOxRWpjFC31TAfQVyznUTric1QWnp9gSZTq7AIkN8ZL+YyjaTuhqWNdCUGS35I7awU7vrh/9rr2V66SHcy2coPrxWNOSHhcRF0f9E5qmqydsYc7Pqx/KBO4yJ+mNuZrr5x7/p3HqMKsO562txlwtZXgll8e/xrKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144273; c=relaxed/simple;
	bh=SBnRSODcu+BEcMd+HCD9hRp9IxuD24gRkwX5OrkVLig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1BFa7awpFhWvmo5jQxN6fDjOqqRANKJSoQez4B/6fAv4BaQIvv6nZVQ+lcuN4V4olR0GQwHPGQRhZdlyQaL2P5i8n4tF1KpN4LdXmWX0C+08bQn8R7lVRiofxMjePlea5qgtet5ElyM+orMSD1zn2TCLKJBxk6M20ul2OKK2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p1E0BnoB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YE+48cqx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p1E0BnoB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YE+48cqx"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JClGRE870930
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bJR4NmkM02I7TCKsHwKAlsIMTf+H3Xz7PHX
	Xsr1YvVo=; b=p1E0BnoBweztQLgbQj5cofd7eEa+YXb6eLSpht8aErTrLdIo5VN
	U4Uw/dbPxR7mPu2g+LRzwML06Xat+GU9tJMq663X2q9h1AjRXy1d1UbQTAAkqTFv
	EOS5c3HoZ5X+tJg0UqNJ/iMlES1G+/C/3Av8gMyirUoj2UytI/EqBJNbmmouCvC7
	DhFrKqKGw3bIz5GgLyBYEMSsDH2dtDsZvdV+e2412G759LrLfSgIWkO+4Rt4KyOH
	TmL0TZDKjp4Mel9HbbySFGwsZtBhH/5XXunZ28w1YSaR559O7Yr1yqSRLCcjBkbl
	BidHADccYJf4BI2iLbdzZYmPxGi9LnI0mCw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfpu7xe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:57:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e63df032bso230865185a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787144270; x=1787749070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bJR4NmkM02I7TCKsHwKAlsIMTf+H3Xz7PHXXsr1YvVo=;
        b=YE+48cqxleTuWfiLwLvS4RSr5dMGilPoRt9f1oL5t/TQ8Lu3DunG2NxOHUHa/Cs86l
         MLNUXyY+YGLo7dV9xcziwQvGn9v1dlHmx+jFKoN7PKMiPGrJYRvzdrgz4XNP5+uoabHy
         himSCUZzkgJdAH5FZMKqDB2y3mAzEOg+B5jlnixVSVrdNaYbjp6rj1pwOs0HspUyb//P
         A1TIfI0E4zAeTIfOiPmIxSJbuXn4OYkzK1WDDJLd5BFZksGEJwPnfYfgZSRDJWt5qJPI
         XaYseLmMVuoqpgPA+cMnq0fnnLsxcO/RWL/ovEFZ0S45h94DNiStqF2IIAEHUnX1qh2e
         9A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144270; x=1787749070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJR4NmkM02I7TCKsHwKAlsIMTf+H3Xz7PHXXsr1YvVo=;
        b=j7iwVYhqT/pPMMpt9BgYM41gT0QFDLTu8XXqQJpt2NLnFqA9vzsz4SkV+CuuO2Hh4U
         SJYyfGX16IXRO/vNuH5ElbWIVUllJ3bdj8689bNvqru77DjdgxhVM6ZXWe3amkKbSf4R
         9uuvH30WuglRHERGim9q2xa0vMGBB2UrtkWifacaKAhDzaVJ7j6l0SLPJi55jZvyon+e
         JmHFGVgduU2xS60uQ7XFgkRLaFeCU7JmqsQgat7zznCY49MD59jY0VNDrJshbOy5eMMk
         +Zh8fxAOQiRXSVt19TVm7JHwnE3u01FLfbPY2udVj2d84azCoKOpQxzTUFz0kNF3cFzl
         G/Vg==
X-Forwarded-Encrypted: i=1; AHgh+RqE7JSul0BaPycoWMLLvB02Tnl3Y8VHMYwKQogVKyy7AT9P5Va2Bkz0Ro3o6HY7UKiOoOY2gK1cMFQlZ9vimfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwIVcQlokdwjFP7wee/hbaxOUItQPWzzcYVhQgwu0wFd04+AA9
	fwYjbLyqE6/bgR5b3lKDpvs9Ooc54RdFJvLyy5sQFEYwiAzBsWbQYcR8/myJQIStkTADzT0GP8I
	ED2PLyd0gjGJIjPSf73dKnsOLU4RyQbaX1glCKksZhkVW2iNTQ0B7nc+iTSdWyPy+8GlE8+g=
X-Gm-Gg: AR+sD10QRhdxZf6o2bUqItL9gviIcg6mI4aeiBWO9DQIsL9W4PJqxcPFB0LO4Zg/GT5
	R163vqHzgn5ZGtEGtEJ2vJRQzD5GY+ZlQE2lp79o7EMo1fXgTK3MNQvtrZU5FYujcdJD97iDGQE
	QS7h57UmfYQq0tJ6xkOBXSMEKvt/oRpbywBKizeHiOjnzEe2XKRT/6zjRLZkLHdOx1tN8rAUl8E
	bcMU8HG2WOSDsoZN75ApJiyBiXw/1Qaq2OPMArLOH2VbNUApTPPrybMhB4jPOo5is4Up+y1aAFy
	4QeakzP+6NZNByAoi3Q3PMVJNCPDjiFBHwBq4cGyT8hoUqRifebSTkkwjB9nl6jS1z0BbzcY6mJ
	OG9Z6Uf3qXCslylD7dTnRXtWHl9igHoPAE/inDGA8rNxVv7HwvQ1iGMA0A62ecjQbR0avtMp+kc
	cf5Du4Nn4JuVKgt+o=
X-Received: by 2002:a05:620a:4613:b0:932:db03:4da3 with SMTP id af79cd13be357-9371e7046c1mr323571885a.19.1787144270393;
        Wed, 19 Aug 2026 05:57:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4613:b0:932:db03:4da3 with SMTP id af79cd13be357-9371e7046c1mr323568685a.19.1787144269924;
        Wed, 19 Aug 2026 05:57:49 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c38c5dcsm68931666b.44.2026.08.19.05.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 05:57:49 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] serdev: ttyport: Clear serport->tty after freeing
Date: Wed, 19 Aug 2026 14:57:48 +0200
Message-ID: <20260819125748.194377-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CdGdyXDFjUzvrWX6M4R7jBnWteF6R_gN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfX/QJBvyfB/OKN
 sEAdQONYXZEGENJLacztStW6Pgsl4LMSVwfhiJkWCygRoq3gVGVoNDMBfadvFdKmaLFmNstSkgA
 DYootB0qmJ7Y68q26YK7K8JFYtw5XLuJDoBuHl5L4zv5zNCCQaDaQqeDGJEOSIwuD/TOtdHJSZV
 EcB7NWhTPmU2XkKPpfOhkDiZ1aNq+GCAQW076GAWcpEbHEFwc5FiioYfrgM3PnbV2aB7q0nrQY6
 Kx8AQo7DPoHL9VJ97ni/B+nFZJ6e/coy8D+3aRwybb+rt6KeCoxyfELWaxmE5oFs229WQY2wAVk
 +VxaEj6WR4AaQ9pZ0q36mI2FLqu8qrR7LjpWp6KkTt+OIBtclo3Uzb96hvzJmyWSztQh5JYN1k3
 w8dQ7QhdjDezo/8OlaSLEx6xZXu5xfcpgrUdMJooNeOXFTaQ27oe93eGsJKO/LuufQcMEEd8rhx
 PHN6h4LCNkWmwngV+8g==
X-Authority-Analysis: v=2.4 cv=aMrAb79m c=1 sm=1 tr=0 ts=6a85a84f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=c0e1n4jylXfP7e-yc8IA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: CdGdyXDFjUzvrWX6M4R7jBnWteF6R_gN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfX68+as6W91i7d
 O+r7SUmku0Z9YmHFbcYHnTjgWjbHjboIrOvdSEGKyalRLQwn+7/VO9dQ+eMZdlysYc3rt3+0OxN
 XoqpeNgfjAoqBYDAIphCLiToABxNgKo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190100

From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>

Both error paths in ttyport_open(), and ttyport_close(), release the tty
with tty_release_struct() and leave serport->tty pointing at freed memory.

The serdev core itself never dereferences it afterwards. However, a buggy
driver could easily trigger a use-after-free by calling a ttyport operation
on a port that is not open, or by calling close() twice. While those
drivers should be fixed, clearing the pointer, makes them fail
deterministically instead of touching freed memory.

Note that a driver which currently double closes gets away with it only by
chance, depending on whether the freed tty has been reused. After this
change such a driver oopses immediately instead, which is the intended
outcome, but it may surface latent bugs elsewhere.

Signed-off-by: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/tty/serdev/serdev-ttyport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index bab1b143b8a6..b6638f9f40d2 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -137,6 +137,7 @@ static int ttyport_open(struct serdev_controller *ctrl)
 err_unlock:
 	tty_unlock(tty);
 	tty_release_struct(tty, serport->tty_idx);
+	serport->tty = NULL;
 
 	return ret;
 }
@@ -154,6 +155,7 @@ static void ttyport_close(struct serdev_controller *ctrl)
 	tty_unlock(tty);
 
 	tty_release_struct(tty, serport->tty_idx);
+	serport->tty = NULL;
 }
 
 static unsigned int ttyport_set_baudrate(struct serdev_controller *ctrl, unsigned int speed)
-- 
2.55.0

