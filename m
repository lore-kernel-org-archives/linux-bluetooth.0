Return-Path: <schmidt@nue.et-inf.uni-siegen.de>
Message-ID: <3FE6021B.2010702@nue.et-inf.uni-siegen.de>
Date: Sun, 21 Dec 2003 21:27:07 +0100
From: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluepin with SuSE 9.0
References: <3FE5D72B.2000108@nue.et-inf.uni-siegen.de> <1072032518.2684.90.camel@pegasus>
In-Reply-To: <1072032518.2684.90.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel, All,

Unfortunately, I neither have the time nor the equipment to test this 
script with other distributions. It's just the result of my playing 
around of this afternoon.
So I ask other people on the mailing list to test the script with other 
distributions. My thoughts for using this script and modifications were:

1.
The current script in bluez-utils cvs leads to an internal python 
version mismatch when used with SuSE (I remember that the details were 
outlined some time ago on the list). This script 
(http://bluez.sourceforge.net/download/bluepin) works with the python 
version in SuSE.

2.
When "import gtk" is put behind "set display ()" (rather than before), 
the "could not open display" error message goes away (but see also below).

3.
The replacement of the "if arg[i][0] != '-' and i==1:" line with
"if i==1 and arg[i][0] == ':':" is proposed as SuSE patch by Jean-Marc 
Autxier and others. Using the initial line also leads to the "could not 
open display" error message.
I dont know whether this patch is a SuSE-only solution or it can be 
applied generally.


As you can easily see, I don't understand much of python/gtk/XFree 
programming. I hope this patch is useful anyway.



Cheers,

Michael



Marcel Holtmann schrieb:

> Hi Michael,
> 
> 
>>I think I have a working 'bluepin' script (the one which is responsible 
>>for the PIN entry GUI during pairing) for SuSE 9.0, which hopefully 
>>addresses all the problems several folks have suffered from in the last 
>>weeks. The Script is attached to this note.
>>
>>I have made the following changes to the script from 
>>http://bluez.sourceforge.net/download/bluepin:
>>
>>- moved the "import gtk" statement behind the "set_display ()" call
>>   (as this is the case in the current script in cvs).
>>- replaced the "if arg[i][0] != '-' and i==1:" line with
>>   "if i==1 and arg[i][0] == ':':"
>>   (as proposed by Jean-Marc Autexier
>>    http://www.autexier.de/jmau/linux/Bluetooth.html
>>    and others)
>>
>>Furthermore, the following packages need to be present on the SuSE 9.0 
>>box (which are normally not installed):
>>
>>- python-gtk (bindings)
>>- python-numeric
>>
>>These changes may apply accordingly to earlier versions of SuSE Linux, 
>>too (I have observed similar problems with 'bluepin' in SuSE 8.x, too).
>>
>>
>>Maybe someone out of the BlueZ community may put this script on his web 
>>site for the public (my institute home page won't live very much longer).
> 
> 
> My plan is to make a last bluez-utils release for this version of the
> Bluetooth library. It should address exactly these problems with the
> pin_helper. Please send me confirmations that these modification are
> working fine on other distributions.
> 
> Regards
> 
> Marcel
> 
> 


-- 
=================================================
Michael Schmidt
-------------------------------------------------
Institute for Data Communications Systems
University of Siegen, Germany
-------------------------------------------------
http:   www.nue.et-inf.uni-siegen.de/~schmidt/
e-mail: schmidt@nue.et-inf.uni-siegen.de
mobile: +49 179 7810214
=================================================
