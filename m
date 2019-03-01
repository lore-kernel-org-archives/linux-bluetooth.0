Return-Path: <SRS0=mQGV=RE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61738C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Mar 2019 18:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BEB20857
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Mar 2019 18:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfCASuT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:50:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:10870 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfCASuT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Mar 2019 13:50:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 10:50:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,428,1544515200"; 
   d="scan'208";a="130397709"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga007.fm.intel.com with ESMTP; 01 Mar 2019 10:50:17 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.145]) with mapi id 14.03.0415.000;
 Fri, 1 Mar 2019 10:50:16 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: RE: [PATCH BlueZ] doc/mesh-api: Fix Attach() method signature
Thread-Topic: [PATCH BlueZ] doc/mesh-api: Fix Attach() method signature
Thread-Index: AQHUz7zUhxJYOKraYkinc+LnmV18UKX3H6sA
Date:   Fri, 1 Mar 2019 18:50:10 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D93ABF5@ORSMSX103.amr.corp.intel.com>
References: <20190228232456.9707-1-inga.stotland@intel.com>
In-Reply-To: <20190228232456.9707-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2E4MWExOWItMTNiMy00NzY3LWJiYzItN2VkOGExNjNlMjg2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiT2QxTXlDMmJtdmM1TGV5UE5CK1cwbUU3M2JNU1krTjhFQkNheWtoRldkem44dStwcCtIdkRcL1wvZDZ3ckgyXC9XKyJ9
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

applied

> -----Original Message-----
> From: Stotland, Inga
> Sent: Thursday, February 28, 2019 3:25 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Gix, Brian <brian.gix@intel.com>; johan.hedberg@gmail.com;
> luiz.dentz@gmail.com; Stotland, Inga <inga.stotland@intel.com>
> Subject: [PATCH BlueZ] doc/mesh-api: Fix Attach() method signature
> 
> Correct return arguments for Attach() method.
> Also, fix some grammar and formatting.
> ---
>  doc/mesh-api.txt | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt index e1bc3ee02..0b341a0f9
> 100644
> --- a/doc/mesh-api.txt
> +++ b/doc/mesh-api.txt
> @@ -1,4 +1,3 @@
> -
> xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
> xxxxxxxxxxxxx
>  BlueZ D-Bus Mesh API description
>  ********************************
> 
> @@ -12,16 +11,16 @@ Methods:
>  	void Join(object app_defined_root, array{byte}[16] uuid)
> 
>  		This is the first method that an application has to call to
> -		become a provisioned node on a mesh network.  The call will
> +		become a provisioned node on a mesh network. The call will
>  		initiate broadcasting of Unprovisioned Device Beacon.
> 
>  		The app_defined_root parameter is a D-Bus object root path
> of
>  		the application that implements org.bluez.mesh.Application1
>  		interface. The application represents a node where child
> mesh
>  		elements have their own objects that implement
> -		org.bluez.mesh.Element1 interface.  The application
> hierarchy
> +		org.bluez.mesh.Element1 interface. The application hierarchy
>  		also contains a provision agent object that implements
> -		org.bluez.mesh.ProvisionAgent1 interface.  The standard
> +		org.bluez.mesh.ProvisionAgent1 interface. The standard
>  		DBus.ObjectManager interface must be available on the
>  		app_defined_root path.
> 
> @@ -34,8 +33,8 @@ Methods:
>  		Cancels an outstanding provisioning request initiated by
> Join()
>  		method.
> 
> -	(object node, array{byte, array{(uint16, dict}} configuration)
> -				Attach(object app_defined_root, uint64
> token)
> +	object node, array{byte, array{(uint16, dict)}} configuration
> +			Attach(object app_defined_root, uint64 token)
> 
>  		This is the first method that an application must call to get
>  		access to mesh node functionalities.
> @@ -58,13 +57,13 @@ Methods:
>  		(see Mesh Node Hierarchy section) and current configuration
>  		settings. The return value of configuration parameter is an
>  		array, where each entry is a structure that contains element
> -		configuration.  The element configuration structure is
> organized
> +		configuration. The element configuration structure is
> organized
>  		as follows:
> 
>  		byte
> 
>  			Element index, identifies the element to which this
> -			configuration entry pertians.
> +			configuration entry pertains.
> 
>  		array{struct}
> 
> @@ -140,7 +139,7 @@ Methods:
>  		be returned.
> 
>  		The data parameter is an outgoing message to be encypted
> by the
> -		meshd daemon and sent on.
> +		bluetooth-meshd daemon and sent on.
> 
>  		Possible errors:
>  			org.bluez.mesh.Error.NotAuthorized
> @@ -308,8 +307,8 @@ Methods:
>  	void MessageReceived(uint16 source, uint16 key_index,
>  					boolean subscription, array{byte}
> data)
> 
> -		This method is called by meshd daemon when a message
> arrives
> -		addressed to the application.
> +		This method is called by bluetooth-meshd daemon when a
> message
> +		arrives addressed to the application.
> 
>  		The source parameter is unicast address of the remote
>  		node-element that sent the message.
> @@ -328,7 +327,7 @@ Methods:
> 
>  	void UpdateModelConfiguration(uint16 model_id, dict config)
> 
> -		This method is called by meshd daemon when a model's
> +		This method is called by bluetooth-meshd daemon when a
> model's
>  		configuration is updated.
> 
>  		The model_id parameter contains BT SIG Model Identifier or,
> if
> --
> 2.17.2

