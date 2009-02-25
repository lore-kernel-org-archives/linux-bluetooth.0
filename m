Return-Path: <cyrus@holtmann.org>
Subject: Re: API for Input Devices
From: Marcel Holtmann <marcel@holtmann.org>
To: sreevani medhahal <sreevani.medhahal@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <c2a31c480902250519s1ea7a667k6f96b816730fc5cf@mail.gmail.com>
References: <c2a31c480902250519s1ea7a667k6f96b816730fc5cf@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 25 Feb 2009 15:14:17 +0100
Message-Id: <1235571257.24169.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sreevani,

>   I would like to know the entry points into BlueZ code to do the following
> a) Trigger BlueZ to send the Get_Report to HID Device.
> b) Trigger BlueZ to send Reports to Device on Interupt Channel.

that is the job of the HID subsystem in the Linux kernel. BlueZ is only
providing the HIDP transport.

Regards

Marcel


