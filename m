Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Alex Coplan <alex.coplan@starleaf.com>
Content-Type: text/plain; charset=us-ascii
Subject: LE Advertising API: supported options for RegisterAdvertisement
Message-Id: <B54B2641-A4CF-4C92-BE25-4B72CBEC5355@starleaf.com>
Date: Mon, 1 Aug 2016 20:41:19 +0100
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

The documentation for the D-Bus interface org.bluez.LEAdvertisingManager1 documents the method RegisterAdvertisement with the prototype:

RegisterAdvertisement(object advertisement, dict options)

but does not specify which options are supported. It would be great if this were documented; in particular, I would be interested to find how to change the advertising interval through this API.

Any advice would be really appreciated.

Regards,
Alex