Return-Path: <SRS0=WCAs=52=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6063DC2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Apr 2020 07:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3558E20801
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Apr 2020 07:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgDJHrO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Apr 2020 03:47:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42470 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgDJHrO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Apr 2020 03:47:14 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4EFD0CED06;
        Fri, 10 Apr 2020 09:56:48 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v1] doc: Add Advertisement Monitoring API
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200409151004.BlueZ.v1.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
Date:   Fri, 10 Apr 2020 09:47:12 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <B0EF0AD0-6044-4ABC-87C9-2A540635594D@holtmann.org>
References: <20200409151004.BlueZ.v1.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
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
> 
> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> 
> doc/advertisement-monitoring-api.txt | 163 +++++++++++++++++++++++++++
> 1 file changed, 163 insertions(+)
> create mode 100644 doc/advertisement-monitoring-api.txt
> 
> diff --git a/doc/advertisement-monitoring-api.txt b/doc/advertisement-monitoring-api.txt
> new file mode 100644
> index 000000000..070487481
> --- /dev/null
> +++ b/doc/advertisement-monitoring-api.txt
> @@ -0,0 +1,163 @@
> +BlueZ D-Bus Advertisement Monitoring API Description
> +****************************************************

I would name it “Advertisement Monitor”

> +
> +This API allows an application to specify a job of monitoring advertisements
> +by providing a filter with filtering conditions, thresholds of RSSI and timers
> +of RSSI thresholds.
> +
> +Once an application registers a monitoring job, it can expect to get notified
> +on its targeted advertisements no matter if there is an ongoing discovery
> +session (a discovery session is started/stopped with methods in
> +org.bluez.Adapter1 interface).

Just for readability two empty lines here. See the other docs for an example. They should be mostly consistent in their style.

> +
> +Advertisement Filter hierarchy
> +==============================
> +Service		org.bluez
> +Interface	org.bluez.AdvertisementFilter1
> +Object path	freely definable
> +
> +Methods		void Release() [noreply]
> +
> +			This gets called as a signal for a client to perform
> +			clean-up when BlueZ has invalidated the filter.
> +
> +		void DeviceInRange(object device, int16 RSSI, int16 TX_power,
> +				   array{dict} ADV_data,
> +				   array{uint8} ADV_raw_data)

Actually looking at what the device object already gives you for free, I think you just need this:

		void DeviceInRange(object device)

You will have the RSSI and TxPower fields and also the advertising data considered for consumption by the application. If you really really need the raw advertising report data, then we might include them as extra property type, but only if asked for. With advertising extensions these can get rather large.

Just to explain this reasoning to only use the object device here. Don’t see it as a full object, since it is just a reference and more precise a filter to find your object in the list of all objects. So an application can ignore everything else, but just has to filter the device object path out from all objects to find the information of the device it was looking for.

> +
> +			If RSSIThreshholdsAndTimers exists, this gets called to
> +			notify the client on finding the targeted device when
> +			RSSI(s) of the matched advertisement(s) exceed the
> +			HighRSSIThreshold at least HighRSSIThresholdTimer.
> +			If RSSIThreshholdsAndTimers does not exist, this does
> +			not get called.
> +
> +			Parameters:
> +			device		The device object path associated with
> +					the advertisement.
> +			RSSI		The RSSI comes along with the
> +					advertisement.
> +			TX_power	The TX power AD data provided in the
> +					advertisement. 127 indicates the absence
> +					of TX power AD data.
> +			ADV_data	The signature of adv_data is a{yv} where
> +					“y” is the AD data type value and “v” is
> +					the value of the AD data where the type
> +					may vary depending on the AD data. For
> +					instance, if "y" is 0x16, "v" would be
> +					an array of bytes.
> +			ADV_raw_data	The raw bytes of AD data from the
> +					advertisement packet.
> +
> +		void AdvertisementReceived(object device, int16 RSSI,
> +					   int16 TX_power, array{dict} ADV_data,
> +					   array{uint8} ADV_raw_data)
> +
> +			If RSSIThreshholdsAndTimers exists, this gets called
> +			every time except for the first time when receiving the
> +			matched advertisement(s) exceeding the
> +			HighRSSIThreshold. Once DeviceOutOfRange() gets called,
> +			this no longer gets called until DeviceInRange() gets
> +			called again.
> +			If RSSIThreshholdsAndTimers does not exist, this gets
> +			called whenever receiving the matched advertisements.
> +
> +			Parameters:
> +			device		The device object path associated with
> +					the advertisement.
> +			RSSI		The RSSI comes along with the
> +					advertisement.
> +			TX_power	The TX power AD data provided in the
> +					advertisement. 127 indicates the absence
> +					of TX power AD data.
> +			ADV_data	The signature of adv_data is a{yv} where
> +					“y” is the AD data type value and “v” is
> +					the value of the AD data where the type
> +					may vary depending on the AD data. For
> +					instance, if "y" is 0x16, "v" would be
> +					an array of bytes.
> +			ADV_raw_data	The raw bytes of AD data from the
> +					advertisement packet.

This differentiation rubs me a bit the wrong way. I think it makes things a bit too complicated.

