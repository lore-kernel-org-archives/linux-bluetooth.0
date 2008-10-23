Return-Path: <cyrus@holtmann.org>
Subject: Re: how to set passkey in bluez4.X
From: Marcel Holtmann <marcel@holtmann.org>
To: "Li, Zhigang" <zhigang.li@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <722F286E5CF54C459DDA462B750B07CE0C1EC83506@pdsmsx502.ccr.corp.intel.com>
References: <722F286E5CF54C459DDA462B750B07CE0C1EC83506@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain
Date: Thu, 23 Oct 2008 06:45:36 +0200
Message-Id: <1224737136.9386.162.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhigang,

> Could somebody know how to set passkey in bluez4.X?
> 
> In Bluez3.X we can set it in hcid.conf and I tried set passkey in main.conf
> 
> I added the passkey at the end of this file. Passkey = "1234"
> 
> But it doesn't work.

having pin codes in a config file is wrong and insecure. You have to
have a BlueZ agent running to answer pin requests.

Regards

Marcel


