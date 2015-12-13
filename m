Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1449991256.8150.3.camel@gmail.com>
Subject: Re: Lenovo keyboard
From: Berend De Schouwer <berend.de.schouwer@gmail.com>
To: linux-bluetooth@vger.kernel.org
Date: Sun, 13 Dec 2015 09:20:56 +0200
In-Reply-To: <CA+RPYyX5b=QGdym1V0pFrU5kT_4HbTPeJF8piheUcp9MnOSYdQ@mail.gmail.com>
References: <CA+RPYyX5b=QGdym1V0pFrU5kT_4HbTPeJF8piheUcp9MnOSYdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2015-12-12 at 17:06 +0100, chris wrote:
> Dear list,
> 
> I've been consistently using a lenovo bluetooth keyboard since
> Bluez4.
> Since a recent (a month ago or so) upgrade (debian/stretch) it
> doesn't
> connect anymore.
> Neither does a Jabra Stealth earpiece which was doing fine a month
> ago.
> 
> Even when it says conneced: yes, it isn't actually connected:
> the led of the keyboard indicates it isn't connected and there is no
> input.

I've got similar symptoms with 4 different bluetooth keyboards.  One
Logitech, one Apple, one Kanex and one Astrum.

Pairing works, input fails.

At the same time, the kernel loops:
[ 1449.370904] Bluetooth: hci0 ACL packet for unknown connection handle
2
[ 1455.734779] Bluetooth: hci0 ACL packet for unknown connection handle
3
[ 1461.731976] Bluetooth: hci0 ACL packet for unknown connection handle
4
[ 1468.037014] Bluetooth: hci0 ACL packet for unknown connection handle
5
[ 1474.005517] Bluetooth: hci0 ACL packet for unknown connection handle
6
[ 1479.972716] Bluetooth: hci0 ACL packet for unknown connection handle
7
[ 1491.066637] Bluetooth: hci0 ACL packet for unknown connection handle
8


Eventually a working handle is found.

The Logitech is ancient, but the others are relatively new.

