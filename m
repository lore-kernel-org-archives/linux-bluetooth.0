Return-Path: <wb0gaz@hotmail.com>
From: David Feldman <wb0gaz@hotmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>, wb0gaz@hotmail.com
Date: Tue, 22 Jun 2004 09:30:51 -0600
Subject: Solved pairing problem - big success!
In-Reply-To: <1087852135.4328.30.camel@pegasus>
References: <20040621135136.7C703C50.wb0gaz@hotmail.com> <1087852135.4328.30.camel@pegasus>
Message-Id: <20040622093051.CF78DDA0.wb0gaz@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <bluez-users.lists.sourceforge.net>

Hello Marcel/List:

I sent my last message too soon - sorry for the noise on the list.

I did more reading, and discovered there was an error in my pin 
helper file.

It appears the message generated must be PIN:xxxx, not just xxxx, so I
changed that. 

This made pairing successful!

Then, I configured minicom to communicate with /dev/rfcomm0 at 19200
bps, and the phone bluetooth went on-line. I was able to manually 
dial to
my home linux server phone number, and log in!

It is a very big success!!!

Thank you VERY MUCH for all of your fine help and advice, I now have
beginning bluetooth connection on my old Omnibook 800.

Soon, I will get ppp running, then I can access internet directly...

Dave
wb0gaz@hotmail.com
