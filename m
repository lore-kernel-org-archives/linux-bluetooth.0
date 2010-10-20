Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Oct 2010 17:40:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Igor pesando <ipesando@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Activating a serial connection with qdbus
Message-ID: <20101020144004.GA14607@jh-x301>
References: <AANLkTikmAHP8JiBw=cYqHCbiLot6rLjjboc7wnySmEmj@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikmAHP8JiBw=cYqHCbiLot6rLjjboc7wnySmEmj@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Igor,

On Wed, Oct 20, 2010, Igor pesando wrote:
> If I try to connect with the spp profile to a device using qdbus o dbus.send as
> 
> qdbus --system org.bluez /org/bluez/5989/hci1/dev_00_11_22_33_44
> org.bluez.Serial.Connect spp
> 
> I get the proper reply /dev/rfcomm0 but the connection is dropped
> immediately as rfcomm shows.
> On the other side if I use rfcomm or the python script test-serial the
> connection is established and kept alive.
> 
> So the questions is whether this is the expected behaviour.
> Equivalently I ask whether one should interact with the dbus interface
> only by programs and use rfcomm otherwise.

bluetoothd is "intelligent" and cleans up after the D-Bus client if the
client exists unexpectedly without calling Serial.Disconnect() first
(which is what qdbus does when it receives the reply). So the only way
to keep the connection alive is to also keep the process alive that
requested it. I.e. probably you can't use qdbus for this.

> If so I do not understand why it is not possible to set the Powered
> property using hciconfig since if the device property Powered is false
> it is not possible to initialize HCI device.

I'm not quite following your question. You can use "test-adapter powered
yes/no" and even "hciconfig hci0 up/down" should also work.

Johan
