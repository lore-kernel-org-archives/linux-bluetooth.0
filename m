Return-Path: <SRS0=ihQD=NM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87D8C0044C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 14:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984CB205F4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 14:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raLz4GeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984CB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeKAXan (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:30:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34759 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeKAXan (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Nov 2018 19:30:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id e9so16402450oti.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Nov 2018 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWd75SP4Lo2E25HAB7Xb2517i6N34GevPDAIZdLF6bc=;
        b=raLz4GeQKykpyM+6EobWhQJ3RuwTzLjfWBlCAU7q8s+W3bvzYtcE0ka5DEEYENq6bk
         A5Nj6QfPWJqj28Sq85tkKqiKuzuO4z/Y/2jvXbV+8ve0d5gRuUP4Rbv3EJRm8jXuTQRO
         YhpIulYfZdY3c+YzawnDRAuwqX7H5kya+FdthK4W3whS1CVqeww5lpZyb95Gza/ews3Y
         +V7NhNLMvGpB/9XAI92G+R9TqEEny10bivSE1cfMbfTxqJP6s9oW841h7d+n4+qr12oe
         WLeZ0QP2XYzyqguiszWukZkWno76NP/uTDfdrGmQ4OwfLcp88FW+aIgPmfiI0ML5Lc8s
         pckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWd75SP4Lo2E25HAB7Xb2517i6N34GevPDAIZdLF6bc=;
        b=iKERV3Ep5o/LmpsC9IFum4hITjhv6Qv/c6Rc1G4rfoAOtS3RIwqgyK5UZZySLgRKln
         up2eBXZrXYrY9Xa4p285iv93bwYGbwCKS8TAk45RRUjCEr+C8KlEhWJSeJdtFdPMMPCy
         H6vjU2pByToptkOE2qwssF8MxtL+aqFZ4VXe+/Zx+t7Uv1Fh7AvgPWt3+jzsKh6wbwbX
         Huks20Rez9AF79LgEPW5SKDv/sWythWtIuSgC4ALhMWXfeMm9XiKJ2VJP6YKyWc5G3zP
         PsQWgwo+XKlbUjcX93o+PLIGe2p4IQZTaz75nV/DB4c4/EkO0eHxHYYF8cegucDVwK/L
         8WwA==
X-Gm-Message-State: AGRZ1gKYXQ6CSU+ogrI7kt6m8Szgy8vgTytsAysCyEOC52M0z2yzpxQ+
        EVBvlbP1m7PFG5GqOC7DRSkJWzA5oZ3P0sQGKgk=
X-Google-Smtp-Source: AJdET5ePhgioPlVt7FBoKmR+S6eW7M8Dm/9QexWhLzvjAy9m0MNE1tSANFuEpGR/QFBjnbMUJweJ5JLC1NK0TIGGp90=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr4928544otl.342.1541082450531;
 Thu, 01 Nov 2018 07:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181101075451epcms5p466176e62713906cef4d5aa41ef8cfc2e@epcms5p4>
 <20181101075451epcms5p466176e62713906cef4d5aa41ef8cfc2e@epcms5p4>
In-Reply-To: <20181101075451epcms5p466176e62713906cef4d5aa41ef8cfc2e@epcms5p4>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 1 Nov 2018 16:27:19 +0200
Message-ID: <CABBYNZ+f5nsJnqa85EBt2GDv2ZL-kE9pa5NsjuJEwjTnm=qdCA@mail.gmail.com>
Subject: Re: Kernel interace for LE Set/Read PHY API's
To:     Anupam Roy <anupam.r@samsung.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Anupam,
On Thu, Nov 1, 2018 at 10:26 AM Anupam Roy <anupam.r@samsung.com> wrote:
>
> Hi,
>  Is there is any plan or on-going work to support kernel interface for BT 5.0 PHY based HCI commands - 'LE Set PHY', 'LE Read PHY'?
> Actually, we would want to have support for the above, such that PHY parameters can be updated\indicated from user space BlueZ for any particular connection.
> As I see, currently there is no kernel interface via which application can change PHY or atleast request controller to change PHY (for a particular connection)
>
> In order to support these via kernel interface, I think following could be possible approaches.
>  - via kernel's MGMT interface (I am not sure if this would be ideal approach to set PHY preferrence from user space)
>  - via L2CAP socket options (Bluez user space would be able to read\Set Preference for a particular connection handle)
>  - via kernel internal logic (Don't expose control to user space and handle Read/Set PHY internally inside kernel. Choose 2M always, irrespective of user's preference.
>        But, i am not sure, if this would conflict with different application's requirement for a particular PHY.

I think it might be better to have a QoS option per socket since it
probably need to accessible at application level, that way the
application can configure its preference which may or may not be
attended in case there are more channels, for instance if app A
request 1Mbit/s and app B request 2Mbit/s than we probably should go
with 2Mbit/s but this is a policy that could probably go into the
kernel directly. This could also be extended to connection parameters
as well, in fact I think we would benefit more from starting with
connection parameters and then add PHY field later on.

> Also please suggest if there is any other better way to support these?
>
> Why we would require these support?:  Even though LE Set Default PHY can be used to indicate controller about preferrence/mix of certain PHY's, it will be applied (unless controller denies it based on Connection interval or other requirements)
> for all subsequent connections and hence no per connection(application) control over PHY.
>
> Please provide your suggestions/comments on how to go about with these!
> Thank You very much!
>
> BR,
> -Anupam Roy



-- 
Luiz Augusto von Dentz
