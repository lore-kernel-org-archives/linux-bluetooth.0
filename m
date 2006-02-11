Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43EE5B20.2090200@cs.bgu.ac.il>
From: Niv <nivv@cs.bgu.ac.il>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] proximity monitor
References: <Pine.LNX.4.44.0602082342210.13414-100000@lvs-rs3>
In-Reply-To: <Pine.LNX.4.44.0602082342210.13414-100000@lvs-rs3>
Content-Type: text/plain; charset=windows-1255; format=flowed
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
Date: Sat, 11 Feb 2006 23:46:08 +0200

Thanks ppl for the new 0,25 version
the formar used to drop rssi after two minutes from above zero to minus.
now I am getting a stady signal

Niv


NIV VAIZER wrote:

>10x mate
>
>any other clever tricks you are aware of?
>
>Niv
>
>
>On Tue, 7 Feb 2006, Marcel Holtmann wrote:
>
>  
>
>>Hi Niv,
>>
>>    
>>
>>>One of the cool tricks BT could be used for is the proximity monitor.
>>>MonkeyBox 
>>><http://gentoo-wiki.com/index.php?title=User:MonkeyBox&action=edit> 
>>>wrote this: http://gentoo-wiki.com/TIP_Bluetooth_Proximity_Monitor
>>>
>>>which basically pools my cellular for RSSI. if my RSSI decreases, It 
>>>"know" I am leaving the pc.
>>>I was wondering if its possible to receive these RSSI indications in an 
>>>event driven manner , thus, reducing the pooling work.
>>>      
>>>
>>no. You have to be connected to that device or you need a device that is
>>discoverable and a local dongle with Inquiry with RSSI support.
>>
>>Regards
>>
>>Marcel
>>
>>    
>>
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
>for problems?  Stop!  Download the new AJAX search engine that makes
>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>  
>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
