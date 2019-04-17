Return-Path: <SRS0=DUSx=ST=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A1CC10F12
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Apr 2019 05:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D948A20835
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Apr 2019 05:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="sPXmx8YH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfDQFvj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:51:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36278 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfDQFvi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Apr 2019 01:51:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id u17so17898761lfi.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2019 22:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9RrPbM4P7rTk+ASxuWQtUNCk66bGsR4+F4v1wsjPaiM=;
        b=sPXmx8YHQqU+rZDcJrvfp8WKm/2m9ZUQm6Zq64cgMoh51TeKej5Ikm2ffntElfD2x2
         hU/DDLCjSvNEzpwE03NzCbI/cvep8Q5vq/y/E6AlVBN81j+qrOioZvVCM18aiyXei32w
         Yr3J/HmtdvFD6PUnvsY18BHvKd1HcPQ3kN7eC1FB8+jtQwZLGokbGIMY4iGMOVUTzv9O
         Cu/H4R+6YKSq+zQuGPpT4ALuiphyxru4pWjSSVtDdwlDq/aH1S0FtoP8AEuJjQi3bM8B
         zhs9q7BwOeO+2rcj48q/5Bepb4Z8VzYRUqjQmC+PThdBfTLg86MIwRR2NWS01KRqeaAa
         0anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9RrPbM4P7rTk+ASxuWQtUNCk66bGsR4+F4v1wsjPaiM=;
        b=UfD3rMBzz5ETdexZG/MXC3wbsZb+OhGvq136/DbsWtMh2I3e3EkD/9/1rZravh8i32
         j+65BOaUU+1Xq5VIj+8brR2AqeSgYreNNnXyR6r5w744K34osapPrBYi4qIPQ31GEEyG
         rc6YKCRGlCESSAx8f56h1RBhfH4M1IyEcpg3tJBHso5UI1Q8HQCxaUuUGMdQySRqbKoI
         RDHMAKa1AnqvsbaFfKlUDHfPHafO8Sd5H4pjgCbfwve0w20f6tg29R7mrBEInC+b7wZz
         nWwdqh63zbEFpfiGLecn6UZfIcUYhQjhyTWxC7YR4rd+T/DPNWKfwJKTX5AaAm5z/sKi
         nqFA==
X-Gm-Message-State: APjAAAWmcVbOmwsdT8kEoq1B+A+ihuMg8B2YgE1dyrT5PvwfZuQX+RdX
        XNs9AMbpNBRAPvtdkTKyx6aApQ==
X-Google-Smtp-Source: APXvYqxjL5Py3nOii9HCUanVwcfd9m7dDWnxNErntIYAvev3uVKc5j4Na+NqlbutktRZ5/lFjswCUw==
X-Received: by 2002:ac2:5505:: with SMTP id j5mr10425234lfk.121.1555480296068;
        Tue, 16 Apr 2019 22:51:36 -0700 (PDT)
Received: from kynes (apn-31-2-19-253.dynamic.gprs.plus.pl. [31.2.19.253])
        by smtp.gmail.com with ESMTPSA id q12sm3415599lfa.37.2019.04.16.22.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 22:51:35 -0700 (PDT)
Date:   Wed, 17 Apr 2019 07:51:32 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com,
        marcel@holtmann.org, johan.hedberg@gmail.com
Subject: Re: [PATCH BlueZ v5 1/1] mesh: Add APIs for Provisioner and Config
 Client
Message-ID: <20190417055132.scxvzhusx2suasdv@kynes>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com,
        marcel@holtmann.org, johan.hedberg@gmail.com
References: <20190415194946.13121-1-brian.gix@intel.com>
 <20190415194946.13121-2-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190415194946.13121-2-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

First of all, thank you for taking my comments into consideration!

On 04/15, Brian Gix wrote:
> +	 uint64 token ImportLocalNode(string config_file)

I am somewhat uncomfortable with passing a file path here. The caller
would need to create a temporary file, which is a little cumbersome, and
might fail if the daemon is running on another machine.

Not sure what are the size constraints (if any), but I think it might be
better to pass the JSON as a string.

> +	void AddNetKey(object element_path, uint16 destination,
> +			uint16 subnet_index, uint16 net_index, boolean update)
> (...)
> +	void AddAppKey(object element_path, uint16 destination,
> +			uint16 app_index, uint16 net_index, boolean update)

If I understand correctly, these are convenience functions for
SendWithDeviceKey, so that the application wouldn't need to construct
access payloads for configuration messages?

If so, I guess we will need more functions like that, ideally to cover
all messages mentioned in section 4.3.4 of the mesh profile?

I would suggest a few things:
 - name these functions in the same way as the corresponding message
 - possibly extract these into org.bluez.mesh.ConfigClient1 and
   org.bluez.mesh.HealthClient1 interfaces, so that we don't need to
   name functions "ConfigAppKeyApp", just "AppKeyApp"
 - possibly add corresponding "* Status()" calls to application
   hierarchy; see the question below about DevKeyMessageReceived

> +	void ImportRemoteNode(uint16 primary, uint8 count,
> +					array{byte}[16] device_key)
> +
> +		This method is used by the application to import a remote node
> +		that has been provisioned by an external process.
> +
> +		The primary parameter specifies the unicast address of the
> +		the node being imported.
> +
> +		The count parameter specifies the number of elements that are
> +		assigned to this remote node.
> +
> +		The device_key parameter is the access layer key that will be
> +		will used to decrypt privledged messages from this remote node.
> +
> +		PossibleErrors:
> +			org.bluez.mesh.Error.InvalidArguments
> +

> +	void DeleteRemoteNode(uint16 primary, uint8 count)
> (...)
> +		The count parameter specifies the number of elements that were
> +		assigned to the remote node.

Do we need the count here? I think the daemon knows that already.

> +	void SendWithDeviceKey(object element_path, uint16 destination,
> +					uint16 net_index, array{byte} data)
> +
> +		This method is used to send a message originated by a local
> +		model encoded with the device key of the remote node.
> (...)
> +	void DevKeyMessageReceived(uint16 source, uint16 net_index,
> +							array{byte} data)
> +
> +		This method is called by meshd daemon when a message arrives
> +		addressed to the application, which was sent with the remote
> +		node's device key.

Correct me if I'm wrong, but it seems that these two are not required to
support foundation models?

IIRC, requests coming into the daemon from a remote Config Client are
handled internally and then passed to the application via
UpdateModelConfiguation() and friends, while outgoing requests are to be
handled by AddNetKey(), etc.?

On the other hand, nodes might implement vendor models using device
security, so I guess these functions are meant for this use case?

Also, I would suggest a small rename to keep things a bit more
consistent:
 - if SendWithDeviceKey(), then 'MessageReceivedWithDeviceKey()
 - if DevKeyMessageRedeived(), then 'DevKeySend()

but in general, I'd rather rename the original Send/MessageReceived, so
that we end up with:
 - SendApplicationMessage + ApplicationMessageReceived
 - SendDeviceMessage + DeviceMessageReceived
 - SendControlMessage + ControlMessageReceived (but I don't see a need
   to expose this to application, at least not at the moment)


regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
