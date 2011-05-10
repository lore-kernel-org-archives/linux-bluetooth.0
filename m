Return-Path: <cyrus@holtmann.org>
From: "Cufi, Carles" <carles.cufi@nordicsemi.no>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 10 May 2011 15:25:35 +0200
Subject: btusb and non-standard descriptors
Message-ID: <5B4B9A479BF6994B88EA975675EC5B790575861F5C@MES1OS2SXC003.mes1.tconet.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi there,

Just wondering, what intefaces/endpoints does btusb use when there's no standard "USB_DEVICE_INFO(0xe0, 0x01, 0x01)" descriptor and instead it's using a hardcoded VID/PID?

Thanks!

--
Carles


