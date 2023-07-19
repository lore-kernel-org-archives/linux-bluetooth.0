Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8EFEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jul 2023 15:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjGSP7f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jul 2023 11:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjGSP7e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jul 2023 11:59:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD7710CC
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 08:59:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso65889225e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689782371; x=1690387171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HsL4pIjQAoG5N+TFvgKqcjrLnL/JjQ5VBlWwNh3BthE=;
        b=DnIB1znTysnJ6MVo3jBaswdaO1pY76+dQHXANOdTFdUfam32T9nlFvL73B1EnyDyla
         fq1dd85jbOzT9eK6202aL85ERXAEmSfm3DHp9bZIzv3maJbbFC8oUQvcE790o5SQa0pm
         92+0k9K/MMsQBNpuzCQC+hoghbUzMW9Fbdxzkp/wM8FbB8FfBiUSkz0rMMwK5heyMQAY
         6K01olcnOs12RupMxpKqYTDvVh/M/YRGaM1kOpxR0Q+9wAZbW8OV5mXTJfzInv2sM1E0
         gEoG2TSaEdxYWylSLkJ73qRRjZ/NZ/FWAN5RL9RLlszudrmRGUgpCpdZ7AF+8mvoWPie
         d6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689782371; x=1690387171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsL4pIjQAoG5N+TFvgKqcjrLnL/JjQ5VBlWwNh3BthE=;
        b=LQQnoeNRXZ7EU7Zpmz2hsq0cmLcADTSgC9jOHBxT4qkxZySkcXBFYLYvQaJF0s1zDU
         xAmbT9ZGE4WHAyJHAedahh6o649eJOlSEkjbKweMRA2ygSSddkaYDjnzBYu5fnayD8w7
         lUKyfAiWkZssz4vNBpoqUI5VHEfouV/MDyyiVoOCVGko0Iq1slKGxpuXWp77Ix6+CI5f
         OBJwHnQ0hkqucMP5N/KgqAmN2zUIFUqKl0+Aplw104JvBtevgq9gZl6S8RA2IE8nZyDV
         B4A0968mby1kSIUj85Cd/FqvLMZVODnglDh458EPok7bqAJ6p0UxOfGJUTvjvSYcdBHe
         IZPw==
X-Gm-Message-State: ABy/qLbViOArmvurGu71UbvEUT4H58SyhfP9KgxJGtirMAF84ZZx4ipE
        xWQLhqD+pOmzsHw2akI546apLA==
X-Google-Smtp-Source: APBJJlF1lqVzifTa46fV95xHgtqQnpTh6uXULNZMPtL7TNwHZ9MK7RNGBT6FEGR38DnSbd+QXWqVTQ==
X-Received: by 2002:a1c:4c15:0:b0:3fb:f926:4937 with SMTP id z21-20020a1c4c15000000b003fbf9264937mr2141539wmf.31.1689782371157;
        Wed, 19 Jul 2023 08:59:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m5-20020adfe945000000b0031434cebcd8sm5713182wrn.33.2023.07.19.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 08:59:28 -0700 (PDT)
Date:   Wed, 19 Jul 2023 18:59:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     joeyli <jlee@suse.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Chun-Yi Lee <joeyli.kernel@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_event: Ignore NULL link key
Message-ID: <1acb2d81-0406-408d-b0df-73d1b1a4a9e8@kadam.mountain>
References: <20230718034337.23502-1-jlee@suse.com>
 <41f91e8e-8038-22d8-baa6-91f98afe405d@molgen.mpg.de>
 <20230719153833.GH14791@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719153833.GH14791@linux-l9pv.suse>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

You know how when people are forwarding a patch from someone else it
adds a From: as the first line in the body of the email?  You could set
your From to the @suse.com address that way.

This is sometimes done in companies where the corporate email server
mangles patches so they have to use an outside server.

regards,
dan carpenter

