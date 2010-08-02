Return-Path: <cyrus@holtmann.org>
Subject: Re: seeking debug advice for a hanging serial device
From: Steve Castellotti <sc@puzzlebox.info>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1280521176.2338.45.camel@localhost>
References: <1280521176.2338.45.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 16:21:58 -0700
Message-ID: <1280791318.2550.6.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2010-07-30 at 13:19 -0700, Steve Castellotti wrote: 
> However under Linux, the device frequently hangs within 5 seconds of
> attempting to read the data stream.
> 
>     This occurs whether through my code (which is platform agnostic) or
> simply cat'ing the RFCOMM device from a console (both in normal and raw
> mode).

Just to follow up on my own email (for the sake of future Google
searchers), I did arrive at a solution to my problem.

I switched to using the pybluez "bluetooth" module under Linux and
talking to the Bluetooth device using sockets instead of the RFCOMM
serial device:

http://pybluez.googlecode.com/svn/www/docs-0.7/index.html


Some example code:


import bluetooth

address = "XX:XX:XX:XX:XX:XX"

port = 3 # connect to channel 3

socket = bluetooth.BluetoothSocket( bluetooth.RFCOMM )
socket.connect((address, port))

while True:
   try:
      byte = sock.recv(1)
      print byte
   except Exception, e:
      print e

sock.close()


I still don't understand why attempting to access the RFCOMM serial
device directly was failing under Linux but at least I am able to
proceed with my driver development.


Cheers

Steve Castellotti


