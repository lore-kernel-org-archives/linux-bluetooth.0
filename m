Return-Path: <survivor@uni-paderborn.de>
Message-ID: <40607CB2.3050608@uni-paderborn.de>
Date: Tue, 23 Mar 2004 19:06:42 +0100
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Xavier Garreau <x.garreau@prim-time.fr>
CC: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Accessing HCI on Windows
References: <405FFCB9.5050507@uni-paderborn.de> <1080040266.2663.317.camel@pegasus> <021901c410d8$724c2630$b67ba8c0@zaz1> <4060660E.5050004@uni-paderborn.de> <030001c410f8$62945a80$b67ba8c0@zaz1>
In-Reply-To: <030001c410f8$62945a80$b67ba8c0@zaz1>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>



Xavier Garreau schrieb:

>Yes ! That's it ! But Widcomm drivers do not work this way.
>  
>
>No those from Com1 (http://www.com1.fr)
>
>  
>
But the Com One drivers ARE Widcomm drivers. So where is the difference?

Anyway I tried to install the Com One drivers by outcommenting the 
"ExcludeFromSelect" in the .inf file. As a result, the driver 
installation doesn't recognize the fake, but when I try to start the 
Bluetooth Software it says "Your Bluetooth license does not include use 
with this Bluetooth device". After clickeng "Ok" it asks for a license 
file. The license file from my original drivers does not work (version 
differs?). So how can I do it?

Kind regards
Stefan
