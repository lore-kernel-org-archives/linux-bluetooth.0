Return-Path: <cyrus@holtmann.org>
Subject: Re: using management interface from WiFi driver
From: Marcel Holtmann <marcel@holtmann.org>
To: "Sumangala, Suraj" <surajs@qca.qualcomm.com>
Cc: "Johan Hedberg (johan.hedberg@gmail.com)" <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 01 Sep 2011 04:36:52 -0700
In-Reply-To: <480687D4EEFE7447A2E09AADFF6673621AF82890@nasanexd02a.na.qualcomm.com>
References: <480687D4EEFE7447A2E09AADFF6673621AF82890@nasanexd02a.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314877014.3373.280.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> I am working on a Bluetooth -WiFi coex mechanism in our WiFi kernel driver which would like get information regarding certain ongoing Bluetooth operations to manage BT-WiFI shared resources.
> Some of the operations we are interested are inquiry status, SCO, A2DP streaming status.
> 
> Is there any API exported by the management interface that I can call in my WiFi device driver so as to get information like "Is SCO connected?" or "Is inquiry going on?" etc?

let me stop you right here. I thought that I made this perfectly clear
on linux-wireless. Any coex handling between WiFi and Bluetooth will be
done from mac80211 to Bluetooth subsystem in the kernel. And not via
userspace tools.

Regards

Marcel


