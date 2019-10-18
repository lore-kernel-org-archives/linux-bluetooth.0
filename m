Return-Path: <SRS0=NsPc=YL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71308CA9ECF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Oct 2019 05:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42696222BD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Oct 2019 05:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9MS2j9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391663AbfJRFYJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:24:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35517 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388268AbfJRFYJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Oct 2019 01:24:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id c3so2284147plo.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2019 22:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3o3EqRq3PgsgiQtn4AY+sfKyKLaEqB9pO5QeXjYW1YY=;
        b=x9MS2j9SeTU1yjy/80Wvue6xeCHSErdf9EALM3Tjzc+ohSUTFrZ70EJyB/p3y8uCmp
         E6oisSzZ64R/uT5q9VScB/CUyOZ7ZGyvBjpyp+JPl3pGOKo/IXykFV388A0MvXI77cst
         pX5J3+EwmNbRsR9dCClbr9xz+PMxp6zkgcXjXyQuncbUYaCKC4ppDkibNqRVoiKxoeeH
         +oLDcz/9+Kcji/s4z+0T7kT4MnasCEasJtZh74m8B8wBqkjOwDpK8JzeJNlW3UOJuHVG
         pt2vWbvQc3jWMwz2Ms+vvdBzlZUx/NjpKlQsWPs7KiSDmoqv7lUg/7KxWmUlBYxRTjrF
         KBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3o3EqRq3PgsgiQtn4AY+sfKyKLaEqB9pO5QeXjYW1YY=;
        b=PsQH+2oxkLrh7qqg2AOBJpVcN7JRQTCUAtPiVDKSLW58qKbbum820Sp+qhp1hiFKY6
         ZlJ0eOUuNUQS0FxjMSLgpbm08A00Tjxri4O3cckQD4I/HTtGZv/u6Ai0Q3LSe4Di3FCM
         nu/LmecNPyESK0H66BKeZH2iqrjH+vfpyWB0eC34VumLB61ciDu0at/c8ABg++FjXlM5
         BMobd7sUlzHDZOsJXTXwMcytHr/52NtP17ZBD29mb9qmg++H6d0YE/VgvC+happffrmP
         IPQjfdH2A+GHbDCS5woA/zcb9gV/PueS/EI1PoOa68oIzqMjs65jJA8b+AjEMR7XA2bm
         Rj+g==
X-Gm-Message-State: APjAAAUW1BJhgdDP09xIsoqGt+d80Wxcbg677wXMaYrezR41LVH403g4
        6OVtKPj/YzO3PN0GMHuYb3pZwg==
X-Google-Smtp-Source: APXvYqw19R+uAq8rWGJFrvZRkNKzLLbqBo0up+3BCPqhRIt/ceR4k2HbajPgDlT/k7e+4ftCKy6O+A==
X-Received: by 2002:a17:902:b70b:: with SMTP id d11mr7650535pls.339.1571376248651;
        Thu, 17 Oct 2019 22:24:08 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u11sm2178760pgc.61.2019.10.17.22.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 22:24:08 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: hci_qca: Regulator usage cleanup
Date:   Thu, 17 Oct 2019 22:24:00 -0700
Message-Id: <20191018052405.3693555-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Clean up the regulator usage in hci_qca and in particular don't
regulator_set_voltage() for fixed voltages. It cleans up the driver, but more
important it makes bluetooth work on my Lenovo Yoga C630, where the regulator
for vddch0 is defined with a voltage range that doesn't overlap the values in
the driver.

Bjorn Andersson (4):
  Bluetooth: hci_qca: Update regulator_set_load() usage
  Bluetooth: hci_qca: Don't vote for specific voltage
  Bluetooth: hci_qca: Use regulator bulk enable/disable
  Bluetooth: hci_qca: Split qca_power_setup()

 drivers/bluetooth/hci_qca.c | 135 +++++++++++++++---------------------
 1 file changed, 55 insertions(+), 80 deletions(-)

-- 
2.23.0

