Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8164EB64D0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 16:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbjFMQAo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjFMQAn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 12:00:43 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE2AE79
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 09:00:42 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-55afa2472d9so3754379eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686672041; x=1689264041;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I1bVceBs1R1/N436HyXFJGAS9s58gFgbh2mncZ6Blo0=;
        b=cnUYFnH1cKgTjG/u8nq/J2Z6vqZH7w1Jvf0GRqmSAPnOD7P7wcy7IKlirGqedGbfjQ
         7suZNkEgJEMjL2WUQSMg3+22NZNF1cZY96ODaUjoHze/oUL2rUufnz4hcBSCqc/PwN6y
         is2+SNFquueR2a1YuGqDabIF/ykMnNtbMHXPnszMhRQ3IKG9WSg4MKzTOYeYWrPRxQoO
         8W0c6yfDzNtLM8ZTuiolm7Rm3lzV+lR3eyLZTsxDEi1c8G3yJyhEic0deHRfLJMb/SBd
         Ik4Y+mMeJU/DiTBdtKNUDEYnZKn8iouwHsPiHJaG8ASBvv3M0UmKx48Uol2iZot3ayBZ
         X/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686672041; x=1689264041;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1bVceBs1R1/N436HyXFJGAS9s58gFgbh2mncZ6Blo0=;
        b=aUi6JWEsygLVg/2XWfHi01Pcuk9te1DwbjUWclDsxkqUW0XBQf77Sl0QCOuyoej11i
         1AJAeSRJQ0yV1ccJQMcpBL2xe1d8z9Ua1ueyl2jlujYFRre9t1aXuAXlT2nFZKr2iv34
         PTLxZ0QNBnumjM+UhKmVM6p+gbU0JUp8hIIvYumlnU9ag4JuY6yA0Uq+mtR6vBYyeCKG
         BCIGB3owhvPiUJeFqprx4osQBMGT2QeRCCykoMMq7DqSjH9IHY1hxs2vlxtgsj12PUUJ
         e5keCrha96Q9b/mvrNQswbKxbkuGmgK4Era86Fk/rmCa6ykwRpk5BBHOHTCa/SMsOGvD
         8v+A==
X-Gm-Message-State: AC+VfDyhK3+HkhFLFLxjqEtDKxZFbzBl4FDNthPt804G8lpCh2VQAOG9
        4FvIG9zLwZM2Q7HlsEWWxjS/UnBK7tzsAQ==
X-Google-Smtp-Source: ACHHUZ4GAr7icKljRkFc4PN4gB4A1TJN1awuSccRbUFQIbr4VHgRYe50wqQrWIMwNpXwWUOCQlNivQ==
X-Received: by 2002:a4a:d6d5:0:b0:54f:4e01:7fc9 with SMTP id j21-20020a4ad6d5000000b0054f4e017fc9mr7302489oot.3.1686672041492;
        Tue, 13 Jun 2023 09:00:41 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.173.33])
        by smtp.gmail.com with ESMTPSA id z7-20020a05683020c700b006acfdbdf37csm4940723otq.31.2023.06.13.09.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 09:00:40 -0700 (PDT)
Message-ID: <648892a8.050a0220.58b00.797f@mx.google.com>
Date:   Tue, 13 Jun 2023 09:00:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6518160352373150171=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: shared/bass: Implement CP opcode handlers
In-Reply-To: <20230613141625.9197-2-iulia.tanasescu@nxp.com>
References: <20230613141625.9197-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6518160352373150171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=756771

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
GitLint                       PASS      0.63 seconds
BuildEll                      PASS      32.29 seconds
BluezMake                     PASS      1020.71 seconds
MakeCheck                     PASS      12.55 seconds
MakeDistcheck                 PASS      186.31 seconds
CheckValgrind                 PASS      302.76 seconds
CheckSmatch                   WARNING   405.95 seconds
bluezmakeextell               PASS      123.21 seconds
IncrementalBuild              PASS      1656.48 seconds
ScanBuild                     PASS      1261.57 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:276:25: warning: Variable length array is used.src/shared/gatt-server.c:619:25: warning: Variable length array is used.src/shared/gatt-server.c:718:25: warning: Variable length array is used.src/shared/gatt-server.c:276:25: warning: Variable length array is used.src/shared/gatt-server.c:619:25: warning: Variable length array is used.src/shared/gatt-server.c:718:25: warning: Variable length array is used.src/shared/gatt-server.c:276:25: warning: Variable length array is used.src/shared/gatt-server.c:619:25: warning: Variable length array is used.src/shared/gatt-server.c:718:25: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============6518160352373150171==--
