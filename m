Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 15 Apr 2010 22:17:12 -0400
Message-ID: <p2ld6c61fb91004151917x2a93d5dfr2ef1e6c2d01819a0@mail.gmail.com>
Subject: what is needed for SSP mode
From: Ronny Pau <ronnypau@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I current have a running BlueZ stack running SPP, where I am able to
pair with another device using a 4-digit passkey, establish pairing,
form a RFCOMM connection, which I am using to exchange data with my
cellphone.

Now, I would like to switch on SSP mode, where I have issued
"hciconfig hci0 sppmode 1" and verify that it is indeed on using
"hciconfig hci0 sppmode".  However, if I attempt to connect with my
cellphone, I get a connection failure. Have I missed something?

Any help would be appreciated.

Thanks.
