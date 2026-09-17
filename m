Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060C547071
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672530; cv=none; b=G6d93NpErx4UbfuBEmF5Qlu6ARcNywx0jylfPaFUg9q7a9vFq4H6fbepq+p9h9j1dNWFIx08H8r8cBj9yMRf4CvgyUqwlGDahZZun+mR/vSVwFEAGOn5a44HoUWLsYzjo069hH8xIvuSFu6tsPBfARQHZQwNtKrZHMPd6fsmDTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672530; c=relaxed/simple;
	bh=fL1GDGx3X7x5Trtcr+2EX/jNZNMf26os0Anbfrv6uho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pUD/YPtZhQN3/la0twc9Xoal1n8uZtZI//U9JBVX2e3LsFBAFTBZpJ+psVpbzykU2I067LnMI3+mF47nwKnn2xHISEdOICqpGXyz8YtQLtXBSEMLY3OLSIsfUU1WGqve6QqbFZlhKnkGLbJSf3NXU8sSU7VdLJK2DhHb4SBzxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkGlrzoL; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkGlrzoL"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso11613185e9.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789672527; x=1790277327; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/d/LmBGvaODHfiD5RdLbuLiSYeef2ZM7iX4Xi6Snlz0=;
        b=TkGlrzoL1u3mvIq71yPJ2p+f8E7LIGhg2x6QPunvS5J3z03TRKQTo+6mZiNMvdXFyL
         7t6gdckn7hH+Zg5fDPdRruIvQNNd7BihHeEEQU+UZylGYtQyCoHYmeRVd2rCpRxgAPdC
         7V8RUqX7kIexfL9ka8lc0RXlperBrvgJ/r5q8A/FcZUO5Xs8NEKa03Es+XruKz008xSX
         YTywdVOdTI56XI5aaAiow1rJgeFqHUIWG1PyF4WOA0zqMVASFxx8cs6Wj7booLPQhJh3
         5iftHCU7c2mTJr+AqSdoeqZZknkpmw5YzSC5nmH9D+6J662O86RB77N0ksCnRwaDPKre
         dIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789672527; x=1790277327;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/d/LmBGvaODHfiD5RdLbuLiSYeef2ZM7iX4Xi6Snlz0=;
        b=w8puDi9dJIiWvbN71CI1sjXwhF7yA1DnBu954Kb7AHS8MZoK/QCeDG8bDBDePAJ4G2
         06JACtCz9GKWNANrdQXIY+xd7Nds3akTGbQyBkz5ul8K7++I86VmRMuR5amt4adERIwb
         XDl3BHCSWno3fhxguKFW5er1W4FGvlmmmH3dx0LlmQmU1WRrVFbpEPA3assUXK4U5P99
         4/Rokv1tqzGINc3xS/vE2x9rfj520iIiXBwmG0nwj8VmISQ//w7BPSBaqo4SPL91Sm2x
         etlcFdo0efGCy3SycWwIcLQQSWqpVDQy4g8fCqwsRwGW1L1XoIJ8YVfv9R7dbKepwhly
         A+zA==
X-Gm-Message-State: AFuF++lRSudQwRe3722QkqslXz+aWYkivIbgE8xYXgjpNmelvlr+Od0A
	4WRQpEAlrYzjrDzNGdbp6b8q7EsrRo+jumlSV4cYSAD1IPlA3fvLqQtL0H1q6rolBvUUGA==
X-Gm-Gg: AYBFou1CLmHK9F5rwX2+1gPympr8Z2/3uaD4KoRj9wKT5AeeD/qubQ0kXQrIHFz1XuT
	k1+QZRAMrfHyHGAPHRLg+DSHIN+UdMVx11z1oVzAi64esHc+hVYmR/XoYv5VZ3K80Pnd18BQgwp
	s0VqOXV31pzriFg80+opb5LJFvtovqLlMYWiuGGlOMKtyRL5WCm3SnER9fQi+2TGrRG97iH/4GZ
	qAFx/FzZt48K9u9YJIYkoqUpICwrmpJNClqaJMackAMeVJM3f1hUJ0oIXH0sHcSyRcLSRvEXk4f
	f4cxBi4cAhZJ5VKFVE6/RMPlOpmdY4OhhD4o0qclBr19ZPpiCZGVFOO28aG13EOBMQUBg2vyklb
	dhtNJr+uTC+6lgITrowL8GFCMobgc6j/0GfF+y3XzgFrSSoFRoFC+q+RZYkQ6OhRBbrPEV0blkn
	sija1dYgjEQxnQ/HAc4Z33iPQkLYiOTKsvWcl2mZaF9y7al9WBOZD/GunSV8C59JBTXL8=
X-Received: by 2002:a05:600c:8b61:b0:49e:6891:27a8 with SMTP id 5b1f17b1804b1-49eb732e411mr88524385e9.25.1789672526509;
        Thu, 17 Sep 2026 12:15:26 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc47cfce6sm7326965e9.0.2026.09.17.12.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 12:15:25 -0700 (PDT)
Date: Thu, 17 Sep 2026 22:15:22 +0300
From: Dan Carpenter <error27@gmail.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: btusb: Add support for Qualcomm
 multi-subsystem QCC2072
Message-ID: <aqw8ShHyjdZhPc4U@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Zijun Hu,

Commit 2e63b55654e0 ("Bluetooth: btusb: Add support for Qualcomm
multi-subsystem QCC2072") from Sep 13, 2026 (linux-next), leads to
the following Smatch static checker warning:

	drivers/bluetooth/btusb_qcom.c:2516 btqcom_set_bdaddr()
	warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'

drivers/bluetooth/btusb_qcom.c
    2507   *
    2508   * Return: 0 on success, or a negative errno on failure.
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    2509   */
    2510 static int btqcom_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
    2511 {
    2512         int ret;
    2513 
    2514         ret = __hci_reset_sync(hdev);
    2515         if (ret) {
--> 2516                 bt_dev_err(hdev, "HCI reset before setting BD_ADDR failed: %pe",
    2517                            ERR_PTR(ret));
    2518                 return ret;

ret comes from skb->data in __hci_cmd_sync_status_sk() so it's a u8 and
not necessarily a negative error code.

    2519         }
    2520 
    2521         ret = qbt_write_bda(hdev, bdaddr);
    2522 
    2523         return ret;
    2524 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
