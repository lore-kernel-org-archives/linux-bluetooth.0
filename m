Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA422C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 23:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC3E60527
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 23:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhIUXCT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Sep 2021 19:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhIUXCO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Sep 2021 19:02:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54B9860527;
        Tue, 21 Sep 2021 23:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632265245;
        bh=UULIoWm/X4YrXcxcDXWfCIY3VVBUs+fa1m5TTJkF7YY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RPdVob2H5q00Xen4qmI2jyU56xAW8gIiAMC3GGsccHXazOEdyjaUMrJZHyusu+poV
         0yvjenHADLILWGhLPMySMebWBcSB6U/Pi+Ei5InWIWq6Uox1YlhS0hC2SRZWQeqsCO
         KThfVynH1VNENXk78EcVNsJsZTBDsGglss5g+6/eGTQJNmANKvq1kZQh7v9Edpgs8U
         aV62wdXEj2aC4FRKBcpeL/R1jeaXqQO4EUoZWTfo/PuzkonkuGAFjweBrJNUf06JJy
         R2zpWfJLvt1hbRrDvxvOfKVBB7oeqeCA9DtLpr+yzNo3N/+PwbpFRck01Ytxh0WoXN
         y8FbQ91AQqiOw==
Date:   Tue, 21 Sep 2021 16:00:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Intel bt broken on linux-next?
Message-ID: <20210921160043.24f1cc03@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210916145625.4e0b8c8e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210916132747.218fb12f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <ae7804e8a9877f94a7c798ac4c787a7f7f7f21af.camel@linux.intel.com>
        <20210916145625.4e0b8c8e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 16 Sep 2021 14:56:25 -0700 Jakub Kicinski wrote:
> > Also, do you still have a problem after cold reboot the system? (completely shutdown and wait some
> > seconds before start).  
> 
> Let me get back to you on that.

Full power cycle fixed it. Thanks for the advice & sorry for the noise!
