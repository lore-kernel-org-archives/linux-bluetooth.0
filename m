Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] bluetooth: Take a runtime pm reference on hid
 connections
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <1284659895-27984-1-git-send-email-mjg@redhat.com>
References: <1284659895-27984-1-git-send-email-mjg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Oct 2010 12:32:25 +0300
Message-ID: <1286962345.3316.1.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthew,

> Bluetooth runtime PM interacts badly with input devices - the connection
> will be dropped if the device becomes idle, resulting in noticable lag when
> the user interacts with the input device again. Bump the pm runtime count
> when the device is associated and release it when it's disassociated in
> order to avoid this.

we already have hci_conn_hold_device() and hci_conn_put_device() calls
for HID to hold reference of the ACL connection. Why do we need more?

Regards

Marcel