In case you don’t specify any RSSI thresholds, I would still like to use DeviceInRange and DeviceOutOfRange notifications. We have always used timeouts to indicate that devices are no longer valid and removed them. They needed to be found again. And even without RSSI this will be the case since you have device moving around. So it would be good to indicate that a device is gone.

Now the question is what we do for updates of a device that is currently in range and has been found. I think we don’t have to do anything. Since a client that cares about that device, can just monitor the object properties that we will keep updating as we find the device again. So if the RSSI, TxPower or even the advertising data changes, the client will be informed by a PropertiesChanged signal.

> +
> +		void DeviceOutOfRange(device object)
> +
> +			If RSSIThreshholdsAndTimers exists, this gets called
> +			when RSSIs of the matched advertisements are lower than
> +			LowRSSIThreshold for at least LowRSSIThresholdTimer to
> +			notify the client on losing the targeted device.
> +			If RSSIThreshholdsAndTimers does not exist, this won’t
> +			get called.

We could consider doing a pair of DeviceFound + DeviceLost.

And of course we have to split the callback handling with filter properties. When you read the full method name it needs to make sense. So org.bluez.AdvertisementFilter1.DeviceInRange is not really logical.

I would have something like org.bluez.AdvertismentMonitor.DeviceFound for example.

> +
> +Properties	uint8 FilterType [read-only]
> +
> +			This can be the following values. More will be added.
> +			0x01 - Patterns with OR logic relation
> +
> +		(Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers [read-only, optional]
> +
> +			The contains HighRSSIThreshold, HighRSSIThresholdTimer,
> +			LowRSSIThreshold, LowRSSIThresholdTimer in order. The
> +			unit of HighRSSIThreshold and LowRSSIThreshold is dBm.
> +			The unit of HighRSSIThresholdTimer and
> +			LowRSSIThresholdTimer is second.
> +
> +			A device is considered in-range when the RSSIs of the
> +			received advertisement(s) during HighRSSIThresholdTimer
> +			seconds exceed HighRSSIThreshold. Likewise, a device is
> +			considered out-of-range when the RSSIs of the received
> +			advertisement(s) during LowRSSIThresholdTimer do not
> +			reach LowRSSIThreshold.
> +
> +		array{(uint8, uint8, string)} Patterns [read-only, optional]
> +
> +			If “PatternsWithORLogicRelation” is supported, this must
> +			exist and has at least one entry in the array.
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

This part I would provide as dict to the RegisterMonitor method (see below).

> +
> +Advertisement Monitor hierarchy
> +===============================
> +Service		org.bluez
> +Interface	org.bluez.AdvertisementMonitor1
> +Object path	/org/bluez/{hci0,hci1,...}

If we follow our current style then it would be org.bluez.AdvertismentMonitorManager.

While writing this email so far, I am kinda tempted to call it org.bluez.DeviceMonitorManager and org.bluez.DeviceMonitor. It is just a temptation at this point and it is good to sleep about it for a bit.

> +
> +Methods		void RegisterApplication(object filter)
> +
> +			This registers a job of monitoring advertisement in a
> +			power efficient way. Based on the content of the filter
> +			upon registration, the filter object can expect to
> +			receive the matched advertisements via DeviceInRange()
> +			and AdvertisementReceived().

RegisterMonitor(object monitor, dict thresholds, dict filter)

Having the thresholds and the filters as dicts here make it clear that you have to destroy the monitor and create a new one of you want to change them. I think that is acceptable and in the end an easy task, since you still can reuse the object monitor that you have already set up. It also make the code for bluetoothd simpler since it doesn’t have to track life changes to the filters and act on them.

> +
> +		void UnregisterApplication(filter object)
> +
> +			This unregisters the job of monitoring advertisement.
> +			The filter object can expect to be called on Release()
> +			once the removal is done.
> +
> +		void UnregisterAllApplications()
> +
> +			This unregisters all jobs of monitoring advertisement.
> +			All filter objects can expect to be called on Release()
> +			once the removals are done.

I would rather not have an UnregisterAll. We didn’t need it until now and the object monitor was always bound to the lifetime of the application.

> +
> +Properties	array{string} SupportedFilteringFeatures [read-only]
> +
> +			This reflects the supported features of advertisement
> +			monitoring. An application should check this before
> +			instantiate an object of org.bluez.AdvertisementFilter1.
> +
> +			Here are the potential features. More will be added.
> +			"SoftwareBasedFiltering"
> +			"PatternsWithORLogicRelation"
> +			“RSSIMonitoring”

So all our string values are lower-case and if needed we use - to separate words or logical details.

I think exposing a good interface for selecting the filter patterns will take a bit. I would like to focus on getting the surrounding framework figured out first.

Before finalizing an API, my test was always to write a simple client and check if it meets the requirement for being simple enough. If it becomes cumbersome for the client, then we need to consider putting some of the more complicated parts into bluetoothd.

Let me try to give an example. If the majority of the clients just want to find a device with UUID 0xFE23, then we should have a special casing for that.

	RegisterMonitor(monitor, dict{MatchUUID=0xFE23}).

Done. That they have to differentiate between one vendors way of doing this compared to another on how to provide the information should be up to bluetoothd to figure it out (and yes, I know it is not as simple when the AD type is a list).

Regards

Marcel

