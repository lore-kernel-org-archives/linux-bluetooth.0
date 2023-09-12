Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFA6CA0EC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 02:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbjILChT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239090AbjILChG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 22:37:06 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6A811AA77
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 19:02:22 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1d544a4a315so3908884fac.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 19:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694484141; x=1695088941; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ADp+1o7bgPMWaiUPXbkfmYTAfPBy24czdCXVvagsSWc=;
        b=eMlQ6QnGdqbI/RMuj5wvmjuZCZh+Ozya/lpPcKVpm39nbNdo/3bruFTLSQ6bH+Sqes
         IZN9+ydZqyypNRYmuxzU6yO+B4hMQgGA4X0E1n6W8jDgOryPuPt9I+DUziWUliAF1ODW
         khuTm+mdmgqDxQYMjg2+6wid/xsoupp4dKNsmEBMx5+VwBrHwKY4ta9jRV0FZUBJcayd
         2QKIMhcMZFDEyaHbdg43us6jOmPnjvU38tGouwjPCWZ/jp0ufHhMFd8Rf7flWeYdA8Pm
         Mcsksrnoxm2pn0FILdjMKSFcnNvZ5fFeIK3uxk7EKWw6IQnt3nVIE0E+tVEnu8KLtUE7
         3ZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694484141; x=1695088941;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADp+1o7bgPMWaiUPXbkfmYTAfPBy24czdCXVvagsSWc=;
        b=TmoCbEso0gG0KJW9HahRrRJWByiCjZu9/vFEMeH/iiG5NGz1xo74qXESLoVznaEDqL
         Xc2y62xNPSHAUJce2hq7dcqxsEjrevRg4M7za2VgZJLc5nCGrOlIvTAxB+hSV90pnmXM
         yYf5m3KbKuNdNXaC0C+hL6Um2g7I0JR7JEDxqkFXVOJQWxlmPEYWrFcGPBc21iDLPG0Q
         LCzjT5GpFSOMHRJ1fLq5fiQiwXQD6Ilv4uwDzXDlP6E2ySKX9rvDSj5zJEkrer2TA3Z3
         kBEKWUQwCCBMW4/LF6NN/pnkLspHJleWs7k99gm7RHcmlXeChRH0DdpwD87e6K5Vr+bD
         Fyjw==
X-Gm-Message-State: AOJu0YwJZivttJH6LZrBLtw9vIPzDnNV+ijNYtADsPm3A6sxm1KmrAaO
        MlYL1X7jEyOWoGAzFx94e75p6bVTFoQ=
X-Google-Smtp-Source: AGHT+IE+pKiYidWjmMiZibBvwGxUkd8kyjdqgi06vuuYNwR72TtY7sJQ17wYpPkQnJUwJwMh8WXwzg==
X-Received: by 2002:a05:6870:d202:b0:1ba:8307:9a13 with SMTP id g2-20020a056870d20200b001ba83079a13mr14726784oac.11.1694484140969;
        Mon, 11 Sep 2023 19:02:20 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.10.194])
        by smtp.gmail.com with ESMTPSA id k65-20020a636f44000000b00565009a97f0sm6068410pgc.17.2023.09.11.19.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 19:02:20 -0700 (PDT)
Message-ID: <64ffc6ac.630a0220.bd986.ff43@mx.google.com>
Date:   Mon, 11 Sep 2023 19:02:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8216998455185932774=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] device: Fix not handling initiator properly
In-Reply-To: <20230911223355.2701293-1-luiz.dentz@gmail.com>
References: <20230911223355.2701293-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8216998455185932774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=783186

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      32.98 seconds
BluezMake                     PASS      981.12 seconds
MakeCheck                     PASS      13.94 seconds
MakeDistcheck                 PASS      186.99 seconds
CheckValgrind                 PASS      307.42 seconds
CheckSmatch                   PASS      404.91 seconds
bluezmakeextell               PASS      122.37 seconds
IncrementalBuild              PASS      805.23 seconds
ScanBuild                     PASS      1241.03 seconds



---
Regards,
Linux Bluetooth


--===============8216998455185932774==--
