Return-Path: <jsantos_pt@hotmail.com>
From: "João Santos" <jsantos_pt@hotmail.com>
To: marcel@holtmann.org
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] phone+heaset
Date: Thu, 08 Jan 2004 18:55:40 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <SEA2-F33wlVZmSox9fS00030187@hotmail.com>
List-ID: <bluez-users.lists.sourceforge.net>

hi marcel,


>do you read the headset profile specification? You have to answer the AT
>commands on the RFCOMM channel. Look at hstest.c for an example.
I already had read the hset profile specification and i had change the 
program hstest.c to send at+ckpd=200 instead of ring (used if i want to make 
a sco link between the pc and a bluetooth headset), and nothing, i dont 
receve any sco data.

I also try make a rfcomm connection using
[root@olivia /]# rfcomm connect /dev/rfcomm0 00:60:57:15:8A:A9 12
Connected /dev/rfcomm0 to 00:60:57:15:8A:A9 on channel 12
Press CTRL-C for hangup

Sending next the at command at+ckpd=200 whit the minicom app, i receve ok.
and then execute the scotest app.
The scotest  create a sco link and stay waiting in the function accept(), 
till any button in the phone is press.
Then the app waits in the read() function waiting for sco data from the 
phone.

thanks

regards
João Santos

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail
