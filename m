Return-Path: <SRS0=OFBO=AG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16641C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 23:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF86F206DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 23:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQydd0aK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgFYXsB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgFYXsB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jun 2020 19:48:01 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB721C08C5C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2020 16:48:00 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id e11so7287006qkm.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2020 16:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=XjwTOBhLqLk3lbD/LuqxrbU8FsGj6dGhLCi+5tHF7gA=;
        b=rQydd0aKz8YtSLPHoByCxPosfoknbELIDbJhoxkF4/S0+5sdRdeP/okEkIwIXPbGns
         nseo8vYGQi0WYNowyrjxAsp//dc5BSabu38uK5EQsZUoIPpSrvjzQCtfUCs9i6G1TXAc
         7aoct3/VHUuOCaPu/nl99YlteG48sSIT09w0rDyeEJVz8M+AAdFDwxb/36QHILmY6mmg
         djZmZI0DYVjvaIwt13qHgVFhyzzJ3LgAK7TJtIdqfL1LG1CAaHHch28hHUAsPcAugqey
         QIpkRITcsjcy8h25joXdei4VboWqsGswrXPlMuhxmWp8rlq0AhM8kiLDM2V8P76rY9QF
         MOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=XjwTOBhLqLk3lbD/LuqxrbU8FsGj6dGhLCi+5tHF7gA=;
        b=nC4m8iTSwW5TEdYgfuMfn+lVvPjx6E0limTCt5O8apyW8WGPu6P+pAkp5fgWOXENRs
         AXqYa1M7jnpFRvgRsMmXZCaCQQMqKf0nwYzt6bhB7V0bJ1Hl9Wx3o7CqhisJeQyhgOl3
         RFLxpB2z8HeDhUiqra3T1RMLwXcqTKYwoQu52OT/SUVtvLdvFZjdHW68dBQQEmTdMsO1
         xI1Q6Xj6swZTu+sQ/h+7rIgts+Alr+LAWjlAo42E9UV+3+kzCSxAepuIDjO931YfIHJE
         wa3fQJ+Pg1SRnqX5GpsvcLhfBMuDiRlhC11/n7Q4CAvSmGJIMgi+F8rF/YyrE/9Pptbt
         B2fg==
X-Gm-Message-State: AOAM533EZj9XJw4O62MqoPsHoYa+Ot3UhzdKHgdlQMuKhowiLD39wIB/
        0yql8bH0AXchUSOg18ucjz50cYq1WHY=
X-Google-Smtp-Source: ABdhPJzureThYlxGt4tQqBwxc0m5JHFR5jf77v/yVn3fSQHsbFC66OSQsOdxXeeTg7Da/jpF3P9+qg==
X-Received: by 2002:a37:9c8f:: with SMTP id f137mr213725qke.63.1593128878985;
        Thu, 25 Jun 2020 16:47:58 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.57.48])
        by smtp.gmail.com with ESMTPSA id z77sm7085083qka.59.2020.06.25.16.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:47:58 -0700 (PDT)
Message-ID: <5ef537ae.1c69fb81.d2589.8353@mx.google.com>
Date:   Thu, 25 Jun 2020 16:47:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5604472060624089469=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [BlueZ] btp: Update connect event structure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <c77abd13007953bce8b42203d4ec08c756832df1.camel@linux.intel.com>
References: <c77abd13007953bce8b42203d4ec08c756832df1.camel@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5604472060624089469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
6: B3 Line contains hard tab characters (\t): "    Controller Index:	<controller id>"
7: B3 Line contains hard tab characters (\t): "    Event parameters:	Address_Type (1 octet)"
8: B3 Line contains hard tab characters (\t): "			Address (6 octets)"
9: B3 Line contains hard tab characters (\t): "			Connection Interval (2 octets)"
10: B3 Line contains hard tab characters (\t): "			Connection Latency (2 octets)"
11: B3 Line contains hard tab characters (\t): "			Supervision Timeout (2 octets)"



---
Regards,
Linux Bluetooth

--===============5604472060624089469==--
