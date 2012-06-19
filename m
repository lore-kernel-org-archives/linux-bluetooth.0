Return-Path: <cyrus@holtmann.org>
From: "Zhang, Jingke" <jingke.zhang@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: BT DUN Server fails to work (seems blocked in RFCOMM)
Date: Tue, 19 Jun 2012 09:11:46 +0000
Message-ID: <8C91AD8ED4077A4786B341540858992510269B2E@SHSMSX102.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
Does any guys try DUN server with bluez? 

My telephone stack is ofono and its DUN server code should be ready in its commit. However, the problem is my DUN activation request almost did not come to ofono side (only to bluez RFCOMM). On the DUN Client, I can use same validation step to active a mobile phone (Sony-Ericson C905) to connect to 2G/3G network. 

I filed a bug https://bugs.meego.com/show_bug.cgi?id=25303 to track all logs. 

Could you help to see what's the problem? 

Thanks 
Jingke
