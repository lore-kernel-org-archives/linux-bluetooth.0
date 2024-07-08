Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD653C08A
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431583; cv=none; b=IY1jRjdlaAMaYgbvJKleDZloZDn1EwTr8Luhgtnu3b9IIwnhtKnzDBGdckTCaA3zA+0cJ/CHI6leSOtN+JzYuYM3Bef6txiJlIFzglaR5WkbCemKgAUstPCcOxLGFmhvdKKIrT5O+3ir7O6egjYJuxjQLE9QRtq/m4OCjqJGRiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431583; c=relaxed/simple;
	bh=Ms2t5BNcjWNPX/heR3W7hDqoYgMgMgSn0c4sEqEa7VE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NDeTQnknccP/WC5MBON/6dFTBKf6s3CMIz9WJIwUM8mfXS/bYiQgOtjDuXaA9304DQhBOPHryMBUALi0QvzulWF576P2bunpJkvxDAM6Fz81XMtWuWMirczQ0mgHvAAKpZBmGkf1+2rLaCqMW4tCie6UncXBkKk7WJAThNWFsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=piy1hm9b; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="piy1hm9b"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367975543a8so2410284f8f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720431579; x=1721036379; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWgLIM9qKcrPLrrUHtXvW+gvDxnJ8RJKAdy5dnMDqJU=;
        b=piy1hm9bRHACTg9jhzjZ0rBS4HRP/WjjTJBzITYvUEeK+hoN5VvoQH64Q9Yljrl9Me
         SOaCad62pyHLrq/qBtyu77F+C89Sx86zl9+pSZ/mxg+DcPL9qF8QtH5QCCcxTJi618VM
         IBxmegotSgW+tZPK7YHIIOfpRaoXFUhzSJJ2D7mI1cdbPPRRC7Ju1muc96E3cCXWh+fy
         6xj+lf76hNgqhIyJKpr176zLWzmEvz8U/oncbUcj3KiYfbrlbKPrE4aRvMmq5LIEaxy9
         9CC0/G8Bpykg/R5aDYd9gGTJkXQjAVgSoKf2rbu5F3yNQ84Xc/vRpMyKEeQ7yTupAksJ
         YRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720431579; x=1721036379;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWgLIM9qKcrPLrrUHtXvW+gvDxnJ8RJKAdy5dnMDqJU=;
        b=vZRkqnT7MsrBY9Ci6h4fwXHCu/ffJbXP3FHm70OPSfki7PfetnT7XiAJ2oIC/+pDds
         5bTG/GaeBXcsAyS+BGiFYgdQZNJsvdc5yqm0i68ULweAlc+eU7lwPZsgTsfj40fVi20Q
         96kSUpbmh1mPj5ZyI1H2STYoaKe8mrLxWe/NZGvkCxNrgdRf9nkrNDsg2Sg82Bn7f2ae
         R6UupdPmK+YKrsI6J3iUGrLwOYsm0uE1fQw/tndCMHibUWImKXh5Aq/bo4ENP3xtKFq3
         nmJL6/FmAez26JZkAN8wsklgBL/wOXu0RbspXv5xWnTdCLUBTHVaTQtCuVYJXVAlENJJ
         eWvA==
X-Gm-Message-State: AOJu0YxSSjRXg9uIFrFn5K0kBmpJkEs2YVbK3lZWCwN2jvyqno5MU7io
	ZyTGx1WVJC+8WKceJuR3mSeEufN3xDaVHLdJDKhOBWoFMn4L+t/yGCMfCPK3gYh2tvLRz1J3KlK
	t
X-Google-Smtp-Source: AGHT+IFXK4/ep40hT5+M0sRQUwSOZqqauY35f7kO+cSaI3vg/+HQxp281vElMypynTWPaVFuPH2MaA==
X-Received: by 2002:adf:e94a:0:b0:367:88c2:23a5 with SMTP id ffacd0b85a97d-3679dd2b344mr6641004f8f.27.1720431579437;
        Mon, 08 Jul 2024 02:39:39 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:a2a3:9ebc:2cb5:a86a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789fd7a0esm15457779f8f.104.2024.07.08.02.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:39:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/6] Bluetooth: hci_qca: use the power sequencer for
 wcn7850
