Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AF9C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 06:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83C320809
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 06:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8ECmH1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgFSGJG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFSGJG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 02:09:06 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0219CC06174E
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 23:09:06 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id w90so6396860qtd.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 23:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YPVSRSwI79Lx+Cd96JIUfzrjcqjZipcLUbKPPtbqLes=;
        b=Z8ECmH1yik/abJqiTKwaDCS/hFteeMUsRDu4B6zHBlkp5iw3H1h4GGjQplCw6VKCyx
         FjN2MwTdmY+G7XfX2ErWqsTKDMMR2Y4t1Gw+VkEM8pw2s0z15/KqvX4ZIcTeJLNLvwBp
         XfHA4qT5zTo3OQkSvcKnEGJys274O7Y6hQauawP9xa73B401VWXZ/d9bFPzW6wApKstm
         XGYHbBkszH8aV+d4XVbzYOUMA0eKu3htD7lRVF0C1DUnKRn5bGTIunQ/MSXs5CGWeSfG
         LHHpf8ENsUB4x1BXgWhJHm4Ow3PO2C/ERcOiYlpUmJQBx/D6I3yBS2SniAhDUWSv5BKm
         Iu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YPVSRSwI79Lx+Cd96JIUfzrjcqjZipcLUbKPPtbqLes=;
        b=pqdn3uD6YVepOBLIYBNKX8yikgEAanV2bPS+ss/EUTNZ3px5YROINO9KPiK+oPzvxq
         St20r0MyZDvcRlqmQ0PwDAaNLD9kUtp/hKDyMPjvojmTQNzkZxZMgBLyxMi2ENAET1sM
         cb/LU0ZXEP1ME0po2FaxCzvCIccMZx/twiHiKNJrO+xhJaK1WE3lGPov+OaKVBf1DtlU
         rE5K837a4mmCQsleGCLpFXdZaqUA58zc793FoX298uKCjyWxLiq3ApoVN95BQrhXjo8G
         bf828iyusy0RO802GpJ9UC1SZoDitKMsmgveXS0tIxIlgKZgW5z5CsTssdV41KHpJHAU
         3+8w==
X-Gm-Message-State: AOAM531cjQnhif11ttahJjD/2SyFw0+H9nOtOdiO7V0M+rmAeAhxMnU+
        kCF+yOMw06aQPWsZdGF/r8V2fjTmAp4=
X-Google-Smtp-Source: ABdhPJw608f9mkXlTGog4gGcXSs59TxPLuMscCoJodfY9TDSst1wuteRK2Df8FSUG1aaFjLfLXAFiA==
X-Received: by 2002:ac8:3682:: with SMTP id a2mr1870672qtc.137.1592546943741;
        Thu, 18 Jun 2020 23:09:03 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.0.124])
        by smtp.gmail.com with ESMTPSA id i21sm4116265qke.9.2020.06.18.23.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 23:09:03 -0700 (PDT)
Message-ID: <5eec567f.1c69fb81.ada50.35bf@mx.google.com>
Date:   Thu, 18 Jun 2020 23:09:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7274689799594696785=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [2/2] midi: Fix random empty timestamp_high value
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200619060153.65114-2-tedd.an@linux.intel.com>
References: <20200619060153.65114-2-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7274689799594696785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:TYPO_SPELLING: 'becuase' may be misspelled - perhaps 'because'?
#7: 
is a chance that the value becomes zero becuase it reads the value

- total: 0 errors, 1 warnings, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============7274689799594696785==--
