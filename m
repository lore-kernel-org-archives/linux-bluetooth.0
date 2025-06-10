Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA30424337B
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749578570; cv=none; b=q+LFcU2j+ZvkcGVNiAr6fgP68XMqZJbjh2Odf+6jt/KFZq36vppu+VzFRhUn/Ckv4gX54bwSmohFYEXICe1Uo0Qc1I8pwpym1TnupbrRhiyC/eIf4LNdLapoFVWzB8Fkieadn7u77fnYs7kY4RJbdTj2TTjqJ0pehDnpPOPpLxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749578570; c=relaxed/simple;
	bh=ZGB5/ZHBPZVq6+s40kz3AjcV02ecxTnMz4YXCqbE/+0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZVm8/+ECQjSBtFGXAzI1joYx0COV9n8PhOBAPmhf3whxljJ0l/M8wLTI+RgJPCjsdiAGQaSLtN4c/p0dK3k0x2f1YOwE2pBt9qcCInDtMa/YsctN9bsXRuy0FPqMJQ8q6FpWsp3Fv6SQH9M1nA5Z23EZ1WR2ObNDpOYEVyOoujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt8oCJw2; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt8oCJw2"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e5995828d1so3598706137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749578567; x=1750183367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xK55lX6wQjpY0G/7TIjKaopwioQXptL7w2UYKYrrTHs=;
        b=Rt8oCJw2m+o4ggINbOAysITho5zUQsz0IJ0bVzWhUWYSxDfthyfjfXZUDQoSUc3Tq8
         eQBxxMgn8ip0M0t1ZtNM5bt5f+exYxp6xg5I4ENFylpaf6TDQmGKbXIqjlum4twKuoND
         Ey+gqmw7u/gUHS1uYfKMRZaiq2rBdNWyDIBWEAwfgawlSET9oAEbQ1dToDAMV6/oEtwY
         bY0+WRfmpjdYK7a9cSdg+n4LGZm/h2IYJYs8O4Zwv9ftIB1cUY9CBn+vqZv/yvrYKG2o
         7AnnUWdG+0ldyMQ0qJDnl+xrxol1aIfcxmfi8znWUfgxk8MHVTJui9N7YbQXcRLMh3CH
         reWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749578567; x=1750183367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xK55lX6wQjpY0G/7TIjKaopwioQXptL7w2UYKYrrTHs=;
        b=TQG/Fh0Io2GPWxsPCvHchs47k5ZYP9ZLCD/nwV0UdzbotKxH9Juh5K4ZETiArT6RJU
         VUskLvWLiJBRvOyus6pGIowkgWWYMvSRobk8tgvR8MjMcPBcAmQnwE1Frb+VJ8Vs/ZbG
         YT2pdFsWP1Zs6aMQ+XIvmdNzwfbFfo2ZE7LGdBZOeqSByyQpgY562F3sHIN+yW0eS9gW
         5YI3uvElub46ObIeGxDo7NneBorl+ZiWz+OrVTMliadA2CyFnoCsVSvdgKraZwWujelL
         ZrJbpnm0IsphJ+GIpNjhC+TZM6OSHwzJJc5ot9LKao+BioDP+27NNKe5YtfpLLBJHGKw
         am6Q==
X-Gm-Message-State: AOJu0YzVwG8EuRgkNeOBSETvDnaVEDQX1ni714FetH5//yAPDEu0aqnU
	fR3LjPEcQlLvPoLjyHUb7UOMHbnW9HAhiKjp0hDhwpC45HS3oodH7XeIEGKpyw==
X-Gm-Gg: ASbGncuyIWqS5mibF2PJLPtRDCHWb7SB0ihz55/HdmUn4nFQqaOETBSZRrTx4eoUrXZ
	ONx7oUBZepPjVPCC5gTgN4a9HnPIzlWOontlEoGiLdLDYkbmYjCjAJM1mJEL3o1od8zMmaFzfFV
	0z04hIn/5aUVccdTbb4PmQtd4MrPuXXRsxKX89P1T7/x4ReV9Uc4Jj529T8hKszcZVryN9rFwPO
	KzsPWNwj+g8zYUwm5qnGWJGZ61bMoAOX78KQvxcoJfN2yV5oGmRyn0bIr6Y71HukM2+b6Ru3Qkg
	Mk4RKEK/XDqqy3/MUA+2jQ5o8htJEega/pJKe1uMay9O0GbhiAcvZ2xYKZFNbnyac1PXMb1DLAj
	9uY3fNlv1sP8RqEl/r34+zHzeWqB12FA=
X-Google-Smtp-Source: AGHT+IENbB/BakoiClURV17vECApAIrc7ViqzuBvOp439CkOP8/zs9LTzf307gzPNXQlMbpx2vtxPA==
X-Received: by 2002:a05:6102:3fa0:b0:4c5:4591:ffda with SMTP id ada2fe7eead31-4e7baf62356mr211075137.21.1749578566403;
        Tue, 10 Jun 2025 11:02:46 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e7bb058b08sm44771137.21.2025.06.10.11.02.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 11:02:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] btdev: Fix not setting sid on BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED
Date: Tue, 10 Jun 2025 14:02:43 -0400
Message-ID: <20250610180244.1133512-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The event BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED shall set the SID accourding
to the value set in the periodic advertisement it is synchronized since
the kernel will use that to complete the connection and notify the
socket.
---
 emulator/btdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 2c62dc711d98..555f55e52772 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5479,6 +5479,7 @@ static void le_pa_sync_estabilished(struct btdev *dev, struct btdev *remote,
 	per_adv->sync_handle = sync_handle;
 
 	ev.handle = cpu_to_le16(per_adv->sync_handle);
+	ev.sid = per_adv->sid;
 	ev.addr_type = per_adv->addr_type;
 	memcpy(ev.addr, per_adv->addr, sizeof(ev.addr));
 	ev.phy = 0x01;
-- 
2.49.0

