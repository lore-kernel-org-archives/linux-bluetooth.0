Return-Path: <wb0gaz@hotmail.com>
From: David Feldman <wb0gaz@hotmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Date: Sun, 20 Jun 2004 20:25:51 -0600
Subject: Re: [Bluez-users] rfcomm - "Connection refused"
In-Reply-To: <1087789335.4781.175.camel@pegasus>
References: <20040620170410.96A6F530.wb0gaz@hotmail.com> <1087789335.4781.175.camel@pegasus>
Message-Id: <20040620202551.1EB27B30.wb0gaz@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <bluez-users.lists.sourceforge.net>

Thank you Marcel,

Can you tell me should I choose the very latest (2.4.x) kernel? It 
will be some project to install the later kernel, so I want to choose 
carefully. I am now at 2.4.30.x (stock RH9 was 2.4.18) and that is 
the latest kernel provided as an update to Redhat 9; anything later 
version I guess "I am on my own!"

Is there a step in the procedure that causes the PIN to be requested 
by the phone? It never asked for PIN!

Thank you again,

Dave

Marcel Holtmann <marcel@holtmann.org> wrote:
(06/20/2004 21:42)

>Hi David,
>
>> This continues my work to get a bluetooth connection going from
>> my RH9 laptop to a Sony Ericsson T68 (not i) cell phone.
>
>what kernel are you using? The credit based flow control is wrong here.
>The T68 don't supports the RFCOMM flow control of Bluetooth 1.1, but our
>code still tries to set the PF-bit. Install yourself the latest kernel
>and everything should be fine.
>
>Regards
>
>Marcel
