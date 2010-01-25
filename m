Return-Path: <cyrus@holtmann.org>
Subject: Re: dynamically change the local device name
From: Marcel Holtmann <marcel@holtmann.org>
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
In-Reply-To: <670422.1091.qm@web52607.mail.re2.yahoo.com>
References: <670422.1091.qm@web52607.mail.re2.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 25 Jan 2010 18:00:30 +0100
Message-ID: <1264438830.11653.14.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ed,

> I am looking into if it is possible to change the local device name base on the bluetooth address of the remote device.
>  i.e. when a remote device request our name, we return a different name base on the the address of the remote device.
>   There seem to be a hci_write_local_name to store the local name, but I could not find something similar to hci_pin_code_request_reply which seem to allow us to return a different value each time.
>    Is there any work around??

because there is nothing like this. This can not be done.

Regards

Marcel


