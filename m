Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F27238157
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073905; cv=none; b=rrQUrLRHPfknH+ttX8zJVuiJanK4Fkx2we8pqdyb4WzEAnScnzBYFTcf4ZQHQZoaTCtumTkJUdlwO72Y/ub8nxDb1wh7bTAfRvcRzbm6M0UdBRYi43zTY/kb0p3sUR8uUkLAHAZgOz56tA/X6My28nXLy33WMe1HA2vF3vkI3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073905; c=relaxed/simple;
	bh=3G9rYAW+Q/3iQ7OK4sUwW4EfOy7aX7hNyDKz+OtH6QY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VzSzd1bVqeu5MZEQCI4lq0BnQ8M1UxxhRHg0D6PZqb1l6Y7cW4a6qB/OPMpC/mrDdgxUsa8EIVyq5OS9ZRUmKGA/TygWD3vdRX4I18Ww80/mfIaSFH4Rd/RjDK1ml+Z6A6OnPc2b87N3T+oTh4tmRjaCk34TwR4J0aunRqME9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbk87Wab; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbk87Wab"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a77ffcb795so223441cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752073902; x=1752678702; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TLcbv+RGRTVsIk1XmWIGQC8Wg2YFMssg7hkOHzjH+cM=;
        b=Hbk87Wab+pfAvhYZGbTuq2zL1LqNk+PGeHqjbLqwhtvFjufpV8kBtcXTvwsZQOtL6g
         H8/yHxeJ+B/krm/zZI2LTZ8L9rwuJyIHW5Hmk6p1gNgGkgwLYqaJgaikSxLJPseaQUvN
         EzG/vaWb7FF414aitktdM0B+KvHpPeaYjOji0N6cn6KRlfacNgITwS/GFsf1azN8KhNZ
         BBq0r55PtfX35t3Nq7wRXXi3eu6bDvOCTvWz6DT77vu4N3cwfhXe8xhhmP8fMq7Kx8wR
         FFDBXC4WsyLGbe57g6TGWIsHReJDTA5WrRt3sbh7nOjDqAtTMD1GSABn8pvh0oT4nL5H
         e/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073902; x=1752678702;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLcbv+RGRTVsIk1XmWIGQC8Wg2YFMssg7hkOHzjH+cM=;
        b=cpfQFDHeMQlRU8bUZvCD75lfFvsmLgG2csC5vIP5mQCq8VhY3Crg5kPT4TfyTrjDgG
         MfVpMc+2rSfF9trFmxXDHG97Mn2MCkH+NkftjUk62ZWo09Ym5Y2g+8ZteapEPB13FIco
         1QaeH6swfaNqdNYfJfzTVnwWHd+HZKTCJS5+sCccqLmmogHZn1eRmcncuzIdqLRsYJEZ
         z6sGO3QsUaJlAVGrMWbzaHrv5iG3WxyBPkLf5NdDMArd3R5rhwqHyC5sNprSEL3cCi29
         o9iPrk2YkwyEuy9P//QhaA8WvVnRu73FHaDSQ7+e30r+1+5UxE+ivdt22HEl+je0dXvR
         CMOw==
X-Gm-Message-State: AOJu0Yw1uSngGL0vxgX+UME1XWPoeimyWLbc1MJtKrJrv63Y8VrForN3
	F/u28kT0bSJ5jh/8J26G9d6a05W3VtNbOQWuVLA/nAogty70gggBrNTsXTopGA==
X-Gm-Gg: ASbGncvF4fCVBu/1axizBLLqdfV3cZd7mVw8kzXYFZDKhjQxYikeXF10iJAIUa/UaUX
	g0FxnX5Ir0cXKCT/cIttyClCVDULX+q438zJ/T3dQGKdmitm0AQ+2A/jHJZZIlrajkDUfiku1zR
	6226eqjmWdPbgpNW4Xt96vMHkH2h6zt5vREG7h+JiHKDjIYnjTbMW4LDMzBibrc5HCJ8h08n3md
	uPtJ2LEAscS3oZQyCyZY+ymx63/Rj4ISSTYZBM/gSJyx1wcjEpBt/Dk8vcE6lYvFRHSxPvKP2st
	LnHB3IlePAaERpJlARQOhCJb9NSXG1oLRoNMKKcdI3A+/7FT3Jb2QFHEZaDYyAtb1NrU
X-Google-Smtp-Source: AGHT+IHXdqbL/GJtzeW1nPsnsNUq1oX4Nkcyr/WtwakFmHORrx/2d0fysVpVvgwPDKPYKqQrL7Vukg==
X-Received: by 2002:a05:622a:1a99:b0:48d:df0e:ef38 with SMTP id d75a77b69052e-4a9ded1d107mr42417091cf.33.1752073901928;
        Wed, 09 Jul 2025 08:11:41 -0700 (PDT)
Received: from [172.17.0.2] ([40.88.125.133])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a0c24csm98890741cf.35.2025.07.09.08.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:11:41 -0700 (PDT)
Message-ID: <686e86ad.050a0220.6a558.5bba@mx.google.com>
Date: Wed, 09 Jul 2025 08:11:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7503709438329544067=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, i.iskakov@omp.ru
Subject: RE: Fix bugs found by static analysis
In-Reply-To: <20250709133622.2819849-2-i.iskakov@omp.ru>
References: <20250709133622.2819849-2-i.iskakov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7503709438329544067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980540

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      22.59 seconds
BluezMake                     PASS      2749.28 seconds
MakeCheck                     PASS      20.24 seconds
MakeDistcheck                 PASS      189.54 seconds
CheckValgrind                 PASS      241.91 seconds
CheckSmatch                   WARNING   315.40 seconds
bluezmakeextell               PASS      130.05 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      909.24 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7503709438329544067==--
