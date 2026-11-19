Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090188;
	b=feOKV8DV2FYNoXndYrFb8t8KaV/SP6KqVoNKqOc709wcHIiP1DkDy1gPfKLmPTxl8BSC
	 BmjQfINJ/wVolI0G8zxMEBC1fTQRcJhHiiuwZTUFlu74R+0T2ghLJYlr5e8sm8TwXWZiP
	 yEvHxmy6yWOO2koUg3gSSQR2eDLpOJ9Yvk40CdbWNLnWQtMpExjCqcdGfWt8MLeEVW1YX
	 LezswaYsx4cswbajNOO67jE1wb9M4/SEgjjCebCOk7RT0UE9yeD0BwdU7zoabEwyRbrAE
	 1LUUSKH9nggfepDVNvxfw3jRnph/ejDVBFdwHjAAKLjqjmqK5brglfF7hJherzQ6ZOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090188;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RT+0AKmVcApMzKaYRkKEr+FBqJcHBjpcZhiE+ofNNCk=;
	b=tWYxkREwBjL9Br6p8nQNP6Yps+SCDAf7BocJh/PXid0bNpWc3Qwcggqfh9yVj9acL9Jo
	 tNIdy9Phlhqg1iGcgDbD+9UGp4HkELWmjMp/fy+7MahV59s1QQlZACy+FS9sOiV7ZcGP2
	 3aYc7NyVRaf/b0EAXS/51xRA3w6xtNJz1KQRoM21Jw11ExfmqRQxHvKsYndGvLlBzcJsE
	 fPkyJE3bql7ksQwEz5Gni3/qGrD3ubsiFswa7W7MFjwYHgXfjkuJAZ/GQHf3asJyMKn/8
	 4XsBpyi3rj8qQlBlZzQ7jKC2LeKL6Rx5QYyMTrFMuf9XwVZLmeR68wL2t66cVvKiGWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L1M4CQou;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eI9i9DQI;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730B3606A32F
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 12:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 730B3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L1M4CQou;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eI9i9DQI
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBjvtw705605
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 12:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RT+0AKmVcApMzKaYRkKEr+
	FBqJcHBjpcZhiE+ofNNCk=; b=L1M4CQoufx5wO/CVdDnvzTpGpFuSf1/2xEhUxU
	MEasBz4A8BRWIAxniyY+Z6AcAHjnInrpVRIY2h6dXqbRTs2BqUzIz1UlVEwttcfS
	1ZFIPmXawTnh1aYJhyeae6BVqLs7lHASkOkmMHLTpSk9ZmuzQUEWsUTBlUvNfztq
	3W5jSoSrbwb+iYzF5kMYp1IRavQaR23VuzmfrEdsb9gQbOkeWmXVLWXMF8iw3VIU
	jG4sBdBV0edudzDGHQrM0rM9viENmqa/dcXDtbnkxUXwLu8lQhSUehdB6Xn8Lv0k
	BCmZzL/DqNbYJjzbWXaW/GgUTPZb2ZXHIltcd8pgdfuWW91g==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1x708qrh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 12:09:46 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-567c8af65f1so224678b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 04:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795090185; x=1795694985; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RT+0AKmVcApMzKaYRkKEr+FBqJcHBjpcZhiE+ofNNCk=;
        b=eI9i9DQI2U5/CVrWaOUfn4THLsaSmQ4IkTK7v62Afk3wAwG8lTJtUQmRZ+ka6m21le
         F6sekXpOFfoX2liME64ESwvQoE2/4tRrNU3YKPpOuizgR5Q2wRnyTHKenekEJIThk7qv
         aT+QNL4+RZ3AdeOTfs/aespOFcqntOLg0g4qvWzYVRmLvIxbgMZs+IHaXk+KBjN00T1p
         ROL762B6aQSwAeHGeB02TkGgX7L4kckeIYPNfnwji8i9V4qFM6lQoHjkGrN5ekd5ZpKV
         Ds9Gdn9G/5kBghkYrMxNK8pOBtLpLlAbv2vGHF3Xf6fV/ScmdGC+LYfsGZkOI9dnNxnw
         KLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090185; x=1795694985;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RT+0AKmVcApMzKaYRkKEr+FBqJcHBjpcZhiE+ofNNCk=;
        b=1erg8cXSzG3CmS1EvMQjTtgLudeJEfGkunQ/LFIULRmMKhCf0/0dqWA7dRjo6zHtoc
         wpquQxA3KxZY0okKHbpEmyHUijI9para01VexPgGxli7PWXgy8SguWgVu2x/wJyeaW/j
         eKNszLTPgAfcRVNzi5AaRZ1YsTcGLOWHpGaez+vmoe2rBqGztfIoljceXWcCQpYm0txR
         ixDMj4tzOj6hqpvnTkcyT2ExRRscsNc5pm/UL1bx58OrvwUEK9RfTUQWH2HaJ4zIGMmr
         UDI7ZQZUMaOngnRNhFfZbNswu0LX0v52OXVUkLEjG4Qelb6v0EJoeQeUt7EurGkl3SzJ
         V+hA==
X-Forwarded-Encrypted: i=1; AL+hErFpjAmtfQXW1lF7hsLxtZ+GbL7reRKCjfP4NXxzGcirE2dzqpkOcwIvSL2z8Xa9BPnvMXbQpZ9oxlz3Iooz8Uk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eV61zjaEBN5QVzee93yBV8kD3qaT4Yprw43VNeeqHP8JDb7xQ
	S+5d/RTBbZ3iUgQDIpkUhNmxG8RC6XxuxsHRBEMH/+Pun9284/Lq001PeS0LxLG56/FDbrb5gMx
	XdcBE3JoHYKnRUNlpHaByuvAp3x1y/SVi0d+FSp9Ye0KQzesFE7tMQ2SMj9r72Bn6TVjfSUOAt7
	3fFhU=
