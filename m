Return-Path: <cyrus@holtmann.org>
From: Ankur Patel <ankur@embertec.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 1 Jun 2015 19:07:57 +0930
Subject: Need advice on Gatt Client with services/characteristics 
Message-ID: <BD5E516FF3711A41B93DC005170007BB010E5DB58389@EMBSVR01.ember.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Folks,

I am looking for suggestions for any examples available in bluez source of GATT client having implementation for service and characteristics of its own. I am aware of btgatt-server.c which has services/characteristics. I tried porting them to btgatt-client.c but seems bit complex. Even I glanced over btsensor code under git/peripheral, but found to be using mgmt API's rather than bt_gatt client/server API's available.  Working to pass testcases TC_SEC_AUT_BV_12_C and TC_SEC_AUT_BV_16_C. 

I just would like to know if it's the right approach or I have to look into something else?  

Regards,
Ankur.

NB: I have started working on creating script for PTS s/w for Linux as Controller. It's in progress but I will share on forum once completed. http://pastebin.com/w4gLcKCT (GAP Profile)
