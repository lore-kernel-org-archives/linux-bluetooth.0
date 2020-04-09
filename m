Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313C7C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECD720757
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 18:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgDISFz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:05:55 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50076 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDISFz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 14:05:55 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 11D06CECFD;
        Thu,  9 Apr 2020 20:15:29 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/5] D-Bus API changes for managing SDP records
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200401221434.12185-1-sonnysasaka@chromium.org>
Date:   Thu, 9 Apr 2020 20:05:53 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Rahul Chaturvedi <rkc@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <ACB5D50F-BAD5-435A-AD1C-58A16878C310@holtmann.org>
References: <20200401221434.12185-1-sonnysasaka@chromium.org>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> This defines the DBus API that we'll use with BlueZ to create, remove
> and get service records.
> ---
> doc/adapter-api.txt | 46 +++++++++++++++++++++++++++++++++++++++++++++
> doc/device-api.txt  | 37 ++++++++++++++++++++++++++++++++++++
> 2 files changed, 83 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index acae032d9..6e4c37fc9 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -204,6 +204,52 @@ Methods		void StartDiscovery()
> 					 org.bluez.Error.NotReady
> 					 org.bluez.Error.Failed
> 
> +		uint32 CreateServiceRecord(dict record)
> +
> +			This method creates an entry with the local SDP server
> +			for this adapter for the specified record. This method
> +			will only create the SDP record and not start listening
> +			on any ports. It is up to the caller of the method to
> +			ensure the validity of the service record. This record
> +			will not be parsed for any validation but will instead
> +			directly be inserted into the local SDP server’s
> +			records.
> +
> +			The return value from this method will be the 32 bit
> +			handle for the created service record.
> +
> +			The record dictionary will have dictionary entries of
> +			the format: {id : (type, size, value)}, where,
> +
> +			uint16 id:	The 16 bit attribute ID for an
> +					attribute.
> +			uint8 type:	This will contain the type of the
> +					attribute value. Attribute type values
> +					are defined in the Bluetooth spec in
> +					Volume 3, Part B, 3.2.
> +			uint32 size:	This is the size of the attribute
> +					value.
> +			variant value:	This will contain the attribute value
> +					for a given attribute_id. This variant
> +					can either contain a primitive type, or
> +					if type is SEQUENCE, an array of struct
> +					of the signature (type, size, value).
> +
> +			Possible errors: org.bluez.Error.NotReady
> +					 org.bluez.Error.AlreadyExists
> +					 org.bluez.Error.Failed
> +					 org.bluez.Error.InvalidArguments
> +
> +		void RemoveServiceRecord(uint32 handle)
> +
> +			This method removes the SDP record with the given
> +			handle from the local SDP server.
> +
> +			Possible errors: org.bluez.Error.NotReady
> +					 org.bluez.Error.DoesNotExist
> +					 org.bluez.Error.Failed
> +					 org.bluez.Error.InvalidArguments
> +

so when design the BlueZ 5.x APIs, we on purpose didn’t do this. You are suppose to use doc/profile-api.txt for these kind of things.

I am not in favor of dangling SDP records where we have no lifetime guarantee of the service behind it.

If you look at profiles/iap/main.c then you see how you could write a vendor profile just as easily. That one is the skeleton for iOS accessory protocol over Bluetooth.

> Properties	string Address [readonly]
> 
> 			The Bluetooth device address.
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index ceb68d2f6..e8f2c670d 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -120,6 +120,43 @@ Methods		void Connect()
> 			Possible errors: org.bluez.Error.DoesNotExist
> 					 org.bluez.Error.Failed
> 
> +		array{array{dict}} GetServiceRecords()
> +
> +			This method returns the complete service records of all
> +			discovered BR/EDR services of the connected device till
> +			now. The return value will be an array of an array of
> +			dictionary entries. Each nested array of dictionary
> +			entries will contain one service record. Each pair in
> +			the returned dictionary entries will represent an
> +			attribute in the service record.
> +
> +			The dictionary entries in the returned array of entries
> +			will be of the format: {id : (type, size, value)} where,
> +
> +			uint16 id:	The 16 bit attribute ID for an
> +					attribute.
> +			uint8 type:	This will contain the type of the
> +					attribute value. Attribute type values
> +					are defined in the Bluetooth spec in
> +					Volume 3, Part B, 3.2.
> +			uint32 size:	This is the size of the attribute
> +					value.
> +			variant value:	This will contain the attribute value
> +					for a given attribute_id. This variant
> +					can either contain a primitive type, or
> +					if type is SEQUENCE, an array of struct
> +					of the signature (type, size, value).
> +
> +			Since the service record contains the service UUID and
> +			name, these fields do not need to be given separately.
> +			This method should be called after the ServiceResolved
> +			property for this object has been set to true otherwise
> +			it may return a partial or stale cached list.
> +
> +			Possible errors: org.bluez.Error.NotReady
> +					 org.bluez.Error.NotConnected
> +					 org.bluez.Error.Failed
> +

These two things are not related and do not belong in the same patch. However what is your goal behind this API since even here we tried not to give raw SDP to the application. It is all baked into the Profile API.

Regards

Marcel

