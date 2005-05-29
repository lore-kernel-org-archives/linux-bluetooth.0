Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <429996F9.6000700@bungtopia.com>
From: michael <michael@bungtopia.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <5256d0b050514160856c4d194@mail.gmail.com>	 <1116112975.8886.25.camel@pegasus>	 <5256d0b05051416323a633e2d@mail.gmail.com>	 <1116115930.8886.27.camel@pegasus>  <428A0F38.5050902@bungtopia.com>	 <1116366629.10063.119.camel@pegasus>  <4293520A.9010303@bungtopia.com>	 <1116954340.30044.151.camel@pegasus>  <4293F272.2040504@bungtopia.com> <1117012660.30044.201.camel@pegasus>
In-Reply-To: <1117012660.30044.201.camel@pegasus>
Subject: Re: [Bluez-devel] RSSI from rfcomm
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 29 May 2005 19:48:33 +0930

Marcel Holtmann wrote:

>Hi Michael,
>
>  
>
>>>>Thanks for that. I think I have code that will work now. This is the 
>>>>line that I pass to the hci_read_rssi() method: 
>>>>hci_read_rssi(client_sock, htobs(rfconn.hci_handle), &rssi, 25000)
>>>>
>>>>My app doesn't have fancy error messages so I spent ages trying to work 
>>>>out why it doesnt work, no luck, but  rctest gives the error "Can't get 
>>>>RFCOMM connection information: Protocol not available (92)"
>>>>
>>>>Do you know what can cause this error, or give me a head start on how to 
>>>>track it down?
>>>>
>>>>Im using a complete install of fedora core 3
>>>>        
>>>>
>>>maybe your kernel is too old. I added that feature to RFCOMM very late.
>>>
>>>      
>>>
>>What version do I need to use this feature??
>>
>>I'm using version 2.6.9-1.667
>>    
>>
>
>the first kernel would be 2.6.11 or 2.6.10-mh4.
>
>Regards
>
>Marcel
>
I have upgraded to 2.6.11. Now getsockopt() works ok, but I can't call 
hci_read_rssi() without errors! It still says protocol not available.Is 
there another way to read the RSSI from RFCOMM?

If anyone is interested in looking over my code - please let me know.

Any help is greatly appreciated..

Thank you



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
