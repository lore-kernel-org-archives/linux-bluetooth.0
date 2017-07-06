Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Bluetooth Certification Testing L2CAP eRTM Test Failing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <52FEDDCD-B2BB-4D85-A510-2E080C85D483@hella-gutmann.com>
Date: Thu, 6 Jul 2017 17:21:37 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <EEFAC5D6-7A9B-4F76-8FDD-4EEB9AC234F2@holtmann.org>
References: <52FEDDCD-B2BB-4D85-A510-2E080C85D483@hella-gutmann.com>
To: Heiko Abraham <heiko.abraham@hella-gutmann.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Heiko,

> I am trying to qualify our Bluez 5.45 stack as a host subsystem with the
> Bluetooth Sig. Right now I am running into an issue with eRTM. It looks
> like eRTM is not well supported.
> 
> I use kernel 3.12.74 and BlueZ 5.45 on an ARM platform.
> 
> Can anyone tell me, if eRTM works well with kernel 3.12.x?

if it is supported in 3.12 is something I do not recall since that kernel is so old. It should be supported there since the feature is pretty old.

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/android/pics-l2cap.txt
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/android/pixit-l2cap.txt
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/android/pts-l2cap.txt

Above are the links for doing PTS qualification of L2CAP.

Regards

Marcel

