Return-Path: <SRS0=YUNQ=SD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFC3C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 10:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694AE2086C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 10:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="YU/xDjgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDAKmU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:42:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36205 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfDAKmU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Apr 2019 06:42:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id d18so5915251lfn.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2019 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B10j5LOrwPuwORL3svWjjIe48k3jsuC3dJab+NCrnms=;
        b=YU/xDjgynyn5anRQ2SfyPitCgZQLMh1TLlUzI9KEQvNffXEoPXn3FKpoTSVJs9UkQF
         DhbjdJ/Z3Riv50JyuM4VTzYZaQMT7XMO5rD48a4hHVIurekJy7DcnPRjLhmvzFith+r1
         i2BB+5kV8PJ8BCjPIN6P23SV5KwcVYH9FxZYLK2A8bC2T0z3AQPyrfxmokwP9eG/ShdT
         FfVKhQothBZ/w6516A8pdfPX5SJP/IYAnsBN9P62urt8lbxFDvbFM87IoHeKBbdbjveW
         qy9M7sJ/fgIJVZa/FS6rItW+PL5S1NL9xIgXoD77oGDddVXMDolkZNNZrQoofzyLPN8n
         10mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=B10j5LOrwPuwORL3svWjjIe48k3jsuC3dJab+NCrnms=;
        b=emQRnfuS895MR9S2H1u30Ew7Bz+8uFD7SwnVc66V5/2hQh+iAxctloifi1lADqguyP
         wnAVtfc8Wbb0SlUNCO1OAzHkgUDRAydupmKSDhGKfciyczX9euMAYFtqRhB4S4ndspJs
         rEXIPJgyq55UOpIHI9+57aRaSCsFRVNqVZ0G1TN1xkNJyKUO1dRTsl/I6nUolvSuTWQa
         KyIudg1UhMXJ9PKgwZFE9twQnb3yKSCopAHUcoWtKTVvfF9Q5a2UGAuAnDGbsZTlB2oy
         YzTGVwuu+jgxTH+nS6RmLQsSn1N3fsg+n61zfgtFr/OHWgY1PjomM8sDF026mSCdfD1K
         L62g==
X-Gm-Message-State: APjAAAWfbOg3sLvCORSAgaGKKozPlbj4Wev8YgB4YZS5BYc4pGehgNo7
        6ztw8OoNOa23A+5Crv3gqlwDpA==
X-Google-Smtp-Source: APXvYqyCDJijbDw3F5pV3ZTx1MnoQb/FWymvirE03UljnniOd/227+pmVKqA03gKYA3ZGmscIiBRjA==
X-Received: by 2002:a19:48d5:: with SMTP id v204mr33903610lfa.70.1554115337400;
        Mon, 01 Apr 2019 03:42:17 -0700 (PDT)
Received: from scytale ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id k25sm2014819ljc.14.2019.04.01.03.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:42:16 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@scytale>
Date:   Mon, 1 Apr 2019 12:42:13 +0200
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com,
        marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com
Subject: Re: [PATCH BlueZ 1/1] mesh: Add APIs for Provisioner and Config
 Client
Message-ID: <20190401104213.vpqhgw55leg6olza@scytale>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com,
        marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com
References: <20190322225754.27039-1-brian.gix@intel.com>
 <20190322225754.27039-2-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190322225754.27039-2-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

A couple of comments regarding device key management and local/remote
provisioning flow in general.


On 03/22, Brian Gix wrote:
> +	uint64 token CreateNetwork(object app_root, array{byte}[16] uuid)
> +
> +		This is the first method that an application calls to become
> +		a Provisioner node, and a Configuration Client on a newly
> +		created Mesh Network.

What if I would like my node to act as a Config Client without being a
provisioner? In our application, nodes can obtain network details from a
remote storage, so you don't need to be the one provisioning the network
in order to have access to device keys.

I think we should distinguish creating a node within meshd and
provisioning it, as there are a couple of ways to provision a new node:

 - the node can advertise itself as unprovisioned device, waiting for
   PB-ADV
 - the node can advertise itself as a connectable, exposing PB-GATT
   service
 - the node might not want to advertise at all, and provision itself
   "out of band", getting provisioning information from a remote
   database

The 3rd option is of particular concern for new networks, and also
automatically adding devices to existing ones.

