Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40926BAF.1040604@yahoo.com.au>
From: pro <redirect888-public@yahoo.com.au>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] can't get bthid
References: <408C4D8D.7090104@yahoo.com.au> <1082937237.28880.109.camel@pegasus>
In-Reply-To: <1082937237.28880.109.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 01 May 2004 01:07:27 +1000

thanks ... both keyboard and mouse are working fine now.

The fn key doesn't seems to work thou.

also i noticed that when i run hid2hci, it doesn't always switch the 
dodgle from hid to hci.
Sometimes i have to run it 2nd time to get it to work.

>Hi,
>
>  
>
>>    The problem i'm having is i get the follow error when i try to start 
>>bthid,
>>
>>Can't connect to HID service: No such file or directory
>>    
>>
>
>you must start a bthid daemon instance with "bthid -d" first.
>
>  
>
>>Now the bluetooth i'm using is the logitech MX900 with the logitech 
>>bluetooth dodge. The software i'm using are lib2 and utils2 both from 
>>the cvs. I managed to get hid2hci working and from the 
>>/proc/bus/usb/devices i can tell the hub is in bluetooth mode. Running 
>>"hciconfig hci0 up" to bring the bluetooth interface up, which works 
>>fine. "hcid" also ran fine. I could manually linked up the mouse with 
>>the hub by using "hcitool cc <mouse address>". Other command such as 
>>"hcitool scan" "hcitool inq" all works fine.
>>    
>>
>
>Don't play with "hcitool cc". The HCI connection is created automaticly
>when needed.
>
>Regards
>
>Marcel
>  
>


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
