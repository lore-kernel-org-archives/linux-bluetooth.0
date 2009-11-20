Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Nov 2009 10:14:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: nirav rabara <niravrabara@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Pincode request Problem
Message-ID: <20091120081406.GA14589@jh-x301>
References: <912bb79a0911192145j2c97d8adjfd9ae445a9b3e50a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <912bb79a0911192145j2c97d8adjfd9ae445a9b3e50a@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Nov 20, 2009, nirav rabara wrote:
> I am using Qt for GUI, Now I want to wait in bluetoothd  for Pincode
> and  want to pass the pincode from Qt to bluetoothd , and then
> bluetoothd should proceed.
> 
> In other way I want to pass pincode from one process to another
> process, but I am using Qt not GTK which has been used in Bluez.

There's no GNOME or GTK+ dependency in BlueZ. The PIN is requested over
D-Bus so any application that can speak D-Bus can act as an agent and
respond to the PIN requests.

> But is there any window to solve with problem, I mean any API OR any
> document which can help me Or Is anybody has done something like that.

See the RegisterAgent and CreatePairedDevice D-Bus methods in
doc/adapter-api.txt as well as the full agent API description in
doc/agent-api.txt. test/agent.c is an example C implementation of an
agent and test/simple-agent an example python implementation.

Johan
