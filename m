Return-Path: <cyrus@holtmann.org>
Date: Sun, 25 Jan 2009 14:28:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Inquiry w/ RSSI ?
Message-ID: <20090125122803.GA6787@jh-x301>
References: <108aa36c0901241906j284c53bwf755f95d0c45592e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <108aa36c0901241906j284c53bwf755f95d0c45592e@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Jan 25, 2009, Francis Bernard wrote:
> I have checked "Host Controller Interface Functional Specification -
> 7.7.33 Inquiry Result with RSSI Event" on the latest Bluetooth
> Specification, and it made me think this could probably be possible,
> but i have no knowledge about your implementation and if this could be
> or is implemented.
> 
> I saw some adapted code for hcitool.c, at
> http://pysportslive.googlecode.com/svn/trunk/pyrssi/bluessid.c, and I
> was wondering if by making some adaptations at this level, i would
> achieve my needs.

bluetoothd already supports the RSSI information in its D-Bus API. You
will get the information as a "RSSI" property within the DeviceFound
signals. If you really don't want to use the D-Bus API you might want to
take a look how bluetoothd handles this internally. A good place to
start from is the hcid_dbus_inquiry_result function in the
src/dbus-hci.c file and the inquiry_result_with_rssi function in the
src/security.c file.

Johan
