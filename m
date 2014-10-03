Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: Connecting to propietary remote GATT service: plugins vs D-Bus GATT API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHF=Y4pBMLaF1osqQNk1fkw1UHGk6SMYhQ=u5zYZ6qswoFKWBA@mail.gmail.com>
Date: Fri, 3 Oct 2014 09:40:29 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Mattias Jansson <mjansson@spotify.com>
Message-Id: <F54B539B-3C7A-48C6-B608-417FBCB5050F@holtmann.org>
References: <CAHF=Y4pBMLaF1osqQNk1fkw1UHGk6SMYhQ=u5zYZ6qswoFKWBA@mail.gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

> I need to connect to a non-standard remote GATT service. We don't plan
> to submit the resulting client code for the time being (it would be of
> little interest for the general public), for which it would be good to
> keep it as decoupled as possible from bluetoothd.
> 
> As I see it, I have two options:
> 
> 1) Create a BlueZ plugin. bluetoothd supports external plugins through
> shared objects but that's not enough to decouple them from bluetoothd:
> 
> * Is bluetoothd's API supposed to be respected across versions?
> * Even if the answer is true, which I doubt, without a decoupled set
> of header files which the plugin can use, I don't see a way to build
> it outside of BlueZ's tree.

the internal plugin API is not guaranteed. You can build an external plugin and the daemon will load it. That is technically possible.

> 2) Use the experimental D-Bus GATT API.
> 
> Even if the API is likely to change, it would allow to build and
> implement the client in a separate process.

That is the intention here. We want to explicitly allow 3rd party application to operate as GATT client and GATT servers. So that is the way to go.

> Its documentation (doc/gatt-api.txt) made me assume that the API would
> be automatically exposed for all services in remote devices since we
> discover them when pairing or connecting to a device for the first
> time. However, that doesn't seem to be the case. Is there a reason not
> to do it?

You might have to start the daemon with -E flag. I am also not sure that it is fully hooked up yet. However that would an easy fix I guess.

Regards

Marcel

