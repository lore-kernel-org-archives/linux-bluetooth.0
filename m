Return-Path: <cyrus@holtmann.org>
Subject: RE: To enablue DID in coming bluez release
From: Marcel Holtmann <marcel@holtmann.org>
To: "Li, Zhigang" <zhigang.li@intel.com>
Cc: Johan Hedberg <johan.hedberg@nokia.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Zhao, Forrest" <forrest.zhao@intel.com>
In-Reply-To: <B94C62E7C2870743865418621F040C1303B81154@pdsmsx502.ccr.corp.intel.com>
References: <B94C62E7C2870743865418621F040C1303A6354C@pdsmsx502.ccr.corp.intel.com>
	 <1229046931.22285.30.camel@violet.holtmann.net>
	 <B94C62E7C2870743865418621F040C1303A640A8@pdsmsx502.ccr.corp.intel.com>
	 <B94C62E7C2870743865418621F040C1303B80AB8@pdsmsx502.ccr.corp.intel.com>
	 <20081216102928.GA12914@localhost> <1229481492.10889.1.camel@violet>
	 <B94C62E7C2870743865418621F040C1303B80C87@pdsmsx502.ccr.corp.intel.com>
	 <1229543953.10889.16.camel@violet>
	 <B94C62E7C2870743865418621F040C1303B81154@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain
Date: Fri, 19 Dec 2008 20:01:35 +0100
Message-Id: <1229713295.879.12.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhigang,

please stop top-posting. This is an open source mailing list and we do
bottom posting and inline quoting.

> If USB Vendor ID and Bluetooth Vendor ID are both exist which one you prefer in DID? We can't add both right?

Default is Bluetooth since we are doing Bluetooth here and not USB. USB
would need a specific prefix. So I prefer usb:1223:1233:1223 for
indicating USB ids and without we default to Bluetooth. Care to send a
patch for it.

Regards

Marcel


