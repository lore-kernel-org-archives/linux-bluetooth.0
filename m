Return-Path: <SRS0=tQl/=SH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFF5C282CE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 19:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B5B2171F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 19:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="bEecCc9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbfDETDL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:03:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44972 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfDETDL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Apr 2019 15:03:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16so6136025ljg.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2019 12:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ei0F7yrIocZoma9QZT5ROIYHaoa43Q7l4UE1ht1dnNI=;
        b=bEecCc9RschfNSoJlW6UNVEy5MTPy3lJD5wJOnLgqsF8U+MvA31G53owzlPylIw4Ln
         PdWfQONsS1GFRwfSXj+X9i9Y66y4PhDf1GtwrvhC0b0WMbq5Z9YdCjZueQ79hWa/MupW
         IMi5hvVnFVSaK82lzeGa80HBsfDoc+CK4cgtr6uF6YzLWN1Dd3R4SyDA/ffl+doBeo6X
         4EsU530Uxk2FHGpVqRqaIYcGLn0zp+2IVrrNTME83QVc2BOBp+EHoBVmgrJpJxZUmWsw
         w+cIUrl0JHTyB0H2EvWzAyxGOOTtlHADsGoT261d8zfhY0a0vgRDdXr8lE02G4Q6YG8k
         hVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ei0F7yrIocZoma9QZT5ROIYHaoa43Q7l4UE1ht1dnNI=;
        b=ZHHEjMnlMoAvs4Wg5j6ccokSo+/8733JmGU4ffQORMtbJJVJZGOhA1QttP7jePjxwV
         BbHN0Ijnrrd0FS7Un4YDkO1N8xIZqk9LXVJG7gkFIACm2ZpibpS8jNQnmJM1f1cHWYZW
         dceCnEOTgYOV9Fl9EXhm5GeASme93fHw8oAg99XKK0gl2Jd7I+luRj66UGCXAFhdfuC+
         jJA4cqJ2VS3gyVqIC31it+gODUqd0lUPAuex4Hj/Cd8aLvJfYHUYak5FukoepksehOzL
         JOwbJoo0vPaKrdgUCXusbwsTq64fnV9NeoE/77V/ufAAzwRsLZfX0cKrhn4VqbEffTF6
         Fe1Q==
X-Gm-Message-State: APjAAAUvqjpQxbyDioUGsctSkvTmL6q8R07r2OeeTsrExtoCnTERnmmb
        IA4RpjC/sj21tNgJWTA8Klht8g==
X-Google-Smtp-Source: APXvYqyDWRC1vL5hfKT0r+lO52pdvC2BsyMlLz+2NhiLhYvWO+8R7yyuFkhyD+vTMQmqua8tOLLhwg==
X-Received: by 2002:a2e:5bcc:: with SMTP id m73mr7951080lje.100.1554490988673;
        Fri, 05 Apr 2019 12:03:08 -0700 (PDT)
Received: from kynes (apn-77-114-92-43.dynamic.gprs.plus.pl. [77.114.92.43])
        by smtp.gmail.com with ESMTPSA id l15sm4910033ljh.62.2019.04.05.12.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 12:03:07 -0700 (PDT)
Date:   Fri, 5 Apr 2019 21:03:04 +0200
From:   Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ 1/1] mesh: Add APIs for Provisioner and Config
 Client
Message-ID: <20190405190304.swhyog5zefvq37e2@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
References: <20190322225754.27039-1-brian.gix@intel.com>
 <20190322225754.27039-2-brian.gix@intel.com>
 <20190401104213.vpqhgw55leg6olza@scytale>
 <DEBB0CAA2616974FAE35E4B560B9A4376CAE27AA@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4376CAE27AA@ORSMSX103.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

Thanks for the response.

On 04/03, Gix, Brian wrote:
> > Service         org.bluez.mesh
> > Interface       org.bluez.mesh.Network1
> >
> >         uint64 token
> >                 Create(array{byte}[16] uuid)
> 
> We are committed to using the org.freedesktop.DBus.ObjectManager in
> order to create the first Node of a new Mesh, which will require an
> object_path in all places where we have currently put them. This
> initial node must have at a minimum have Configuration Client
> available before it may Provision other nodes and start creating it's
> database of external nodes, by at a minimum requesting new node
> Composition data.
>
> (...)
>
> We also chose to put Join/Cancel/Leave/Create in the Network1
> interface because no "Node" technically exists until provisioning is
> successful. The methods under the Node1 interface are only available
> to applications which have "Attached" using a token.

Ok, but this part of the proposed API is about creating an unprovisioned
node, so object_path is not needed yet.

That being said, you're right that path to the application 'owning' the
node should indeed be mandatory for Provision() and Join() calls, or at
least the application should be required to Attach() itself before
calling these functions.


Main goal in the proposal was splitting node creation into two parts:
registering a node within the daemon, and provisioning it. In the
current API, node starts broadcasting unprovisioned device beacons as
soon as it's created. There are use cases where this is not desirable.

Imagine an existing network provisioned by someone else, for example a
cloud-based application communicating with mesh via a mobile device.

We would like to add a Linux-based device to that network. Since at the
moment it's not possible to provision meshd via PB-GATT (for various
reasons), the most practical option would be to 'self-provision', by
retrieving network keys/address from cloud-based provisioner, and
sending a generated device key back to the cloud, so that freshly
provisioned Linux box can be later managed in the same was as all other
nodes.

To achieve that, we need some kind of API that allows provisioning meshd
locally, ideally via D-Bus.

Another interesting option to achieve that would be to use meshd as
provider of PB-ADV bearer, and do the provisioning dance in the
application. This seems doable, but complicated.

I think meshd should not assume that it's the sole 'owner' of the
network; such an approach severely limits its use cases. As another
example, application keys also may be submitted from the outside,
instead of generating them within the daemon.

> Internally, concern has been expressed for the security of all
> encryption keys used within Mesh. The current design avoids all
> handling of keys (Network, Application and Device keys) outside of the
> Daemon, particularly over the D-Bus interface.

Hm, may I ask why 'particularly over D-Bus'? As far as I understand, the
bus is secure - you cannot eavesdrop messages without proper privileges,
and the daemon authenticates client applications.

Services like NetworkManager doesn't seem to have a problem with
transferring secrets over D-Bus.

Moreover, since the Attach() token already travels through the bus, if a
3rd party can intercept it, they don't even need to extract keys from
the daemon - they can just use the regular API to communicate with the
mesh.

> > I don't think it makes sense to send messages using device keys to non-
> > unicast addresses.
> 
> I don't think this is 100% certain...

The spec explicitly forbids using device key with non-unicast addresses.
See Mesh Profile v1.0.1, section 3.4.3 Address validity, table 3.6.

> Most of your recommendation directly affect the security of the Keys,
> and whether they get passed via D-Bus...  And this is something that I
> would *not* do without the OK from Marcel Holtmann, and I am inclined
> to believe this assent will probably not happen, for reasons stated,
> and that I agree with.

Could you please point me to the relevant thread? I know I'm late to the
party and would very much like to catch up, as much as I can.

cheers
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
