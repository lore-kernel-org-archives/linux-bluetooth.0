Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C193CC43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 09:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907D92072E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 09:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="ZO78c02k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgC3JZY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:25:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46697 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgC3JZX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 05:25:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id r7so9595946ljg.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJ9C9dYiCLJdGePHBAtBsqoHOR7gP2km4zdJEPXWv48=;
        b=ZO78c02kdGUnejHar4FAM1MpwQyJo5fk9xywjEDnuwfTDOcJe6EgcdWi54439fEOXU
         1pPK2aJhSPuMKvCDq/A2PESadk6YNVy76BDbFZaJnEIac8saT56MKxp8Xd3bjN57kbdK
         fWAJAv4TUX24hkbO5FCeenOrG2p/CAseJuGh1kA/52wOgU0OdX8bH1e0M5cwaBbO0aX0
         USau8FFUhgAFQaoVk9AKUYWL3JwyO31DSs9wqh+0+dshyC0QQeXnQucT6o0I7gKCf4fr
         bIjtpmCHjVEKEYM5IJEGFVMQoIlokjBZ5r2CN6BtG0an9oqwOrIJ3wcNB7wjhMKTtAhi
         QUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iJ9C9dYiCLJdGePHBAtBsqoHOR7gP2km4zdJEPXWv48=;
        b=D6DvsZBBlmWs+LYWmncptqIy422QaOw3kxhFy6YpMlbhGXmSbsbQZ63QtBZ7QUHCdr
         7vBugW/QRerumC7YRsOo5q7uUHxCzMDMPMKeYoZ0sCWmFjnwSGHah7UL4mOk7WQfRATk
         fBxiKoTn8VEDl7VGz3sf3uf5y+jhn/FlLNgFxWxg6TZaoWM7knZyd39QwDXmSEq0/DSu
         aVtvCO4PqtyBjPrHSqU+g6BFPSsvP0UtGUJs9udOeqgznzxybFwkEG6weRZDFPpNObXM
         zy3vh0Cl8KpuL+fm1oPfbOvDyz1cAX3pfiFPV7/PI1KrP3r04sLEodnS6TwNbqpMTw7N
         0ruA==
X-Gm-Message-State: AGi0PuZMqQtpyAivEtwO/47s2FCcxukCSX7EWA+/Jf/odd+yzkDMEv4o
        bqncY/uA0eeAfsVgIPYoAonrQA==
X-Google-Smtp-Source: APiQypIyWJYgHOhuAvbJ2jdL/QaeHA76kWeN/yfNqPzR3JD1/kfe0TN+pjLGBrnzLuDpQLhs6qO3GA==
X-Received: by 2002:a2e:9dcf:: with SMTP id x15mr2316503ljj.106.1585560321453;
        Mon, 30 Mar 2020 02:25:21 -0700 (PDT)
Received: from ix.localnet (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id v20sm6571987lfe.52.2020.03.30.02.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 02:25:20 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Howard Chung <howardchung@google.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
        chromeos-bluetooth-upstreaming@chromium.org
Subject: Re: [Bluez PATCH v2 3/6] doc: Add documentation for LE Set Advertising Interval
Date:   Mon, 30 Mar 2020 11:25:19 +0200
Message-ID: <528530767.EP9f1MIPRH@ix>
Organization: CODECOUP
In-Reply-To: <20200330160343.Bluez.v2.3.Ia74c1ab0a71d90f46f10b4e32743cab722a97bbb@changeid>
References: <20200330080357.96989-1-howardchung@google.com> <20200330160343.Bluez.v2.3.Ia74c1ab0a71d90f46f10b4e32743cab722a97bbb@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Monday, 30 March 2020 10:03:54 CEST Howard Chung wrote:
> Signed-off-by: Howard Chung <howardchung@google.com>
> ---
> 
> Changes in v2: None
> 
>  doc/advertising-api.txt | 13 +++++++++++++
>  doc/mgmt-api.txt        | 25 +++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> index b0565eab2..9264cdb27 100644
> --- a/doc/advertising-api.txt
> +++ b/doc/advertising-api.txt
> @@ -209,3 +209,16 @@ Properties	byte ActiveInstances
>  			Possible values: "1M"
>  					 "2M"
>  					 "Coded"
> +
> +		void SetAdvertisingIntervals(uint16 min_interval_ms,
> +					     uint16 max_interval_ms)
> +
> +			This method sets the advertising intervals.
> +
> +			The parameters min_interval_ms and 
max_interval_ms
> +			are specified in milli-seconds. Valid values of
> +			the intervals must fall between 20 ms and 10,240 
ms.
> +
> +			Possible errors: org.bluez.Error.Failed
> +					 org.bluez.Error.InProgress
> +					 
org.bluez.Error.InvalidArguments
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 27a41f334..5eff87e24 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2925,6 +2925,31 @@ Read Extended Controller Information Command
>  				Invalid Index
> 
> 
> +Set Advertising Intervals Command
> +=================================
> +
> +	Command Code:		0x0101
> +	Controller Index:	<controller id>
> +	Command Parameters:	Min_Interval     (2 Octets)
> +				Max_Interval     (2 Octets)
> +	Return Parameters:	Current_Settings (4 Octets)
> +
> +	This command is used to set advertising intervals. The intervals
> +	are expressed in multiples of 0.625 ms. The default values of
> +	both intervals are 0x0800. Valid Min_Interval and Max_Interval
> +	values must fall between 0x0020 and 0x4000.
> +
> +	The advertising intervals are first kept in hdev struct. The values
> +	would be sent to the controller and take effect when advertising is
> +	actually enabled. If the advertising intervals are set when
> +	advertising is already on, the advertising would be disabled and
> +	re-enabled to make the intervals take effect.
> +
> +	Possible errors:	Busy
> +				Rejected
> +				Invalid Parameters
> +
> +
>  Set Appearance Command
>  ======================


I feel this should be per instance settings, and if we want this level of 
finetuning we would probably need to have new command for adding advertising 
sets (where we could fix more, eg not limit data to 255 bytes).

Other option would be to maybe have new flags in current Add Advertising that 
would allow to choose from low,med,hi (eg based on GAP recommended values) 
intervals, and then allow to finetune those via extra command or sysfs?

Just my two cents.

-- 
pozdrawiam
Szymon Janc


