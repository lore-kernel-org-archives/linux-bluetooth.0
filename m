Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 8 Oct 2015 20:14:03 -0700
Message-ID: <CAD0=r8x7hEkGZG+ocE1E+ezF8C+4mFoWuROry=xsf_OfPY+_AA@mail.gmail.com>
Subject: [BlueZ] Difference profiles, dbus profiles and plugins ?
From: Jakub Pawlowski <jpawlowski@google.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Can someone please explain the difference between profiles from
'profiles' directory, and DBus profiles, i.e. 'test/test-profile' and
'test/test-gatt-profile' ? How they're supposed to be used, and how do
they map to Bluetooth Profiles ?

Are those from "profiles" directory somehow special, or deprecated?
Does DBus profiles also work for LE devices somehow (ones from test
directory look like BT Classic ones)
profiles from "profile" directory can expose functionality through
DBus (like heart rate profile), can same be achieved through DBus
services ?

I have some issues with devices that expose service with 0xFFFD UUID,
that is Universal Second Factor Authenticator Service (U2F). I need to
disable auto connect for LE devices that have exclusively three
services: Device Info, GAS, and U2F. Shall I use profile, DBus
profile, or maybe plugin ? What are plugins for ?

When these three services are on device, it's single-purpose
authenticator device. It's used to authenticate transactions, and
might be used between multiple machines (laptop, workstation, phone),
but support one connection at a time. Having linux auto connect to it
all the time makes it unable to connect to other nearby devices that
might try to authenticate transaction. If other services are exposed,
it might be multi-purpose device (i.e. phone that also acts as
authenticator) and default auto connect rules shall apply.

I've looked through "plugins" directory and seen that there's a
disable auto connect field that can be set. Would writing u2f plugin
be proper way to solve that?

Thanks!
