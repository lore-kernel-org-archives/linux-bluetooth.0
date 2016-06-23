Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Caching device name in different connectable state
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAEZxfGNdtXFznY_D-HLnkFBtQsHaqGbn65ZhmcKkgoh9em5L3g@mail.gmail.com>
Date: Thu, 23 Jun 2016 15:29:45 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <9F8DCC04-EF7A-499D-A39E-2C04C906C056@holtmann.org>
References: <CAEZxfGNdtXFznY_D-HLnkFBtQsHaqGbn65ZhmcKkgoh9em5L3g@mail.gmail.com>
To: =?utf-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Francois,

> I have a bluetooth beacon device that advertises a name depending on
> its configuration (connectable or not).
> Sadly, in Bluez, the first time it sees it while advertising its name,
> it caches it which is nice for future discovery.
> Except it doesn't because I don't want to see this name while it
> advertises in non-connectable state as it is "not" the same device
> anymore (sort of).
> I guess what I'm asking is if we can make Device name aware of the
> connectable state and only use it if it matches state when it was
> cached.

yikes, this is super tricky. If the device uses the same address, then it is the same device. If it is not the same device, then it should use two different addresses (sort of a dual personality).

Please keep in mind that a lot of device identity is based around either the public address or the static random address. We even clarified that as identity address in the latest specification. The mode has nothing to do with it. It makes it even more complicated since a device can be in broadcaster and peripheral role at the same time. It is just a matter of instantiating a second link layer state machine. However even in that case my advise is two use two different addresses if they are independent.

Regards

Marcel

