Return-Path: <cyrus@holtmann.org>
Subject: Re: MCAP implementation in BlueZ
From: Marcel Holtmann <marcel@holtmann.org>
To: sancane <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4A7B28D7.8040902@gmail.com>
References: <4A7B28D7.8040902@gmail.com>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 13:12:24 -0700
Message-Id: <1249589544.21101.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I have seen that BlueZ has begun to incorporate enhanced retransmission
> mode support to L2CAP. This is a happy new because i work with medical
> devices that have begun to incorporate health device profile (HDP) in
> bluetooth communications. I would like to use that devices in linux and
> i saw that MCAP is not included in the bluetooth linux stack so i was
> thinking in develop it for BlueZ.
> I've studying the possibility of integrate it as kernel module like
> rfcomm does but  i have some doubts about that approximation. I think
> that it is not the best place for it and i believe that is better
> develop MCAP in user space.

you wanna do that in userspace (like we did with AVDTP). The kernel
option would be only required if it interacts with another kernel
subsystem which I highly doubt.

Currently it is not 100% clear what will be the best implementation of
HDP, but there are two choices. First one would be a bluetoothd plugin
or second would be similar to what obexd is doing. The real question
here is if it runs more in the user session or as a system daemon.

Regards

Marcel


