Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 27 Sep 2016 17:54:56 +0300
From: jukka.oravasaari@saunalahti.fi
To: linux-bluetooth@vger.kernel.org
Subject: LE =?UTF-8?Q?scatternet=3F?=
Message-ID: <e29c33a0fc8b91a7bb2d5f7d56ad736a@be408.mail.saunalahti.fi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bluez-developers!

I have a question regarding Bluez support of Low-Energy Topologies that 
were introduced in Bluetooth Core Spec v4.1 (chapter 4.1.2 LE Topology). 
LE Link Layer Topology is a category 3 feature and thus it requires 
support in controller. Bluetooth Core Spec v4.0 added command LE Read 
Supported States for host to be able to query states and state 
combinations supported by the controller. There seems to be some 
hard-coding in recent kernel code assuming controller not to support 
certain states. Do you have plans to make this dynamic and thus to 
enable LE scatternet functionality allowing also parallel GATT central 
and peripheral functionality? By searching the archive I found  
following thread but I would like to know the current status. Thanks.

http://marc.info/?l=linux-bluetooth&m=141777346308734&w=2

Best regards,
Jukka

