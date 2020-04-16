Return-Path: <SRS0=gb+p=6A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE459C2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Apr 2020 07:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C273F2076A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Apr 2020 07:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="Du/eCGQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439630AbgDPHte (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439430AbgDPHt2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Apr 2020 03:49:28 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C9EC061A0C
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2020 00:49:28 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w145so4851346lff.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2020 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PetXaBQAAP5AlhnkJpxvt9p7JmrT7o+CxrcKtSclo/s=;
        b=Du/eCGQyVQTJxM/RYBhf3ITQ2rLzAQeE781WuH/DlRYneRANji2xSCdYFZ5LhRWHO7
         c6mctNZUjAftMjit42SsVHh0i9d+IfDn6cRQ6A8LbtC0zraxAeQotNHOtTO7Hv6Y4Msd
         QwQudSw6M0kdHYDfvs3IiHJsbSE4cIG4qjYAAzELmPGumr5pgHmSaYqKhs/46NVwdYer
         P0WfR3jzlnQQgViBAYHE/C9aN0AXZaVEwlA2cmoNzMRvudQSiiBtVhwDafipJ8rGKPzZ
         6hOdoIQNb5h9J63zPr6IDkvqTR4NT3Asd2qPCdpc0jKtwQio+2/d4OAFs+2G70p5xsd7
         V3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PetXaBQAAP5AlhnkJpxvt9p7JmrT7o+CxrcKtSclo/s=;
        b=RlZrRB8We7tBrCnrt3nykdOXCqcWlRY1BcfnH9yem5EjAnWLzaCaMx08dI0v0kDErI
         PHRwTGyJgDIm8m12jzSubDTG/TTzDi3TS0CoTnJsepRX0ketLl7ff7jwat8MgolJ1Teh
         lTH29BzxmlGI0LLKqbs79qkPykmVgqYtDcAAxtc5smOWT3qgm2h+h9nH3oKPppDuIzDr
         Ws5+UwQstskbfTBg2saR4q5XGyBbJzHMK0FI7OdXnuPmkveIy1+ZxWvdT21k6+SCBfn6
         yXf4uGIdpPashcrijhbp1PgDJ5WJUEBResdm5z4vAoTuE9AquGRA/x/L3KTlqPfahDKa
         eO9Q==
X-Gm-Message-State: AGi0PuYUshVHvHPaDvSPJfb8JuQ+yArmmOYH1cqAiElYPMgdGmScffQ6
        Ovsgz224br13/S1KP14lrkL7Kg==
X-Google-Smtp-Source: APiQypK8BsTdNbapGiz/S1q9q0/hymalMCipj9ypUzbuN3U17GgE3VSIqqZhu4R32FepvaXwDTBsZw==
X-Received: by 2002:a05:6512:31c1:: with SMTP id j1mr5396293lfe.14.1587023366673;
        Thu, 16 Apr 2020 00:49:26 -0700 (PDT)
