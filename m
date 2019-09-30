Return-Path: <SRS0=G1Nt=XZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0573BC4360C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 07:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78F821855
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 07:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="TSuUwLMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfI3HSJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Sep 2019 03:18:09 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:39471 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfI3HSJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Sep 2019 03:18:09 -0400
Received: by mail-wm1-f51.google.com with SMTP id v17so11409315wml.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2019 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rYAWPI3+FlriByB8hDT1uX4JyeJ2IPx16AmGX8G1sRo=;
        b=TSuUwLMZ73+OXWTHGl/K6LRojTFmEF+BACZqAIiLknZIpsYKRSpne8GBW5m4slKkK5
         IjyVtnskbPA2OPC0+G2tu/d7s/xFqGLofTCM9zUnQ84BYEGUWBpCjmtDB7AiH9RdXiSI
         I4AQis3n6EpAbmDzKUx+TUPINXyagcAzfXq0gjmRG3LRHezQEze0bPiQyRwiN2mOxSHB
         sYhv1r3LXSWBXFEv/qiKczjzSPokrsul3kqioRt/F+Ngmp2tDnSfcN9tu6bDSU4yv7Fk
         JlTtA/6QXLznCTDs22ditWg5DU+O7KcomqTgaQPz97X5Z3+W2LE+/1ICPW7pFwwZXENX
         viAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rYAWPI3+FlriByB8hDT1uX4JyeJ2IPx16AmGX8G1sRo=;
        b=J1aqD1HsfoV2QjoCVsj5xl61mt7aMXu9U7BMfk7/9xBEyfHrtlBpAdpu4FnrZPuxj2
         OZ0nvfnjUpBZE/5T5q7HF3/ra17K4K5+Lij9Jz+1KFFLWX/1FFrKYXpTFZpkl4+kchYa
         d5S+8Niclz+7+cceVxV4/EIx62oc2D4zu4gGEFs5ahqjHkfDKq6OV9IxxFKmrJ7OZV9/
         LG1WK/nNrWN8PBNCarkjNj3LSyBHl5M+Qg9dYBKQ1ILrCFGcbJFDSUUXzfiPnIzyE3Ow
         wg15n7tmuazzL70fjk493cztLjFR9PozRKY1fB8mjSmPkTH++SaoUIxh3e92nclSvWXM
         kRoQ==
X-Gm-Message-State: APjAAAU8TY81xeDifYY3MzCBzTuLGOz7N5/SHcp+LZLf65EdBwIXXrPg
        fMmoKR31QLJOgGQqqgznconREQ==
X-Google-Smtp-Source: APXvYqxmbcj4hBphmKF4X18dubixGEW47J8l0str9hamFvrhN2K7O9Wc5rXRlwjf87w5Mi6tTAIRXg==
X-Received: by 2002:a7b:cb08:: with SMTP id u8mr16886056wmj.6.1569827886245;
        Mon, 30 Sep 2019 00:18:06 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id u83sm27846957wme.0.2019.09.30.00.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 00:18:05 -0700 (PDT)
Date:   Mon, 30 Sep 2019 09:18:03 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Message-ID: <20190930071803.nvp3ema26ynuiwz3@mlowasrzechonek2133>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
 <20190918085239.xhahxoeqjkcrk3bl@mlowasrzechonek2133>
 <3c5858c94b3e08a61c5ff8493f9b00f5f77d0aac.camel@intel.com>
 <4b57242b15ccb44ac123858ce7bdf6e0e526b3e0.camel@intel.com>
 <a0442c7485fef2bfde9bc52283a5c9dfc0b43515.camel@intel.com>
 <20190927085208.sxy2x5656ci3opo6@mlowasrzechonek2133>
 <01c84f55db98fbcc2790d11fd6090589881c36cf.camel@intel.com>
 <856d4e6bfdbe84b7b7ac3742ebede263c7801346.camel@intel.com>
 <86e707237937cfb5c4e8fea8e96924f4590ab0a3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86e707237937cfb5c4e8fea8e96924f4590ab0a3.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian, Inga,

On 09/27, Gix, Brian wrote:
> > For a single MessageReceived() method, the cleanest way is to have the
> > subscription address parameter as a variant (suggested by Michal) or as
> > a dictionary.
> > An array introduces an extra consideration of byte ordering for group
> > addresses.
> 
> If variants are easy to sort in scripting languages like python3, than I
> suppose I could live with this.

Last time I checked, it was C that had issues with  any type of
'dynamic' typing, so I wouldn't worry about client languages. Handling
D-Bus variants in python is trivial.

> Or is this still a two step process of:
> 1. Determining the u16 vs u128
> 1.1 unmarshalling the correct type...
> 
> What would the signature of the method look like?

Something like this:

	void MessageReceived(uint16 source, uint16 key_index,
					 variant destination, array{byte} data)

and on the Python side, the handling would look somewhat like this
(since Python doesn't do overloading, at all):

class ElementInterface:
	def MessageReceived(source, key_index, destination, data):
	    if type(destination) == dbus.types.UINT16:
	        group_destination = destination
	    elif type(destination) == dbus.types.ARRAY:
	        virtual_destination = uuid.UUID(destination)
	    else:
	        raise DBusError('Unrecoenized destination type')

> > What I mostly about is that the represenation of the subscription
> > address in the MessageReceived() method corresponds to the
> > representation in the configuration dictionaries for the Attach() and
> > UpdateModelConfiguration() methods.

Agreed.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
