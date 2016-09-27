Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: LE scatternet?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <e29c33a0fc8b91a7bb2d5f7d56ad736a@be408.mail.saunalahti.fi>
Date: Tue, 27 Sep 2016 17:23:25 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2E71111C-A8AF-495D-A584-7457AFCBE5B9@holtmann.org>
References: <e29c33a0fc8b91a7bb2d5f7d56ad736a@be408.mail.saunalahti.fi>
To: jukka.oravasaari@saunalahti.fi
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> I have a question regarding Bluez support of Low-Energy Topologies that were introduced in Bluetooth Core Spec v4.1 (chapter 4.1.2 LE Topology). LE Link Layer Topology is a category 3 feature and thus it requires support in controller. Bluetooth Core Spec v4.0 added command LE Read Supported States for host to be able to query states and state combinations supported by the controller. There seems to be some hard-coding in recent kernel code assuming controller not to support certain states. Do you have plans to make this dynamic and thus to enable LE scatternet functionality allowing also parallel GATT central and peripheral functionality? By searching the archive I found  following thread but I would like to know the current status. Thanks.

we have some historic dependencies, but I am all for removing them and more actively engaging multiple link-layer state machines if the controller supports them.

Regards

Marcel

