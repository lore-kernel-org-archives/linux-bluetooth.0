Return-Path: <SRS0=BvBO=6Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20CCC54E4B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 May 2020 15:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A21ED20820
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 May 2020 15:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBCj+aI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgEJPAW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 May 2020 11:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgEJPAU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 May 2020 11:00:20 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9DDC061A0C
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 May 2020 08:00:19 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a4so5272255lfh.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 May 2020 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xAfxlG2hQFkVcFoSQO0kusuFNUpeoGfNWIjltqTUaaU=;
        b=cBCj+aI5jU2oOMkCEZob+ZtBENRHE2T4YhMWsinA91Zt+TFAMCIYx1FRA2UQxd3egy
         OLCC/bwQyhQt8Ie9k8BXtROkcn+Y3wE5tducrcvTBx2gS0JpCIFj9XtBztJgnQ/b6IIz
         NR+YMUgqjTAvVe+lCdtZXO5ABLjUoO14WztDgw93L1/ko+Yi8weqPa9nV9IMrwX7A2eh
         YrS+8qrQfYO/tKOPeKcHW88up2fdb1XaR1g9CHFwxNQkgpXLesU0mcG4fE7nS+abwXWl
         RMMTqw7sfUWul3y9QnL7n6wI5q0g5mqekAQtbEbUD+SMa1vObG6T8K1zIGqyNebrLMbg
         DqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xAfxlG2hQFkVcFoSQO0kusuFNUpeoGfNWIjltqTUaaU=;
        b=sZFDvd1zI7K05FUVZGNVItaaMts4mhJDsp33KU+lWMoDtNvS50EKV8ytVdVsJwAHwa
         Q24Cu6jdTBBbaoeebCy0wVZSw2qIVb86nWdJ4RT2ENgFwz8Kkh9jj2mnf7RXPybYtEWt
         JhEsoGj8+n66RpX7q2V6VAAG8uet+GAoQPHCXpFsTm50fgrPnvphn0vFdwG5tG+9hIMj
         rFzS++L8Jk7nEwRYBSFdRpgDlnGAar7sorpI6xnXBvlzuUikKk9xX1UIsNuOxgnLrXYH
         49YDCXwtiWJPHvsdJvISrZz+jAnwBovAprAsiUdYGF4ya1RVOmNBIL2Q82+T/EJnteTh
         T38A==
X-Gm-Message-State: AOAM530DwXRJ6+HaDjnnLrIWndtm73zUqkKxfetICFAROztA83kl6Ovi
        V4JhjEAOzOUN88KGFwjYo0A=
X-Google-Smtp-Source: ABdhPJyq8pwkMnTj0uPLgLwe59ru8J/EeOm9nTmz1LQwXOrk0pvWwHemcrmyBA+5b/yFqo0385Knsg==
X-Received: by 2002:ac2:5e9c:: with SMTP id b28mr4571055lfq.50.1589122817462;
        Sun, 10 May 2020 08:00:17 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id o23sm7434295ljh.63.2020.05.10.08.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:00:16 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
List-Id: <linux-firmware.lore.kernel.org>
To:     linux-firmware@kernel.org, linux-bluetooth@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] QCA: Add Bluetooth firmware for QCA9377
Date:   Sun, 10 May 2020 15:00:11 +0000
Message-Id: <20200510150011.31952-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit will add required Bluetooth firmware files for QCA9377. Files
are from the Boundary Devices repo [1] and are covered under the existing
QCA redistributable license, but need renaming to align with the upstream
driver firmware naming convention.

tfbtfw11.tlv > rampatch_00230302.bin
tfbtnv11.bin > nvm_00230302.bin

Support for QCA9377 Bluetooth is now merged in bluetooth-next [2].

[1] https://github.com/boundarydevices/qca-firmware/tree/bd-sdmac-ath10k
[2] https://patchwork.kernel.org/cover/11504823/

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 WHENCE                    |   2 ++
 qca/nvm_00230302.bin      | Bin 0 -> 1996 bytes
 qca/rampatch_00230302.bin | Bin 0 -> 33064 bytes
 3 files changed, 2 insertions(+)
 create mode 100644 qca/nvm_00230302.bin
 create mode 100644 qca/rampatch_00230302.bin

diff --git a/WHENCE b/WHENCE
index 010d1f8..65845d8 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3843,12 +3843,14 @@ File: qca/nvm_usb_00000300.bin
 File: qca/nvm_usb_00000302.bin
 File: qca/nvm_00130300.bin
 File: qca/nvm_00130302.bin
+File: qca/nvm_00230302.bin
 File: qca/rampatch_usb_00000200.bin
 File: qca/rampatch_usb_00000201.bin
 File: qca/rampatch_usb_00000300.bin
 File: qca/rampatch_usb_00000302.bin
 File: qca/rampatch_00130300.bin
 File: qca/rampatch_00130302.bin
