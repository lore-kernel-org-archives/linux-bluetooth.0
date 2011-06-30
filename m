Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309465011.5023.85.camel@novo.hadess.net>
References: <1309458277-30407-1-git-send-email-claudio.takahasi@openbossa.org>
	<1309465011.5023.85.camel@novo.hadess.net>
Date: Thu, 30 Jun 2011 16:59:06 -0400
Message-ID: <BANLkTi=X__bC+4gAKuYzhvYPP-S3+QWGkw@mail.gmail.com>
Subject: Re: [RFC BlueZ] Add Proximity API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 30, 2011 at 4:16 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2011-06-30 at 15:24 -0300, Claudio Takahasi wrote:
>> Covers the Proximity Reporter for Link Loss, Tx Power and Immediate
>> Alert services. This first proposal considers that the connections
>> will be managed by the bluetoothd core based on the registered
>> connection callbacks.
>
> Any examples of possible uses, or hardware implementing those?

It is a LE-only GATT profile. So any Bluetooth 4.0 certified hardware
should be able to run the Proximity and Find Me profiles. But I'm not
aware of any Bluetooth 4.0 hardware selling for general consumers (I
heard of a notebook with it sometime ago on this list).

For use cases, you should really take a look at the Bluetooth Low
Energy concept as a whole. See bluetooth.org for details.

> Is this
> good enough to implement both sides of the profile, or just one side of
> it?

The API is for the Proximity Monitor role. The Proximity Reporter role
will usually run on LE single mode (very low power, coin cell battery)
devices, but we will have a basic Proximity Reporter for testing
purposes as well, which could be later expanded to a full featured
Reporter.

> Is this something that could require UI being written?

For sure. This is just the D-Bus API, some graphical/console
application must be written to use it. We will provide test scripts
under the test/ directory.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
