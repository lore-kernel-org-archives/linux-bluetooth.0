Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43A08642.5010300@rumms.uni-mannheim.de>
From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@rumms.uni-mannheim.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Reading RSSI of non-connected devices
References: <4396F911.40705@rumms.uni-mannheim.de>	 <1133968124.3752.35.camel@blade>  <43970C1E.6020602@rumms.uni-mannheim.de>	 <1133973783.3752.47.camel@blade>  <43A03888.5010105@rumms.uni-mannheim.de>	 <1134573996.11064.56.camel@wyatt.hadess.net>	 <43A04C03.9030907@rumms.uni-mannheim.de> <1134580628.10473.8.camel@localhost>
In-Reply-To: <1134580628.10473.8.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Wed, 14 Dec 2005 21:53:22 +0100

Marcel Holtmann schrieb:

>Hi Andreas,
>
>  
>
>>>As Marcel mentioned earlier, the easiest is to use the D-Bus services in
>>>hcid to do that.
>>>
>>>      
>>>
>>He didn't. He said the safe way would be to use raw HCI sockets and (in 
>>other words) that the D-Bus interface was unstable. Also, I am currently 
>>testing this on desktop and notebook machines but it was actually 
>>supposed to run on mobile devices (Zaurus) where we would not be able to 
>>update the kernel and require the latest D-Bus/BlueZ interfaces.
>>    
>>
>
>the D-Bus interface has nothing to do with used kernel.
>
>  
>
>>Nontheless we will evaluate D-Bus, but for the time being my boss is 
>>content with HCI sockets under root account.
>>I'm familiar with socket programming in general but haven't used D-Bus 
>>before and so we are worried whether introducing another layer such as 
>>D-Bus might be of disadvantage for our software which needs non-cached 
>>data, nearly in realtime (just as with HCI sockets). The D-Bus page 
>>itself says it's not stable yet and I did not find documentation on how 
>>to use it with BlueZ. The BlueZ library was very helpful in getting my 
>>code to work, whereas I have no clue on where to find any such hints for 
>>D-Bus both in the BlueZ 2.22 downloads and in the 2.6.13.4 kernel which 
>>were the latest respectively when I downloaded them some weeks ago. I 
>>can only guess from the examples at freedesktop.org that it'll be 
>>/org/bluez/something.
>>    
>>
>
>The D-Bus interface works quite good, but I won't guarantee a stable API
>at the moment. If needed, I am going to break it.
>  
>
Yes, that's exactly how I understood your earlier post.

But that does not give me any clue on how to use D-Bus either. I've seen 
through the D-Bus specification, but it does not define anything 
BlueZ-specific and I couldn't find anything related to D-Bus on the 
BlueZ.org or Holtmann.org pages. Again, I have no clue on where to start 
learning about specifically the BlueZ D-Bus interfaces - what path and 
properties etc I can use with D-Bus to access the information we need.

Andreas



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
