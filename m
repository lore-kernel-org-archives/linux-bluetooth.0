Return-Path: <cyrus@holtmann.org>
Message-ID: <493295C7.4060309@powercraft.nl>
Date: Sun, 30 Nov 2008 14:31:51 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: Simon Kenyon <simon@koala.ie>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Sony BD Remote (the saga continues)
References: <492FC4A3.4020601@koala.ie> <492FCDD1.1010304@koala.ie> <492FDF90.9010305@koala.ie> <492FEF38.3020702@koala.ie> <492FF071.8030909@powercraft.nl> <492FF7D5.6060202@koala.ie> <492FFB09.7020704@powercraft.nl> <493173E4.3060001@powercraft.nl> <49327089.5020003@koala.ie>
In-Reply-To: <49327089.5020003@koala.ie>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Simon Kenyon wrote:
> Jelle de Jong wrote:
>> I will wait until the next debian update of libx11 and hope an input
>> event will be created when connecting the device.
> why would X11 be involved in creating the event device?
> i might be using the remote without X

There are a number of things not working yet. The connecting/pairing
system should make the input device, at leased that is what I think. The
X stuff is so that the input system can understand what it is saying,
this is some sort of hid driver for the device. This is also not yet
working. Then there is the thing that some of the developers like to
merge everything in gui application so that is can only be setup with
this gui or by manually creating dbus command and sending them ....

I am also not a bluez developer and I tolled people I would like to
understand how the heck somebody can implement proper support for these
devices (I got a bag full of non working bluetooth devices), nobody seem
to make the time to explain in detail how it works ... and how to get
add code to get it working.

So my strategy is just to wait until somebody cares to fix it... Not
very fast or effective but nothing else I can do. I spent far to much
time telling people it does not work.

I am sorry for all the frustrations...

Best regards,

Jelle


