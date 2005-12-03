Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4391AECF.6010109@ncoretech.com>
From: Zaheer Ahamed <zaheer@ncoretech.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sdpd deamon fails to start.
References: <4391A0A9.5090706@ncoretech.com> <1133617090.31106.41.camel@blade> <4391A6DF.4090603@ncoretech.com>
In-Reply-To: <4391A6DF.4090603@ncoretech.com>
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
Date: Sat, 03 Dec 2005 20:12:23 +0530

Hello All,

After making the correction, the "sdpd" server starts up  successfully.
Now when I try out the commands with obexftp  I get the error below,
In the second case the device seems to get disconnected.

*obexftp -b -l /root*
Scanning ...
Using   00:0B:0D:61:79:BE       BlueZ (0)
Failed to connect to SDP server: Connection timed out

or
*obexftp -b -l*
Scanning ...
Using   00:0B:0D:61:79:BE       BlueZ (0)
usb.c: USB disconnect on device <NULL>-1 address 4
Failed to connect to SDP server: Software caused connection abort


A request to all for any step-by-step guide to Obexftp with Bluetooth.

Warm Regards,

Zaheer.





Zaheer Ahamed wrote:

> Thanks Marcell.
>
> Can anybody point out to a step-by-step guide to use Obex-Ftp.
>
> Warm Regards,
>
> Zaheer.
>
> Marcel Holtmann wrote:
>
>> Hi Zaheer,
>>
>>  
>>
>>> I have installed the bluez utilities on my embedded linux system.
>>> However when I start "sdpd" I get the following error.
>>>
>>> Jan 31 03:32:31 Simputer daemon.info hcid[1298]: Bluetooth HCI daemon
>>> Jan 31 03:32:31 Simputer daemon.info hcid[1298]: HCI dev 0 up
>>> Jan 31 03:32:31 Simputer daemon.info hcid[1298]: Starting security 
>>> manager 0
>>> Jan 31 03:32:33 Simputer daemon.err sdpd[1369]: init_server: binding 
>>> UNIX socket: No such file or directory
>>> Jan 31 03:32:33 Simputer daemon.err sdpd[1369]: main: Server 
>>> initialization failed
>>>   
>>
>>
>> it wants to create a Unix domain socket at /var/run/sdp and it must have
>> permissions for that.
>>
>> Regards
>>
>> Marcel
>>
>>
>>
>>
>> -------------------------------------------------------
>> This SF.net email is sponsored by: Splunk Inc. Do you grep through 
>> log files
>> for problems?  Stop!  Download the new AJAX search engine that makes
>> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
>>  
>>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log 
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
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
