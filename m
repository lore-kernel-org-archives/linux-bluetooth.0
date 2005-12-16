Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43A27DFD.9070007@thomson.net>
From: Arnaud Mouiche <arnaud.mouiche@thomson.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Modify scotest?
References: <1513322956@web.de> <1134675751.12505.21.camel@localhost>
In-Reply-To: <1134675751.12505.21.camel@localhost>
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
Date: Fri, 16 Dec 2005 09:42:37 +0100

Using SCO for quality measurement is a good idea if your bluetouth 
device supports trasnparent audio, and if you configure them to use this 
mode. If not, you can still try a configuration like ulaw on air, ulaw 
on HCI (no conversion in theory)

In this case, write a tool like scotest that always send FF.FF.FF...FF 
frames (or anything you want) (write the same amount of data that you 
receive). Then juste count zeros bits to detect BER, and 00.00.00...00 
frames for PER.
Enjoy !

Arnaud

Marcel Holtmann wrote:

>Hi Wolfgang,
>
>  
>
>>I need to meassure the quality of a bluetooth SCO link, therefore I want to send a data file over a SCO Link like OBEX.
>>So I want to see whats transmitted on client side, comparing with the original file, for the purpose to detect bit errors a.s.o.
>>Is this possible with the scotest tool - actually it seems to me that I can only send a predetermined number of bytes through the SCO connection and receive them on the client side. 
>>Or am I wrong and there is another solution for my  project ?
>>    
>>
>
>don't use SCO channel for data transmission, period.
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
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>  
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
