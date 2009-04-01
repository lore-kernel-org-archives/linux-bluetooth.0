Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Apr 2009 17:29:07 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Marcel <wittemar@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: DeviceFound-Signal without name?
Message-ID: <20090401142907.GA3028@localhost>
References: <bb7250380904010705k2bd15e55t750b1ae34e480f35@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bb7250380904010705k2bd15e55t750b1ae34e480f35@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Apr 01, 2009, Marcel wrote:
> why does the DeviceFound-Signal from the D-Bus-API does not contain a
> name of the device until I have connected to the device one time oder
> until "hcitool scan" found the device? Is there a possibility to
> configure bluetoothd to put the name every time in this signal? Or is
> there a simple way to ask for the name through the D-Bus-API if it is
> missing? I'm using bluez 4.33

If both either local device and the remote device isn't a Bluetooth 2.1
device then you should first be getting a DeviceFound signal without a
name and then a little bit later a DeviceFound signal with the name.
This is because the initial inquiry response event doesn't contain the
name and it needs to be queried separately later. If you're not getting
the second signal we would be interested in investigating why. For this
the output of hcidump -XV would help a lot. One reason could e.g. be
that the device went out of range or is strangly configured to have
inquiry scan enabled but page scan disabled (you shouldn't find any
commercial devices like this but e.g. a linux box can be configured that
way).

Johan
