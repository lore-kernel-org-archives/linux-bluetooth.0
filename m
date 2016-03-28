Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Seeking some bluez dbus enlightenment
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <F0CC57E5-9193-483D-A2DF-33254216E6AD@gmail.com>
Date: Mon, 28 Mar 2016 15:54:42 -0700
Message-Id: <CFBCE3E1-9F51-4C87-A4BF-0D8B01C737B4@gmail.com>
References: <F0CC57E5-9193-483D-A2DF-33254216E6AD@gmail.com>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On Mar 25, 2016, at 3:21 PM, Travis Griggs <travisgriggs@gmail.com> wrote:
> 
> I have gotten a python3 (mostly) abstracted versions of the example-gatt-server and example-advertise working. Basically had to add the “Application” thing from the previous 5.37 based versions. They are relatively small and attached. Hardest part was throwing darts at the difference between the python3 dbus interface and the python2 dbus interface. It works, but who knows how idiomatic it is.
> 
> I’m confused by many things (at least 6) though.
> 
> Right after startup, without running any of my own code:
> 
> ~# mdbus2 --system org.bluez / org.freedesktop.DBus.ObjectManager.GetManagedObjects
> ({'/org/bluez': {'org.freedesktop.DBus.Introspectable': {}, 'org.bluez.AgentManager1': {}, 'org.bluez.ProfileManager1': {}, 'org.bluez.Alert1': {}, 'org.bluez.HealthManager1': {}}, '/org/bluez/hci0': {'org.freedesktop.DBus.Introspectable': {}, 'org.bluez.Adapter1': {'Address': <'5C:F3:70:68:C1:F9'>, 'Name': <'nelson'>, 'Alias': <'PILOT-FF0021'>, 'Class': <uint32 0>, 'Powered': <true>, 'Discoverable': <false>, 'DiscoverableTimeout': <uint32 180>, 'Pairable': <true>, 'PairableTimeout': <uint32 0>, 'Discovering': <false>, 'UUIDs': <['00001801-0000-1000-8000-00805f9b34fb', '0000110e-0000-1000-8000-00805f9b34fb', '00001200-0000-1000-8000-00805f9b34fb', '00001800-0000-1000-8000-00805f9b34fb', '0000110c-0000-1000-8000-00805f9b34fb']>, 'Modalias': <'usb:v1D6Bp0246d0526'>}, 'org.freedesktop.DBus.Properties': {}, 'org.bluez.GattManager1': {}, 'org.bluez.Media1': {}, 'org.bluez.CyclingSpeedManager1': {}, 'org.bluez.HeartRateManager1': {}, 'org.bluez.ThermometerManager1': {}, 'org.bluez.LEAdve
 rtisingManager1': {}}},)
> 
> 1) A GattManager and a LEAdvertisingManager are things I expected. But a CycleSpeedManager? And a HeartRateManager? I don’t understand why these are there. Is it because I have the -E turned on. Are they just temporary during the development phase while that is experimental? I thought there was quite a few of these predefined services and characteristics, and here see a few, but far from all. I *think* those UUIDs match up with some of the manager things?

<snip>

I have determined/guessed/inferred that things like CycleSpeedManager1 show up by virtue of the daemon’s plugins, which seem to all be enabled by default (at least with -E(experimental)  on). Adding —noplugin=* causes them to all be skipped and no longer show up. The only UUIDs that remain when I do that are the 1801, 1800, and 1200 ones which are for GATT, GAP, and ANP respectively.

I would love any hints to any of the other 5 dilemmas I shared in there. Especially the last two.