Date: Mon, 08 Jul 2024 11:39:23 +0200
Message-Id: <20240708-hci_qca_refactor-v2-0-b6e83b3d1ca5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMuzi2YC/2WNQQrCMBBFr1JmbSRJI6GuvIeUEuO0GZBEJxKUk
 rsbC65cvj//v1khIxNmOHYrMBbKlGIDvevABxcXFHRtDFpqI600IniaHt5NjLPzz8RCWitxGHo
 1Xwy02b1d6LUpz2PjQLnV3tuHor7pT3b4lxUlpEBtjFZaedXj6UbRcdonXmCstX4AZZbTVbEAA
 AA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Ms2t5BNcjWNPX/heR3W7hDqoYgMgMgSn0c4sEqEa7VE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmi7PVX7BJqyH+oZvhWBQCHEcv+QA3f83Wxu1/M
 cVU4wDa8AeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZouz1QAKCRARpy6gFHHX
 cvipEADFsF4UeWoJ20FiBCL5sQFzEftsRznE64rF5F+XIbrj4K+i2trXBA3LTWKXyT3oxLnrYhr
 kG0898JoBP+h+BPnFNpp0Pxa2B6PbPiDzRYIDmKeP2ZIxNvj+BurRQFOsk8KVaWHa/wNtMZnyFU
 TDVvahX9GwbND7kENQOpXXUvQmQn8CGl7qbjTUwd6J5orHVo5W4UewL9+PNEOInn2h6L0vZj1Xz
 htI2rtGAf0kBeIjr1ZsNgLX9fKI48l4XSzbTUInuyrOidcsklml7tjU5Ft4mbxEK23MoLoAsByh
 oXN1zC7rqEqdl4imkIZWx15LHUBh5SaJhOmonPNN4/irZDBSqB5eZo5BhEZGejBW23096UHAhaO
 vQ1NM5w0rcF4r8HPZt5PZs4oC0k+EMsjat3raM6SXoYZKL7HYsdqhWkvoYBSqHnV2hO7hQ/+rLY
 wwFE3RHzQTqB8nc53KL9V8Clz6QeJD1wVE/EdPycNSBa5EO8t45KHndXrc6lfEsRNmBkUIDeULC
 ezHFqnzt/oxfZvYabRDu2hCBEoTQ11pgw0LttF0kxP5hIJYjCuG5cSJfga3W/NKLWIEixT48HB9
 c/wBgixF+uafD7O8rG95O8xavPlr6jDsfChEFy1p+I6f/Kh93ezIY4xojnkbPUibe4KwTRmqSfW
 RfMSN87Vb+0oWow==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

The following series extend the usage of the power sequencing subsystem
in the hci_qca driver.

The end goal is to convert the entire driver to be exclusively pwrseq-based
and simplify it in the process. However due to a large number of users we
need to be careful and consider every case separately.

Right now the only model that fully uses the power sequencer is QCA6390 on
the RB5 board. The next steps are enabling pwrseq for Bluetooth on sm8650
and the X13s laptop. To that end we need to make wcn7850 and wcn6855 aware
of the power sequencing but also keep backward compatibility with older
device trees.

This series contains changes to mainline DT bindings for wcn7850, some
refactoring of the hci_qca driver, making pwrseq the default for the two
models mentioned above and finally modifies the device-tree for sm8650-qrd
to correctly represent the way the Bluetooth module is powered.

I made the last patch part of this series as it has a run-time dependency
on previous changes in it and bluetooth support on the board will break
without them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- Fix a switch issue reported by the test bot
- Link to v1: https://lore.kernel.org/r/20240705-hci_qca_refactor-v1-0-e2442121c13e@linaro.org

---
Bartosz Golaszewski (6):
      dt-bindings: bluetooth: qualcomm: describe the inputs from PMU for wcn7850
      Bluetooth: hci_qca: schedule a devm action for disabling the clock
      Bluetooth: hci_qca: unduplicate calls to hci_uart_register_device()
      Bluetooth: hci_qca: make pwrseq calls the default if available
      Bluetooth: hci_qca: use the power sequencer for wcn7850 and wcn6855
      arm64: dts: qcom: sm8650-qrd: use the PMU to power up bluetooth

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 18 +++--
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts            | 28 +++----
 drivers/bluetooth/hci_qca.c                        | 86 ++++++++++++----------
 3 files changed, 71 insertions(+), 61 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240704-hci_qca_refactor-0770e9931fb4

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

