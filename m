Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC v2 1/1] doc/gatt-api: New API properties and methods for the GATT D-Bus API.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407789427-7118-2-git-send-email-armansito@chromium.org>
Date: Fri, 29 Aug 2014 20:20:57 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0392E87D-1C2E-4921-A94F-2D94BD38DCF7@holtmann.org>
References: <1407789427-7118-1-git-send-email-armansito@chromium.org> <1407789427-7118-2-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch introduces the following new properties to the GattService1
> interface:
> 
>  Device: A remote-service-only property that contains the D-Bus object
>  path of the associated device.
> 
>  Primary: Reflects whether or not a services is primary or secondary.
> 
> This patch also introduces new methods to GattCharacteristic1 and
> GattDescriptor1 for reading and writing the corresponding attribute
> values and a new signal for being notified of received notifications and
> indications.
> 
> The "Value" D-Bus property is removed from both interfaces
> and replaced with asynchronous ReadValue and WriteValue functions. This
> is due to the fact that DBus.Properties.Get is synchronous and without
> an asynchronous way of issuing a GATT value read request, there are
> cases where a single read and cache based approach becomes limiting
> (e.g. when a characteristic allows reads but no notifications) and
> relying on the PropertyChanged signal to retrieve the value of a read
> request asynchonously as well as to signal notifications/indications
> makes for a vague API.
> ---
> doc/gatt-api.txt | 124 +++++++++++++++++++++++++++++++++++++++++++++++++------
> 1 file changed, 112 insertions(+), 12 deletions(-)

I honestly forgot where we left off with this. I remember vaguely that the patch for the API document should got upstream, but I do not remember if it was this version or not. It also seems that neither Johan nor Luiz picked it up.

Regards

Marcel

