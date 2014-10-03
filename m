Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F54B539B-3C7A-48C6-B608-417FBCB5050F@holtmann.org>
References: <CAHF=Y4pBMLaF1osqQNk1fkw1UHGk6SMYhQ=u5zYZ6qswoFKWBA@mail.gmail.com>
 <F54B539B-3C7A-48C6-B608-417FBCB5050F@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
Date: Fri, 3 Oct 2014 10:17:40 +0200
Message-ID: <CAHF=Y4oGjUc=j4DE_pyC5Ue5ymsaoaGXJRzYHdWTHa2EF1k9Gg@mail.gmail.com>
Subject: Re: Connecting to propietary remote GATT service: plugins vs D-Bus
 GATT API
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>, Mattias Jansson <mjansson@spotify.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

> You might have to start the daemon with -E flag. I am also not sure that it is fully hooked up yet. However that would an easy fix I guess.

I did start it with -E . In fact "gdbus introspect -r --system -o /
-d org.bluez" shows the GattManager1 interface, but no
dev_XX_XX_XX_XX_XX_XX/serviceXX(/charYYYY) object exposing
GattService1 or GattCharacteristic1, not even while connecting to
a bonded BLE device with GATT services.




-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
