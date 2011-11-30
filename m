Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 30 Nov 2011 17:10:44 +0530
Message-ID: <CA+_sZW8MnOX_oGThrTr6sb9xtoRBHx6vPabHHgtY4bR+8YyKnA@mail.gmail.com>
Subject: [RFC] FindMe: Proposal to have separate dbus interface
From: vishal agarwal <vishal.bluez@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: naresh.gupta@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

  I'm working on Proximity and FindMe profiles for BLE. I came across
the need for a separate DBus interface for FindMe profile.

  Here's the detailed description of the use case.

  Let's take an example where both the BLE devices support LinkLoss
Service, Read Tx Power Service and Immediate Alert service. One device
has Proxmity monitor and FindMe locator capabilities and Second device
has Proximity reporter and FindMe reporter capabilities.

  There is an existing DBus interface for proximity -
PROXIMITY_INTERFACE. SetProperty, GetProperties methods and
PropertyChanged signal is registered on this interface.
  SetProperty takes two arguments - Property(LinkLossAlertLevel or
ImmediateAlertLevel) and the value of alertlevel.
  Same is true for PropertyChanged signal. it returns - Property
(LinkLossAlertLevel or ImmediateAlertLevel) and the value of
alertlevel

  Now if user wants to find the other device (using FindMe profile)
which is already connected to the Proximity monitor, for this,
SetProperty should be called. But now there is no way for BlueZ to
figure out whether it is called for Proximity(in this case, action
will be taken when PathLoss condition met) or for FindMe(it has to
write the alert level immediately).

  Same thing applies when we receive PropertyChanged signal. There is
no way for framework over DBus to figure out whether PropertyChanged
is for FindMe or for Proximity. If implementation is such that
Proximity reporter will alarm when it receives the PropertyChanged due
to path loss and there will be no alarm when PropertyChanged is called
for FindMe profile, framework has to know this.

  One way to resolve these issues is to have seperate DBus interface
for Proximity and FindMe profiles.
Some benefits of using seperate interfaces for both the profiles -
1. Code will be more clear
2. Both BlueZ and framework above Dbus will easily distinguish
different methods and signals for these profiles
3. Existing code will not break


Thanks
Vishal Agarwal
ST Ericsson
