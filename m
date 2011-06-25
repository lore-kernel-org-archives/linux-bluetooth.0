Return-Path: <cyrus@holtmann.org>
Message-ID: <1309029750.36748.YahooMailClassic@web26507.mail.ukl.yahoo.com>
Date: Sat, 25 Jun 2011 20:22:30 +0100 (BST)
From: Mark Hobley <markhobley@yahoo.co.uk>
Reply-To: markhobley@yahoo.co.uk
Subject: Re: How do I make the computer visible to the mobile phone?
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1309019239.14190.31.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--- On Sat, 25/6/11, Peter Hurley <peter@hurleysoftware.com> wrote:

> The typical way to debug bluetooth issues is:
> 1. add debug flag "-d" to bluetoothd command line and then
> review system log

There is some strange stuff going on:

Jun 25 19:48:27 venus udevd[25268]: failed to execute '/usr/local/sbin/bluetoothd' '/usr/local/sbin/bluetoothd --udev': No such file or directory

bluetoothd is in /usr/sbin not /usr/local/sbin. I don't know how to switch that.

Jun 25 19:48:41 venus bluetoothd[916]: input-headset driver probe failed for device 00:1F:CC:C2:E4:86

I don't know what that is. I don't have a bluetooth headset. That is the address of my mobile phone.

Mark.