Received: from ix.localnet (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id a28sm14189463lfr.4.2020.04.16.00.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 00:49:26 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [BlueZ PATCH v2] doc: Add Advertisement Monitoring API
Date:   Thu, 16 Apr 2020 09:49:24 +0200
Message-ID: <13923060.5j3lsEUdY8@ix>
Organization: CODECOUP
In-Reply-To: <20200415200831.BlueZ.v2.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
References: <20200415200831.BlueZ.v2.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thursday, 16 April 2020 05:09:03 CEST Miao-chen Chou wrote:
> This patch proposes an Advertisement Monitoring API for an application to
> register a job of monitoring ADV reports with content filter and RSSI
> thresholds.
> 
> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> 
> Changes in v2:
> - Rename the interfaces and functions.
> - Adopt the object manager mechanism so that a client can expose
> multiple monitor objects and expect to get notified on whether the
> monitor has been activated or not.
> - Change the contract of DeviceFound so that it is called to indicate
> the starting point of monitoring on a device instead of reporting every
> ADV. In other words, the client is expected to monitor corresponding
> device events.
> 
>  doc/advertisement-monitor-api.txt | 127 ++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 doc/advertisement-monitor-api.txt
> 
> diff --git a/doc/advertisement-monitor-api.txt
> b/doc/advertisement-monitor-api.txt new file mode 100644
> index 000000000..6491dab29
> --- /dev/null
> +++ b/doc/advertisement-monitor-api.txt
> @@ -0,0 +1,127 @@
> +BlueZ D-Bus Advertisement Monitor API Description
> +*************************************************
> +
> +This API allows an client to specify a job of monitoring advertisements by
> +registering the root of hierarchy and then exposing advertisement monitors
> +under the root with filtering conditions, thresholds of RSSI and timers
> +of RSSI thresholds.
> +
> +Once a monitoring job is activated by BlueZ, the client can expect to get
> +notified on the targeted advertisements no matter if there is an ongoing
> +discovery session (a discovery session is started/stopped with methods in
> +org.bluez.Adapter1 interface).
> +
> +Advertisement Monitor hierarchy
> +===============================
> +Service		org.bluez
> +Interface	org.bluez.AdvertisementMonitor1
> +Object path	freely definable
> +
> +Methods		void Release() [noreply]
> +
> +			This gets called as a signal for a client to 
perform
> +			clean-up when (1)a monitor cannot be activated 
after it
> +			was exposed or (2)a monitor has been 
deactivated.
> +
> +		void Activate() [noreply]

Isn't is enough for RegisterApplication to return to ack this?

> +
> +			After a monitor was exposed, this gets called as 
a
> +			signal for client to get acknowledged when a 
monitor
> +			has been activated, so the client can expect to 
receive
> +			calls on DeviceFound() or DeviceLost().
> +
> +		void DeviceFound(object device) [noreply]
> +
> +			This gets called to notify the client of finding 
the
> +			targeted device. Once receiving the call, the 
client
> +			should start to monitor the corresponding device 
to
> +			retrieve the changes on RSSI and advertisement 
content.
> +
> +		void DeviceLost(object device) [noreply]
> +
> +			This gets called to notify the client of losing 
the
> +			targeted device. Once receiving this call, the 
client
> +			should stop monitoring the corresponding device.
> +
> +Properties	uint8 Type [read-only]
> +
> +			The type of a monitor can be the following 
values. More
> +			will be added.
> +			0x01 - Patterns with logic OR applied
> +				Supported only if "patterns-with-
logic-or-
> +				applied" is supported.
> +
> +		(Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers 
[read-only,
> optional] +
> +			This contains HighRSSIThreshold, 
HighRSSIThresholdTimer,
> +			LowRSSIThreshold, LowRSSIThresholdTimer in 
order. The
> +			unit of HighRSSIThreshold and LowRSSIThreshold 
is dBm.
> +			The unit of HighRSSIThresholdTimer and
> +			LowRSSIThresholdTimer is second.
> +
> +			If these are provided, RSSI would be used as a 
factor to
> +			notify the client of whether a device stays in 
range or
> +			move out of range. A device is considered in-
range when
> +			the RSSIs of the received advertisement(s) 
during
> +			HighRSSIThresholdTimer seconds exceed 
HighRSSIThreshold.
> +			Likewise, a device is considered out-of-range 
when the
> +			RSSIs of the received advertisement(s) during
> +			LowRSSIThresholdTimer do not reach 
LowRSSIThreshold.
> +
> +		array{(uint8, uint8, string)} Patterns [read-only, 
optional]
> +
> +			If Type is set to 0x01, this must exist and has 
at least
> +			one entry in the array.
> +
> +			The structure of a pattern contains the 
following.
> +			uint8 start_position
> +				The index in an AD data field where 
the search
> +				should start. The beginning of an AD 
data field
> +				is index 0.
> +			uint8 AD_data_type
> +				See https://www.bluetooth.com/
specifications/
> +				assigned-numbers/generic-access-
profile/ for
> +				the possible allowed value.
> +			string content_of_pattern
> +				This is the value of the pattern.
> +
> +=======================================
> +Service		org.bluez
> +Interface	org.bluez.AdvertisementMonitorManager1
> +Object path	/org/bluez/{hci0,hci1,...}
> +Methods		void RegisterApplication(object application)
> +
> +			This registers a hierarchy of advertisement 
monitors.
> +			The application object path together with the D-
Bus
> +			system bus connection ID define the 
identification of
> +			the application registering advertisement 
monitors.
> +
> +			Possible errors: 
org.bluez.Error.InvalidArguments
> +					 
org.bluez.Error.AlreadyExists
> +
> +		void UnregisterApplication(object application)
> +
> +			This unregisters advertisement monitors that 
have been
> +			previously registered. The object path parameter 
must
> +			match the same value that has been used on
> +			registration.
> +
> +			Possible errors: 
org.bluez.Error.InvalidArguments
> +					 
org.bluez.Error.DoesNotExist
> +
> +Properties	array{string} SupportedFeatures [read-only]
> +
> +			This reflects the supported features of 
advertisement
> +			monitoring. An application should check this 
before
> +			instantiate and expose an object of
> +			org.bluez.AdvertisementMonitor1.
> +
> +			Here are the potential features. More will be 
added.
> +			software-based-filtering
> +				The filtering process is mainly done 
in BlueZ.
> +			patterns-with-logic-or-applied
> +				Logic OR would be applied among the 
patterns
> +				provided by a monitor object.
> +			rssi-monitoring
> +				Values of RSSIThreshholdsAndTimers 
would be
> +				applied during the filtering process.


I'm bit confused about this API. Why can't this be achieved with (possible 
extended)  SetDiscoveryFilter? We could just add extra prop to Device1 to 
indicate that device is "present".


-- 
pozdrawiam
Szymon Janc


