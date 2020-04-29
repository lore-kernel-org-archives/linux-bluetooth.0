Return-Path: <SRS0=4cRj=6N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC55FC83003
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 08:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F2E920787
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 08:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD2INl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:13:41 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43554 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2INk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Apr 2020 04:13:40 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 18806CECFA;
        Wed, 29 Apr 2020 10:23:18 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v4] doc: Add Advertisement Monitoring API
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200427131208.BlueZ.v4.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
Date:   Wed, 29 Apr 2020 10:13:37 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D989C44F-A240-4129-8EF6-513645E5DFE6@holtmann.org>
References: <20200427131208.BlueZ.v4.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
To:     Miao-chen Chou <mcchou@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao-chen,

> This patch proposes an Advertisement Monitoring API for an application to
> register a job of monitoring ADV reports with content filter and RSSI
> thresholds.
> ---
> 
> Changes in v4:
> - Change the signature of SupportedMonitorTypes to be array of strings.
> - Fix document formatting.
> 
> Changes in v3:
> - Introduce SupportedFeatures to reflect the features based on
> controller's capabilities.
> - Modify SupportedMonitorTypes to list available types of monitors.
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
> doc/advertisement-monitor-api.txt | 137 ++++++++++++++++++++++++++++++
> 1 file changed, 137 insertions(+)
> create mode 100644 doc/advertisement-monitor-api.txt
> 
> diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
> new file mode 100644
> index 000000000..012fce420
> --- /dev/null
> +++ b/doc/advertisement-monitor-api.txt
> @@ -0,0 +1,137 @@
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
> +Interface	org.bluez.AdvertisementMonitor1 [experimental]
> +Object path	freely definable

can you please at least roughly follow the style regarding the empty lines from the other documents.

> +
> +Methods		void Release() [noreply]
> +
> +			This gets called as a signal for a client to perform
> +			clean-up when (1)a monitor cannot be activated after it
> +			was exposed or (2)a monitor has been deactivated.
> +
> +		void Activate() [noreply]
> +
> +			After a monitor was exposed, this gets called as a
> +			signal for client to get acknowledged when a monitor
> +			has been activated, so the client can expect to receive
> +			calls on DeviceFound() or DeviceLost().

Do we actually need this? As noted by Szymon we would expect RegisterMonitor to only return when it successfully active a monitor.

> +
> +		void DeviceFound(object device) [noreply]
> +
> +			This gets called to notify the client of finding the
> +			targeted device. Once receiving the call, the client
> +			should start to monitor the corresponding device to
> +			retrieve the changes on RSSI and advertisement content.
> +
> +		void DeviceLost(object device) [noreply]
> +
> +			This gets called to notify the client of losing the
> +			targeted device. Once receiving this call, the client
> +			should stop monitoring the corresponding device.
> +
> +Properties	uint8 Type [read-only]
> +
> +			The type of the monitor. See SupportedMonitorTypes in
> +			org.bluez.AdvertisementMonitorManager1 for the available
> +			options.
> +
> +		(Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers [read-only, optional]
> +
> +			This contains HighRSSIThreshold, HighRSSIThresholdTimer,
> +			LowRSSIThreshold, LowRSSIThresholdTimer in order. The
> +			unit of HighRSSIThreshold and LowRSSIThreshold is dBm.
> +			The unit of HighRSSIThresholdTimer and
> +			LowRSSIThresholdTimer is second.
> +
> +			If these are provided, RSSI would be used as a factor to
> +			notify the client of whether a device stays in range or
> +			move out of range. A device is considered in-range when
> +			the RSSIs of the received advertisement(s) during
> +			HighRSSIThresholdTimer seconds exceed HighRSSIThreshold.
> +			Likewise, a device is considered out-of-range when the
> +			RSSIs of the received advertisement(s) during
> +			LowRSSIThresholdTimer do not reach LowRSSIThreshold.
> +
> +		array{(uint8, uint8, string)} Patterns [read-only, optional]
> +
> +			If Type is set to 0x01, this must exist and has at least
> +			one entry in the array.
> +
> +			The structure of a pattern contains the following.
> +			uint8 start_position
> +				The index in an AD data field where the search
> +				should start. The beginning of an AD data field
> +				is index 0.
> +			uint8 AD_data_type
> +				See https://www.bluetooth.com/specifications/
> +				assigned-numbers/generic-access-profile/ for
> +				the possible allowed value.
> +			string content_of_pattern
> +				This is the value of the pattern.

This part we really need to discuss and come to an agreement. I am not in favor of doing these as properties on the monitor object. I would give them as dict to the RegisterMonitor.

> +
> +Advertisement Monitor Manager hierarchy
> +=======================================
> +Service		org.bluez
> +Interface	org.bluez.AdvertisementMonitorManager1 [experimental]
> +Object path	/org/bluez/{hci0,hci1,...}
> +
> +Methods		void RegisterApplication(object application)
> +
> +			This registers a hierarchy of advertisement monitors.
> +			The application object path together with the D-Bus
> +			system bus connection ID define the identification of
> +			the application registering advertisement monitors.
> +
> +			Possible errors: org.bluez.Error.InvalidArguments
> +					 org.bluez.Error.AlreadyExists
> +
> +		void UnregisterApplication(object application)
> +
> +			This unregisters advertisement monitors that have been
> +			previously registered. The object path parameter must
> +			match the same value that has been used on
> +			registration.
> +
> +			Possible errors: org.bluez.Error.InvalidArguments
> +					 org.bluez.Error.DoesNotExist

My choice of method naming would be RegisterMonitor and UnregisterMonitor.

> +
> +Properties	array{string} SupportedMonitorTypes [read-only]
> +
> +			This lists the supported types of advertisement
> +			monitors. An application should check this before
> +			instantiate and expose an object of
> +			org.bluez.AdvertisementMonitor1.
> +
> +			Possible values for monitor types:
> +
> +			"patterns_with_logic_or"
> +				Patterns with logic OR applied. With this type,
> +				property "Patterns" must exist and has at least
> +				one pattern.

To be consistent they need to be “patterns-with-or-logic”. And maybe “or-patterns” is just enough.

> +
> +		array{string} SupportedFeatures [read-only]
> +
> +			This lists the features of advertisement monitoring
> +			supported by BlueZ.
> +
> +			Possible values for features:
> +
> +			"controller-based-monitor-by-patterns"
> +				If the controller is capable of performing
> +				advertisement monitoring by patterns, BlueZ
> +				would offload the patterns to the controller to
> +				reduce power consumption.

I would consider shortening this to “controller-patterns”.

Regards

Marcel