Because of that, I think we should rather split the
'org.bluez.mesh.Network1.Join' method into something like:


Mesh Network Hierarchy
======================
Service         org.bluez.mesh
Interface       org.bluez.mesh.Network1
Object path     /org/bluez/mesh

Methods:
        uint64 token
                Create(array{byte}[16] uuid)

            This is the first method that an application has to call to
            become a provisioned node on a mesh network. The call will
            allocate resources for the new node within the mesh daemon.

            The token parameter serves as a unique identifier of the
            particular node. The token must be preserved by the application
            in order to authenticate itself to the mesh daemon and attach to
            the network as a mesh node by calling Attach() method or
            permanently remove the identity of the mesh node by calling
            Remove() method.

            The created node is initially idle, particularly it doesn't 
            initiate broadcasting of Unprovisioned Device Beacon.

            (...)

        void Remove(uint64 token)

            This removes the configuration information about the mesh node
            identified by the 64-bit token parameter. The token parameter
            has been obtained as a result of successful Create() method call.


The application (after calling Attach) can then proceed to either
provision the node itself, or let it broadcast Unprovisioned Device
Beacons:


Mesh Node Hierarchy
===================
Service         org.bluez.mesh
Interface       org.bluez.mesh.Node1

        void Provision(array{byte}[16] network_key, uint16_t address)

            This call will add an unprovisioned local node to a given
            network, using provided primary unicast address.

        void Join(void)

            The call will initiate broadcasting of Unprovisioned Device
            Beacon.

            If regular bluetoothd is available on the system bus, mesh
            daemon will also register itself as a GATT application,
            providing PB-GATT service.

        void Cancel()

            Cancels an outstanding provisioning request initiated by Join()
            method.


After provisioning, the application will then receive freshly generate
device key, so that it can be stored externally.


Mesh Application Hierarchy
==========================
Service         unique name
Interface       org.bluez.mesh.Application1
Object path     <app_defined_root>

        void JoinComplete(array{byte}[16] device_key)


Having the application aware of the device key of a local node would
also mean that we could get rid of magic 0x7fff index for device key in
Send() call. Instead, we could provide two separate calls for
application-level and device-level security:

void SendWithApplicationKey(object element_path, uint16 destination,
                                uint16 key_index, array{byte} data)

void SendWithDeviceKey(object element_path, uint16 destination,
            					array{byte}[16] device_key, array{byte} data)

>  Mesh Node Hierarchy
>  ===================
> @@ -146,6 +178,88 @@ Methods:
>  			org.bluez.mesh.Error.InvalidArguments
>  			org.bluez.mesh.Error.NotFound
>  
> +	void SendWithDeviceKey(object element_path, uint16 destination,
> +					uint16 net_index, array{byte} data)
> +
> +		This method is used to send a message originated by a local
> +		model encoded with the device key of the remote node.
> +
> +		The element_path parameter is the object path of an element from
> +		a collection of the application elements (see Mesh Application
> +		Hierarchy section).
> +
> +		The destination parameter contains the destination address. This
> +		destination must be a uint16 to a unicast address, or a well
> +		known group address.

I don't think it makes sense to send messages using device keys to
non-unicast addresses.

Also, since mesh daemon might not be the one who originally provisioned
device we would like to communicate with, I think this method should
accept the device key as an argument, moving key management duties to
the application.

Also, because it's not possible to configure publications using a device
key, I think device keys make sense only in case of unicast *requests*.
As far as I understand the mesh architecture, such responses are the
only case where we are receiving messages encrypted with remote node's
device key.

Therefore, I think the mesh daemon might want to retain the device key
passed to SendWithDeviceKey call for a certain time period, in order to
process these response.

This would also mean that this call:

> +	void AddNode(array{byte}[16] uuid)
> +
> +		This method is used by the application that supports
> +		org.bluez.mesh.Provisioner1 interface to add the
> +		unprovisioned device specified by uuid, to the Network.
> +
> +		The uuid parameter is a 16-byte array that contains Device UUID
> +		of the unprovisioned device to be added to the network.

should return generated device key back to the caller, so that it can
store the device key for later use, and/or send it to the remote
storage, so that other config clients can retrieve/use them.

All of that relieves the mesh daemon from keeping the network database,
and gives us certain symmetry in the API wrt local vs. remote nodes.

What do you think?

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
