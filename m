Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: sean <seandarcy2@gmail.com>
Date: Tue, 05 Jun 2007 08:46:07 -0400
Message-ID: <f43luf$sgg$1@sea.gmane.org>
References: <c195ebf70706050528x3a4e552fk691239352e3be787@mail.gmail.com>
	<1181047102.13429.101.camel@violet>
Mime-Version: 1.0
In-Reply-To: <1181047102.13429.101.camel@violet>
Subject: Re: [Bluez-users] logitech mx5000: Access denied: Authorization
	agent?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> Hi Sean,
> 
>> On FC7, bluez-3.11, trying to get the Logitech mx 5000 kbd
>> and mouse to work. I've had no luck.
>>
>> [root@testbox ~]# hcitool scan
>> Scanning ...
>> [root@testbox ~]# hidd --search
>> Searching ...
>>         No devices in range or visible
>>
>> But
>>
>> grep Logitech /var/log/messages
>> Jun  4 20:05:56 testbox kernel: input: Logitech Logitech BT
>> Mini-Receiver as /class/input/input3
>> Jun  4 20:05:56 testbox kernel: input: USB HID v1.11
>> Keyboard [Logitech Logitech BT Mini-Receiver] on
>> usb-0000:00:1d.0-2.2
>> Jun  4 20:05:56 testbox kernel: input: Logitech Logitech BT
>> Mini-Receiver as /class/input/input4
>> Jun  4 20:05:56 testbox kernel: input,hiddev96: USB HID
>> v1.11 Mouse [Logitech Logitech BT Mini-Receiver] on
>> usb-0000:00:1d.0-2.3
>>
>> however in syslog:
>>
>> Jun  4 21:11:17 testbox input[2308]: Access denied:
>> Authorization agent does not exist
>> Jun  4 21:12:12 testbox last message repeated 21 times
>> Jun  4 21:12:22 testbox last message repeated 8 times
>>
>> Is this my problem? If so, how do I set up an Authorization
>> agent??
>>
>> Or should I be looking somewhere else? For everyone else,
>> the MX 5000 Just Works :(
>>
>> bluez-utils-3.11-2.fc8.x86_64
>> bluez-utils-cups-3.11-2.fc8.x86_64
>> bluez-libs-3.11-1.fc8.x86_64
> 
> what is your version of bluez-gnome? Maybe that needs an update.
> 
> Regards
> 
> Marcel

bluez-gnome-0.6-2, which is the most recent on rawhide. 
FWIW, I started with bluez*3.9 from the fc7 install. That 
failed. Then upgraded to 3.11 from rawhide.

sean


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
