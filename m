Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 8 Mar 2018 15:26:17 +0100
From: Martin Grothe <martin.grothe@rub.de>
To: linux-bluetooth@vger.kernel.org
Subject: Service Discovery Security
Message-ID: <20180308142617.yqxgphb6i3lr2v54@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
is it standard procedure in Service Discovery of Bluetooth 4.0 and later to first negotiate an authenticated link key and make Service Discovery request over an encrypted channel (with the help of this link key) to the device with the services?

Or does the Service Discovery protocol normaly runs before any link key is derived?

Kind Regards,
Martin

