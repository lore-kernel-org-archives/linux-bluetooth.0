Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4293520A.9010303@bungtopia.com>
From: michael <michael@bungtopia.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <5256d0b050514160856c4d194@mail.gmail.com>	 <1116112975.8886.25.camel@pegasus>	 <5256d0b05051416323a633e2d@mail.gmail.com>	 <1116115930.8886.27.camel@pegasus>  <428A0F38.5050902@bungtopia.com> <1116366629.10063.119.camel@pegasus>
In-Reply-To: <1116366629.10063.119.camel@pegasus>
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
Date: Wed, 25 May 2005 01:40:50 +0930

Thanks for that. I think I have code that will work now. This is the 
line that I pass to the hci_read_rssi() method: 
hci_read_rssi(client_sock, htobs(rfconn.hci_handle), &rssi, 25000)

My app doesn't have fancy error messages so I spent ages trying to work 
out why it doesnt work, no luck, but  rctest gives the error "Can't get 
RFCOMM connection information: Protocol not available (92)"

Do you know what can cause this error, or give me a head start on how to 
track it down?

Im using a complete install of fedora core 3

Thank you
-michael

Marcel Holtmann wrote:

>Hi Michael,
>
>  
>
>>I'm using pretty standard sockets to create a bluetooth connection. I 
>>can communicate fine with my J2ME app however I was wondering if it is 
>>at all possible to read the RSSI from an RFCOMM layer connection. I can 
>>read it fine if I make a lower level connection, but this is not at all 
>>suited to my application..
>>
>>So, how can I read the RSSI when I dont have access to all the data I 
>>need to pass to the hci_read_rssi() method??
>>    
>>
>
>you only need the ACL connection handle and you can get this with a
>getsockopt() call through RFCOMM. Check rctest for an example.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by Oracle Space Sweepstakes
>Want to be the first software developer in space?
>Enter now for the Oracle Space Sweepstakes!
>http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>  
>




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
