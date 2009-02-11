Return-Path: <cyrus@holtmann.org>
Subject: Re: How to update SDP records
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4991F1F9.9080800@dell.com>
References: <4991F1F9.9080800@dell.com>
Content-Type: text/plain
Date: Wed, 11 Feb 2009 17:53:59 +0100
Message-Id: <1234371239.7293.15.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mario,

> I was looking at the Bluez 4.x API and don't see any way for requesting
> an updated set of SDP records for a device.  My Blackberry will not
> connect advertising that it can receive OBEX transfers at all (the File
> Transfer Agent isn't in SDP records).  This is because by default that
> mode is turned off on the device.  There is an option to turn it on
> momentarily to receive a file, but then it turns back off.
> 
> Because of this, it's impossible to pair the device with the SDP record
> for File Transfer on it's list.  Is there somewhere in the API that I am
> missing that allows you to request an updated set of records for a device?

I think what you are looking for is the Device.DiscoverServices()
method. This one lets you trigger SDP.

Regards

Marcel


