Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb and non-standard descriptors
From: Marcel Holtmann <marcel@holtmann.org>
To: "Cufi, Carles" <carles.cufi@nordicsemi.no>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <5B4B9A479BF6994B88EA975675EC5B790575861F5C@MES1OS2SXC003.mes1.tconet.net>
References: <5B4B9A479BF6994B88EA975675EC5B790575861F5C@MES1OS2SXC003.mes1.tconet.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 May 2011 18:32:13 -0700
Message-ID: <1305163933.15916.170.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Carles,

> Just wondering, what intefaces/endpoints does btusb use when there's no standard "USB_DEVICE_INFO(0xe0, 0x01, 0x01)" descriptor and instead it's using a hardcoded VID/PID?

the ones described in the Bluetooth USB HCI (aka H:2) standard.

Regards

Marcel


