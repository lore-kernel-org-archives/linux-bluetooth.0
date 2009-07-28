Return-Path: <cyrus@holtmann.org>
Subject: Re: non-blocking hci_inquiry()
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexander H Deriziotis <deriziotis@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <5eee8c670907280455ube96c5aka5a9a97149034a71@mail.gmail.com>
References: <5eee8c670907280453i76f4957fvcca9c3954576580d@mail.gmail.com>
	 <5eee8c670907280455ube96c5aka5a9a97149034a71@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 28 Jul 2009 14:31:44 +0200
Message-Id: <1248784304.28545.226.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> I've been playing with the linux wiimote daemon called Cwiid, and
> noticed that while it's waiting for a connection from a wiimote, it's
> blocking the bluetooth adapter from doing anything else.
> 
> Searching around and looking at the code, I can see it's calling
> hci_inquiry() in a loop which is blocking the device.
> 
> Does a non-blocking hci_inquiry() function exist? If not, could I get
> some help on how to go about writing one?

use the D-Bus interface for non-blocking inquiry.

Regards

Marcel