X-Gm-Gg: AYBFou3lCDzfKHzTuGECQW8FHE7LGD8qPrPms7mb0+BdQUOj+qWnTpuRsvH/GOLHp4N
	F71H/uV/dxfqoiEgH/TTKZJHWTD9NrhUfHgmklV4khgM9zG/TnALtSZlxtFQNtGJB5RqWKoYrLq
	XTlyM1C2R+R+poQEsk95mbicLPu4NI8r1uldelBa6QLU979YJbZrCaskPX2GqwEZ//HGmU8Xdpk
	jhwW57basTJmWdKOohJ1tqEcPVC2yLkEB0NCh+w/9xM2bAzGQsYb/nsfJnKJBR+MzqZWjljuSvF
	IRCS2ENiyIAal1cvbuej+UxW4POHGXdA+C3RTZtT0QkGoGbG+Tmlq2M/TMS9nWWJPnfcbQpDKYU
	cajcPagY6RWjvC/0oYrq5T7JATGKrYL7nNCK8JEAo2n27ValFTgDR44/IpDzE10HrOXyYgy66s2
	dueVRoGQe4/Ox9xeARx1c=
X-Received: by 2002:a05:6808:1a1f:b0:4f8:4a95:991d with SMTP id 5614622812f47-5773a6f88c5mr9488718b6e.2.1795090185378;
        Thu, 19 Nov 2026 04:09:45 -0800 (PST)
X-Received: by 2002:a05:6808:1a1f:b0:4f8:4a95:991d with SMTP id 5614622812f47-5773a6f88c5mr9488651b6e.2.1795090184798;
        Thu, 19 Nov 2026 04:09:44 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm5135874fac.6.2026.11.19.04.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:09:44 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 04:09:33 -0800
Subject: [PATCH bluez] tools/test-runner: Fix TESTHOME parsing for short
 paths
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-fix_test_runner-v1-1-ddad300e86ed@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPzm/moC/yWM0QqCQBBFf0XmuQVHU7FfCRG1a03EFjO7EYn/3
 qaP53LPWcigAqNTtpDiLSZPn4APGU23wV/h5JKYiryombl1s3z6AAu9Ru+hrmqa8sjlkGNuKVk
 vRbpsxTONj4gvdftscbxjCv8aresPYQ9DUXoAAAA=
X-Change-ID: 20261119-fix_test_runner-5773413a0ef9
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: c3WenZQ5zJefGJu3MbWAgVieIEj3Ka6t
X-Authority-Analysis: v=2.4 cv=RdgFmFtv c=1 sm=1 tr=0 ts=6afee70a cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=k84UmWxO1rnOZ_snXCEA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0OCBTYWx0ZWRfX6mFqGZ5+mjJq
 15SoF2gRLiZLGPmosd89XBntHuj17evDyroNpgly4vWP176zuBZyD3QVzNb43xbmS8e2m7Dan5k
 sj8riOKjG1ESTCYjvFkQHK7Ap1wke+4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0OCBTYWx0ZWRfX2+pLTZFnMejC
 IbDbvrlzSNEtgUAg7a3X6xVxx46GusVCgJEx4MHADYYtOTtDRqsc3451qiESm/MdaCNoGsyxa5I
 2IeXCRB3hFidK+B/jQkjNkPC5JmKziT2YJpVfw2nxI4Mgg7TwpI9kt5jhr1zqV8osi47mR1h05W
 TwNX3XS82VJGj2tOeNK1XTSxCi+bwmwI6jzjGJpVdCttMKFUZyfsZD9nsKrYgyU77fQA4hdMVhD
 W3a/fpkeT6/UDjNh91CqXoUJZreR54lIRrrGVKA5SziXLKC9SvAPQPlBegXyFg9JCKgcW8ftCN6
 tJnes9yBL7h2Eq/ihiNYib6zpAJto+FaH49X0fq8QWX+htnHeJFFBozPDyNHHvQKKati5smR1LB
 Bg9XVd4tXBmMDKhIQcCv2bFl5Ep0p2vxDAZ8k8sIQy6XakSlVE8pQhFZPEnhLvslUYXx+xyuXW6
 9o2yXURW+0YdNlYw0GQ==
X-Proofpoint-GUID: c3WenZQ5zJefGJu3MbWAgVieIEj3Ka6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190048

TESTHOME is parsed wrongly if the HOME path is shorter than 4
characters, e.g. "TESTHOME=/ab TESTDBUS=1" gives "/ab TESTDBUS=1".

Fix by searching from @ptr + 9, the HOME path start, instead of
@home + 9.

Fixes: e622e623de13 ("build: Add test-runner utility for virtual machine execution")
Assisted-by: Claude:claude-opus-5-5
---
 tools/test-runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 0bca31a46351..6b8d0522fa7a 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -2167,17 +2167,17 @@ static void run_tests(void)
 			audio_server = strndup(start, end - start);
 			printf("Audio server %s requested\n", audio_server);
 		}
 	}
 
 	ptr = strstr(cmdline, "TESTHOME=");
 	if (ptr) {
 		home = ptr + 4;
-		ptr = strpbrk(home + 9, " \r\n");
+		ptr = strpbrk(ptr + 9, " \r\n");
 		if (ptr)
 			*ptr = '\0';
 	}
 
 	run_command(cmds, home);
 }
 
 static void usage(void)

---
base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
change-id: 20261119-fix_test_runner-5773413a0ef9

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

