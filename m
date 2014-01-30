Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD-ALXKinmbiAaH3FMA-b4byXo0CMEm1H0Dfc=bCDBwONqsfTA@mail.gmail.com>
References: <CAD-ALXKinmbiAaH3FMA-b4byXo0CMEm1H0Dfc=bCDBwONqsfTA@mail.gmail.com>
Date: Thu, 30 Jan 2014 19:53:33 -0400
Message-ID: <CAJdJm_Og3C1NyZkgo28U_AnhjEuS2=6v-mYLfYqycdr7Dj6rYA@mail.gmail.com>
Subject: Re: BLE Peripheral on Ubuntu
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Prashant R <ramapra@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jan 30, 2014 at 6:01 PM, Prashant R <ramapra@gmail.com> wrote:
> My goal is to be able to use a USB-BT adapter and make it behave like
> a BLE peripheral.
>
> So far I have been able to do LE advertising on it but would want to
> add GATT services for this device.
> I am unable to find documentation on how to control this as a BLE
> Peripheral.Can someone point me to this?

We are currently in the process of submitting patches upstream that
will allow applications to register GATT services using a D-Bus API.

> - Is there currently a tool (opposite of  gatttool) that I can use to
> publish services and characteristics ?

Once the API is upstream, you will be able to register your own
services using D-Bus. There will be example C code demonstrating the
API, and documentation in doc/gatt-api.txt.

> - My version of bluez is4.98-2ubuntu7 . I tried to upgrade to the
> latest but it complains about D-BUS version being <Ver 1.6. My version
> of DBUS  is  1.4.18
> My question is if the GATT server support is present at the user level
> using my version of 4.98-2ubuntu7?

Unfortunately, you will need to use a more recent BlueZ in order to
use the future API. You can build your own D-Bus library and BlueZ
from sources (make sure to install in a separate place , e.g.
/opt/bluez, instead of overwriting any files in /usr).

Current status of the upstreaming process:

- The internal C API for GATT service registration, as well as the
attribute database format, was rewritten. Therefore we need to migrate
existing internal profiles to this new API.

- We sent patches for GATT Service and Characteristic registration.
These initial patches do not export the services over the LE channel
yet (they are only available using a local UNIX socket). This
intermediary step is necessary in order to not break current supported
profiles.

- We will be able to export the services on the LE and BR/EDR channels
once the internal profiles are migrated to the new C API. I'm
currently working on this step.

Summary: the latest BlueZ does not support external GATT services yet,
but we hope to have basic support upstream (with an experimental API)
very soon.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
