Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Alfonso Acosta <fons@spotify.com>
Date: Fri, 3 Oct 2014 09:14:51 +0200
Message-ID: <CAHF=Y4pBMLaF1osqQNk1fkw1UHGk6SMYhQ=u5zYZ6qswoFKWBA@mail.gmail.com>
Subject: Connecting to propietary remote GATT service: plugins vs D-Bus GATT API
To: linux-bluetooth@vger.kernel.org
Cc: Mattias Jansson <mjansson@spotify.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I need to connect to a non-standard remote GATT service. We don't plan
to submit the resulting client code for the time being (it would be of
little interest for the general public), for which it would be good to
keep it as decoupled as possible from bluetoothd.

As I see it, I have two options:

1) Create a BlueZ plugin. bluetoothd supports external plugins through
shared objects but that's not enough to decouple them from bluetoothd:

 * Is bluetoothd's API supposed to be respected across versions?
 * Even if the answer is true, which I doubt, without a decoupled set
of header files which the plugin can use, I don't see a way to build
it outside of BlueZ's tree.

2) Use the experimental D-Bus GATT API.

Even if the API is likely to change, it would allow to build and
implement the client in a separate process.

Its documentation (doc/gatt-api.txt) made me assume that the API would
be automatically exposed for all services in remote devices since we
discover them when pairing or connecting to a device for the first
time. However, that doesn't seem to be the case. Is there a reason not
to do it?

Comments? Thoughts?

Thanks,

Fons
-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
