Return-Path: <cyrus@holtmann.org>
References: <CANq1E4TMGGwiz-kGGCqGOn+A-D-msiTAb8L4Yf6kkMwrzOnn_g@mail.gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <CANq1E4TMGGwiz-kGGCqGOn+A-D-msiTAb8L4Yf6kkMwrzOnn_g@mail.gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <B75AA63D-0629-4B45-BBB2-C09CD7EEFB48@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Device selection during inquiry
Date: Tue, 19 Mar 2013 01:15:55 +0100
To: David Herrmann <dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 19 Mar 2013, at 01:07, David Herrmann <dh.herrmann@gmail.com> wrote:
> I tried setting the following to the same values as on a sample target device:
>  - BT Address
>  - device-class
>  - inquiry-mode
>  - device-name
> However, that didn't change anything.
> 
> Are there any other values that I should play with which might be used
> by the host to identify possible target devices?

Adapter MAC address. In fact, I thought that was necessary with some Wiimotes to make the bonding permanent.