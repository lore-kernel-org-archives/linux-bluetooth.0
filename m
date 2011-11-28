Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 9/9] Bluetooth: Support LE-Only discovery procedure
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B02641649D@DNCE02.ent.ti.com>
Date: Mon, 28 Nov 2011 11:51:23 -0300
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <34209971-D1E6-4C56-A806-E060073D6D56@openbossa.org>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org> <1322265226-6404-10-git-send-email-andre.guedes@openbossa.org> <F0070FBC0FB3174D8D11444EB2D5B02641649D@DNCE02.ent.ti.com>
To: "Ganir, Chen" <chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Nov 27, 2011, at 3:44 AM, Ganir, Chen wrote:

> Do we really need this kind of functionality ? The GAP spec defines how a single mode/dual mode devices should search for devices. In addition, the kernel has all the knowledge required to decide which of the GAP spec device discovery procedures to use, so why bother the bluetoothd with decisions of such kind ? Why create an option for mistake ? If a device is BR/EDR only, mgmt_start_discovery will start discovery of BR/EDR devices. If it is a single mode LE device, the mgmt_start_discovery will start a discovery for LE devices only. If the device is dual mode (BR/EDR/LE) then the mgmt_start_discovery command will do the interleaved scanning as the spec defines. Adding such complexity and allowing the selection of scan methods breaks the meaning of the spec. Why do we need to allow the user to scan for LE devices while in BR/EDR only mode, and return an error ? Why should the user even be aware of such an option ? I thought the whole idea behind the mgmtops (as opposite to hciops) was to encapsulate some logic into basic operations and procedures, and prevent the 1:1 reflection of hci commands. In this case, device discovery is opaque to the user - it will discover the devices as the spec defines, without any irrelevant errors and without too much understanding from the upper layers.

I'm not sure what were key reasons for this API change, but this is the
way Start Discovery API was designed. I guess Johan or Marcel can answer
your question about why the user would like to set the discovery procedure.

BR,

Andre

