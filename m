Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C927C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 19:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0862F221F9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 19:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbhADTsv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 14:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhADTsv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 14:48:51 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63F4C061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jan 2021 11:48:10 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id z20so19319971qtq.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jan 2021 11:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=WpYiCQODHdt+Iekmc38+ljkNJQFtx5BX9utKE2K9t8A=;
        b=p4CAealePtEG9sU9ZejABATieCCT4WfcTqzbB2/WVCmfbBqmyTCdyzaKUgttXMnwr5
         zw3XANRuN67slAr9fIhfut6RykOKvP4eEqWRr/DQbBGZlBs/qY0KTUBZwWqb5G69VyAD
         Ikf6ikOb1XUn+7sHNWptYJtj3ylsihfbNgYSLiSmLYnw+Xyk/TIHNpkeE2GtGATIVBPl
         VlFf5rH2uzvGcScCKqhb1N7YhUo90G4BAdI5DSlZOEFCMjQi11cNusmKC39MYS9Xy+lI
         Iq8o6WvSktuw8NsPpZ593RHkdQLze+q+qNjslY6+lrwymLoCnX5G1eRJuobYH/LMnt+J
         vW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=WpYiCQODHdt+Iekmc38+ljkNJQFtx5BX9utKE2K9t8A=;
        b=BMAzsjrCtb+VkYcRXEZDwEL7ogFZ0iESkL1rFp3d7MVW6qRrN6WXExjdbbct3RQKu4
         0i08AoBBS2FvVJfl+p9VpWZuNVBZ9TRCUBCu9izxpNUhEdiQWg592yaehFbWixRkE3uo
         aOsQB8WtNBg/8bM5lgNf2sOvywJwP/AAWpCw3KgXedXSTGEQgQPggTTHjiVBv5WpGC4F
         L6MaQxuV8e2YbrofvtmJWRclv4maDIb4UV/XNOwJxsZhpjk1rkuLpKOZnl0nY1vfL+oE
         E+n3O4WsqRfsuRETd9cI5LQhMOCgzWirSJYKdDgmUptSlMQGeHQNX3UllrUIYmUG4L7z
         iKYg==
X-Gm-Message-State: AOAM531VF7DwhorYeJ7/gYLX4vLIENDAqTN1jXmBpAc++u6uhmyG3gio
        QwoqwUXnJjtsO4L6UgF4noWiuSNrobSE2g==
X-Google-Smtp-Source: ABdhPJwDN6i4guuWCqXmJ+vdECQFWufo7ecaGq2K19oTtOdal9e5ljCMyB6jT4FUcXnOqlwCYc6NoQ==
X-Received: by 2002:ac8:6b14:: with SMTP id w20mr72804921qts.320.1609789689755;
        Mon, 04 Jan 2021 11:48:09 -0800 (PST)
Received: from [172.17.0.2] ([13.77.86.237])
        by smtp.gmail.com with ESMTPSA id q73sm37870814qke.16.2021.01.04.11.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 11:48:09 -0800 (PST)
Message-ID: <5ff370f9.1c69fb81.26e9d.fd6f@mx.google.com>
Date:   Mon, 04 Jan 2021 11:48:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1758576364422510759=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v2] cfg: Add check for newly used function in ELL
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210104194013.580654-1-brian.gix@intel.com>
References: <20210104194013.580654-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1758576364422510759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=408835

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============1758576364422510759==--
