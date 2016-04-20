Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Bluez 5.x BQB
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAE-r3c+kmLt=pZ68whkAX0Z4k+pD-SZPWYvPARHnGe7bZRLqHQ@mail.gmail.com>
Date: Wed, 20 Apr 2016 14:36:00 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E7A59682-11ED-4455-A7D9-FC5BBC53167D@holtmann.org>
References: <CAE-r3c+kmLt=pZ68whkAX0Z4k+pD-SZPWYvPARHnGe7bZRLqHQ@mail.gmail.com>
To: Adlane Achab <adlane.achab@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adlane,

> Do you have already qualify a Bluetooth device with the bluez stack
> 5.x for BQB or BITE?
> Do you know a certification lab that handles this bluez version.

I remember that Chrome OS has passed BlueZ 5.x qualification. For profile tested with PTS, you can find documentation about PICS, PIXIT and test instructions in the doc/ and android/ directories. They have a lot of test information.

For the few pieces that are still tested via BITE, we have full instructions, but they have not been published. And any test house should be able handle qualifying BlueZ since all the tools are available.

Regards

Marcel

