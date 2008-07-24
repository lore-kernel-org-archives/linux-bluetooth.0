Return-Path: <cyrus@holtmann.org>
Subject: Re: RFCOMM server multiple client connections
From: Marcel Holtmann <marcel@holtmann.org>
To: Kasper Revsbech <mail@krevsbech.dk>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <488870AF.3080601@krevsbech.dk>
References: <488870AF.3080601@krevsbech.dk>
Content-Type: text/plain
Date: Thu, 24 Jul 2008 16:13:05 +0200
Message-Id: <1216908785.7820.13.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kasper,

> I am trying do do a simple client server setup  with bluez.
> I can manage to have a client and a server on rfcomm sockets where the 
> server listen on a socket and accept a connection from the client by 
> connect. But then if I set the server back to accepting without putting 
> down the one client connection it doesn't accept a new connection.
> When I read thought the documentation I can find on Bluez and Bluetooth 
> in general it seems like it should be possible to multiplex serveal 
> virtual rfcomm connections  on one actual connection. But however I 
> really can get it working and can't find any code where they do 
> something similar.

are the clients running on multiple adapters. If they run on the same
adapter, it won't work. RFCOMM is not a layer that assign dynamic
channels numbers to each connection (like L2CAP does) and thus once a
RFCOMM channel is in use (the pair is bdaddr:channel) then you can
connect to it twice.

Regards

Marcel