+File: qca/rampatch_00230302.bin
 File: qca/nvm_00440302.bin
 File: qca/rampatch_00440302.bin
 File: qca/nvm_00440302_eu.bin
diff --git a/qca/nvm_00230302.bin b/qca/nvm_00230302.bin
new file mode 100644
index 0000000000000000000000000000000000000000..944c9a5ddfd81fba3d36041fe0cc070b6e2cf0eb
GIT binary patch
literal 1996
zcmaJ?eQXp(6#u>1-P>ik-tB#G^vf1XTdx#b(!+8+C?4$|t)O_uw(_C2Dimr^`A|y4
zLJ@`fhvG*dwk8HOka!SH6p3PDh<pk}!I(fyBq-`1hQw%!5s0mCZ@KMxCjQ>OnKy6d
z&Agd;^H!Wx;ev(?Mn`sxT)1QD4quk;Ir3<-H;f`sW*Dd#L8k!&m_~%)Fc4v8#3w;G
z{lYf|Go4m^Zd0?FnAfssvBwh%g-R+r>o<)_n%^j{iQe6`Xtg7)EGi`B`*OIQDMm?S
z0GdjuK*-Spf=H4iSPU663Ix}c$a6-xXyv%oK&horZsj2v1bDhI{Fx@|6gBThUvuEF
zJ8oR^za%$mRXE`EPGjj$-r#z8P$f$6Fm&`GiC6hBUxS3blthZku#ddh&!_f0ulNy3
zI6y&sOe&619*&cNQ&f%9)QL0Hid8)4S$Yhuh+qx-zd+RDPCSnJ*n@7&f)E6S3ef@+
z3E{<7G~flq&?3g6gE=B()bI{2k%qMxk7_X$0dWQsMKRkqVk%}k{&!st;lvT(@DD%X
z?R-{KDK$|K?W7YlLXBdpI47zk=mz_J2R7qxT%+Hmiz+Zg(@^Ei^Q4{@!=n(otOUsw
z-u;NQjL23aIf}GeNHtmEunM(&L>ZWPpgt?Gt~bCsTpJR*oE2u!b#V`AWJn4}8xegd
zxiCqRNOu{Z%tj((hW_iK&f>%GqTpQdHGH=72DaRY;c7=M`V^qs1->}o%fjDqWzR6a
zd3q^gk1oJT_B+C^jk9KoW1%x4WKDN_48tD`l}sut57*Sqh{k5miJS9U=ijw3xumQ6
ziPdYLTEF3$Ux0_ktTK`en#+zxaaKL64g}`%?PNf*kY!Dl1w@OzZn{U7-LeTqGZtnY
zoT|3r+l(PZAUL^fN_jMjnl!4@xGjxv8ntQU=TFQJp{S^+xVWgm$Mr1}f_|<igt#_>
z!Qg~|&+y8!EJ=#$Q4~eey}p2==y@Km&+j$7-0}y2IU6^wTa!#C5%21nu5kd~%m!L0
zWW7bq>};)yHkE}rm}CjtIF>%3Q}i<l5fZnH4zWe-5vRo;qC&cN?Dn1A*g`x0ax|l(
zvtZWkpo8=)O&0fw*TrQ~%a-p*U&+^%N>!(JG3+J`vmc%PE=(=Cn6`Dh-MksuF8S41
z@5ZVucS}oyhG9r{3Gctab}p9-cA0Be=&=%xUH;e3GQ4SSt;b8*C9jt@vCAAgxPnT{
z*S-6nwdrU-`&S~%=z#SgZAcZms?}}U_VTW`_P&4cb4OT`m7deNjE67H%1`_}tSl%)
zQX%P(+;F*}doVr^9xuLF@qcu*Czp=&SY&IjernON9*b-_TYsW2myY+1(S^;qbbhl%
zw)R2nzPW3_%tBkjY_mCGnh9<s+S+rmyuE$-@(x?eb$2d$v#_GKm%r^B9NymBJ23FZ
zi#88f*f2Qw-jL0M76yh=hu%!34(&@ZhEl1)&g@q{o|8F87~eTyMAk(jDmQ4#dFcv$
z$EhX~7~$VcJtlK6|6-t1aG8#^R9$V(Z%HH)&E}%}+uN2bu84=j4UG-4SS;FLn$1m#
gM0tHd>noXOW}VHhoFCLNqcYI%?lQIqrhDM|2Y9G{!2kdN

literal 0
HcmV?d00001

diff --git a/qca/rampatch_00230302.bin b/qca/rampatch_00230302.bin
new file mode 100644
index 0000000000000000000000000000000000000000..8698a49c547a0ff8434529cd9defdd75ae39b79f
GIT binary patch
literal 33064
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
ao{jMP>l*+6Id*f`nWcMXnSXR%EdD>PDWLKI

literal 0
HcmV?d00001

-- 
2.17.1

