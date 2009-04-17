Return-Path: <cyrus@holtmann.org>
From: "Xu, Martin" <martin.xu@intel.com>
To: "connman@moblin.org" <connman@moblin.org>
CC: "Yin, Kangkai" <kangkai.yin@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Liu, Bing Wei" <bing.wei.liu@intel.com>,
	"Gao, Bin" <bin.gao@intel.com>
Date: Fri, 17 Apr 2009 09:47:49 +0800
Subject: RE: [connman] CreatDevice signal should be emitted at	function
	create_stored_device_from_profiles() in src/adapter.c
Message-ID: <9F0C1DB20AFA954FA1DA05309350433D5B2E8031@pdsmsx503.ccr.corp.intel.com>
References: <49D1FE96.1090200@binarywings.net>
	<2d5a2c100903310644od9cbf69ma2c28c83b7e51@mail.gmail.com>
	<49D30FD8.9020506@binarywings.net> <49D45501.8030606@binarywings.net>
	<2d5a2c100904021028g78376debke885916eba13cf93@mail.gmail.com>
	<49E5F2BE.1040808@binarywings.net>
	<9F0C1DB20AFA954FA1DA05309350433D5B2E7CEF@pdsmsx503.ccr.corp.intel.com>
	<2d5a2c100904160631o30384806td1b5750669466fce@mail.gmail.com>
 <9F0C1DB20AFA954FA1DA05309350433D5B2E7F5F@pdsmsx503.ccr.corp.intel.com>
In-Reply-To: <9F0C1DB20AFA954FA1DA05309350433D5B2E7F5F@pdsmsx503.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>I know the way you mentioned, but this way has some issue. You know there is >a time interval between AdapterAdded and DeviceCreated. 
I found that the time interval on my machine is about 230 milliseconds. The time is enough to schedule out to other process to handle the AdapterAdded signal.
_______________________________________________
connman mailing list
connman@moblin.org
https://lists.moblin.org/mailman/listinfo/connman
