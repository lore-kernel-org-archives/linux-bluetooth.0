Return-Path: <SRS0=BOCR=WN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2363C3A59B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 11:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F54E21019
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 11:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql6ocIzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfHQLdc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Aug 2019 07:33:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43833 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfHQLdc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Aug 2019 07:33:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so3532930pld.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Aug 2019 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SAM3PyO+TJncg8wgkXGt6zutUE29cfgu50rH4D8aMLI=;
        b=Ql6ocIzDxFu+WXuUNHE+5XTKAu/avgSRvhBlorx0poN8l2M9R92zON84oHPZET98UR
         Iq5c5fXKNl6YLppGf6vj09mgaMXkiAO+ZiOfMeF3qxu3pbJIt6ka6cl5kO4yq5pgj+bZ
         eTLdGtBLLkVPTzoo6LAcBr/TbsJBNDPE2saQEBO2GVmBPl76axqbpJH1d2hHQVjFIkl+
         dk8P3JvJUUYuOecWXL+3rmTOpC8Eay4GU6c5bBExwrmfFkqMYRoWQ0Vybd8I1oyHKuOD
         c9QPFvdfa9e+b/G0lHurUobN7B4qPORzJjL1LOKEkfthgcsiSHtaLCCnQFYY8fltvDZz
         0Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=SAM3PyO+TJncg8wgkXGt6zutUE29cfgu50rH4D8aMLI=;
        b=UJkmbyd1y4PnwO7N5BT3QhyYMO5KYS8Bg8tMjNpzP71k7EbHoCNhXxq/hb3x17DGWx
         TrW6IZqyj4qwGX9GoO532iABqOtouRYs5TSrrVh/bA0u6MWPOcDHAahz3SuSXNN5gWJN
         +RbT/wj+PjABsV5VW+9A19/8JXB5mF5VhJH1E6iyMHurW54AgsZOJEv7JLJXhjy/1Fhu
         T8ZAZjal+oLdIVcX2bu7HklDYnLkkwEc0zfzCEUfCMD1o42hvNpo7O4BiRYkM/uGYcLL
         3f17F7w+7E4pKafLw7uykuiz6XLpF8BUYd703BEqm6tSDoTG7dNM2+f+J+TuAfXSwBI8
         plEg==
X-Gm-Message-State: APjAAAXExNfVx5hhvRXfP0eHe4rsDbqLa+jscUaAu3NRy1rNepza7wIL
        Yk7DLlP+MwloNI1Ldqm0j/yV34PnXr8Elw==
X-Google-Smtp-Source: APXvYqyMZIpyJx5aoNVbupdkz3xwXOV942u9vf4qmbWS7vLmv7MAs1swzo7f/hSCRgux7vdujqzKQA==
X-Received: by 2002:a17:902:166:: with SMTP id 93mr13833532plb.195.1566041611155;
        Sat, 17 Aug 2019 04:33:31 -0700 (PDT)
Received: from localhost ([192.55.54.43])
        by smtp.gmail.com with ESMTPSA id f12sm8275046pgo.85.2019.08.17.04.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Aug 2019 04:33:29 -0700 (PDT)
Date:   Sat, 17 Aug 2019 14:33:26 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add debug setting for changing minimum
 encryption key size
Message-ID: <20190817113326.GA5851@abukhnin-mobl1.ccr.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20190716183441.27501-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716183441.27501-1-marcel@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Jul 16, 2019, Marcel Holtmann wrote:
> For testing and qualification purposes it is useful to allow changing
> the minimum encryption key size value that the host stack is going to
> enforce. This adds a new debugfs setting min_encrypt_key_size to achieve
> this functionality.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         |  1 +
>  net/bluetooth/hci_debugfs.c      | 31 +++++++++++++++++++++++++++++++
>  net/bluetooth/l2cap_core.c       |  2 +-
>  4 files changed, 34 insertions(+), 1 deletion(-)

The patch has been applied to the bluetooth stable tree. Thanks.

Johan
