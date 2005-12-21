Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43A95B0B.2040909@in.tum.de>
From: Aleksandar Kanchev <kanchev@in.tum.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] connectionless L2CAP
References: <43A94B7B.70906@in.tum.de> <1135169114.26233.66.camel@localhost>
In-Reply-To: <1135169114.26233.66.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 21 Dec 2005 14:39:23 +0100

Hello Marcel,

I'm actually trying to send a data packet between 2 bluetooth devices 
over 100 meters. I haven't went really deep into the bluetooth specs, 
but I assume that because of the long range a connection might not be 
possible, so that's why I just want to broadcast some packets and hope 
that some will arrive at the other end. Is this possible ?

Btw./l2test with 00:00:00:00:00:00 fails too, but the bluetooth baseband 
specification section 3.3 says that "ACL packets not addressed to a 
specific slave are considered as broadcast packets and are read by every 
slave". I have 1 device in range (I can see it with hcitool scan, l2test 
succeeds with that device).

Thanks

Marcel Holtmann wrote:

>Hi Aleksandar,
>
>  
>
>>how can I broadcast a data packet ?
>>And the connectionless mode of the l2test isn't actually connectionless, 
>>for example:
>>$ ./l2test -D -N 1 -s 00:04:3E:81:14:F8
>>l2test[1279]: Can't connect: Host is down (112)
>>
>>I just want to broadcast a data packet and I don't care if the remote 
>>end got it or not (i.e. connectionless ACL). Will someone  please 
>>explain me how can I do that and also a programming example would be great.
>>    
>>
>
>this is not really working, because if there is no ACL link, then there
>exists no piconet. And without a piconet no air transmission.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
>for problems?  Stop!  Download the new AJAX search engine that makes
>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>  
>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
