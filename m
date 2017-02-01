Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Exchanging data over Bluetooth Classic
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <f0f88082abcb4aa700ca2e7898fc75b9@nleyten.com>
Date: Wed, 1 Feb 2017 20:51:30 +0100
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <59C74349-5707-4268-AB5A-8F3C5B6E03B3@holtmann.org>
References: <f0f88082abcb4aa700ca2e7898fc75b9@nleyten.com>
To: Dario Teixeira <dario.teixeira@nleyten.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dario,

> Here's the situation: I want to use a smart phone to communicate with
> a small embedded device (ED).  Unfortunately the ED is running a very
> old kernel (3.10.93) which does not support Bluetooth Low Energy.
> Therefore, if I am to use Bluetooth it will have to be BT Classic.
> 
> The communication is pretty straightforward: just a couple of RPC
> calls using JSON.  Both the requests and the replies are reasonably
> short.  The entire exchange can be summarised as follows:
> 
> Phone: Here's request #1 (JSON text).
> ED: Okay, here's reply #1 (JSON text).
> Phone: Here's request #2 (JSON text).
> ED: Okay, here's reply #2 (JSON text).
> 
> Now, I have a couple of related questions:
> 
> a) I presume there's no other option than using RFCOMM, right?
> 
> b) I know that the first Google hit for "Bluetooth programming"
>   is hopelessly out of date [1], because Bluez now uses DBus.
>   However, where's the Bluez documentation for RFCOMM via DBus?
>   I could only find this page for Bluez documentation [2],
>   but RFCOMM is not mentioned.

you can use L2CAP or RFCOMM sockets to transfer data. Or you can use OBEX as provided by obexd if it is more file related transfer you are after.

Regards

Marcel

