Return-Path: <cyrus@holtmann.org>
Subject: Re: [bluetooth device not working fine]issue with usb core probe
 at hibernate & resume
From: Marcel Holtmann <marcel@holtmann.org>
To: Madula Sasikiran <Madula.Sasikiran@Atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <44EE5C37ADC36343B0625A05DD408C48506872FB7C@CHEXMB-01.global.atheros.com>
References: <44EE5C37ADC36343B0625A05DD408C48506872FB7C@CHEXMB-01.global.atheros.com>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 12:07:00 +0200
Message-Id: <1252663620.8931.66.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I am a bluetooth developer, came into bluetooth field recently. My bluetooth device is not working fine when I do hibernate and resume in linux 2.6.28 (ubuntu 9.0.4). It is working fine in the older versions. When I debugged the issue I see that when usb core is calling probe for the usb bluetooth dongle and the driver related to that is loading the firmware into the device. When I suspend and resume, usb core is calling probe and the firmware is getting loaded fine. For hibernate resume usb core is not calling probe and firmware is not getting loaded. I would like to know whether it is the issue with the usb core or Do I need to do any changes in the driver for this. Can I call the probe of my usb bluetooth dongle explicitly using any scripts?

and again, re-test against 2.6.31 kernel.

Regards

Marcel


