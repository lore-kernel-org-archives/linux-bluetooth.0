Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44954A42.6000502@stfw.eu>
Date: Sun, 18 Jun 2006 13:42:42 +0100
From: Zhares <ml-sourceforge@stfw.eu>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <448DB88D.8080306@stfw.eu>	<1150540347.17539.28.camel@aeonflux.holtmann.net>	<4494238A.1050007@stfw.eu>
	<1150614805.4109.20.camel@aeonflux.holtmann.net>
In-Reply-To: <1150614805.4109.20.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] hidd error 14 (Bad address) on ubuntu ppc
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> Hi,
> 
>> Hi, thanks for investigate my problem. I've put the result of hcidump 
>> here: http://stfw.eu/hcidump-X-V.txt
>>
>> Here is the command I did and the result:
>> root@Monster:~# hidd --connect 00:0A:95:3A:CA:44
>> HID create error 14 (Bad address)
>> root@Monster:~#
>>
>> Here what was writen in syslog (only one line):
>> Jun 17 16:20:16 localhost hidd: New HID device 00:0A:95:3A:CA:44 (Apple 
>> Wireless Keyboard)
> 
> make sure that the hidp kernel module is loaded.

Hi. Yes, the hidp module is loaded:

root@Monster:~# lsmod |grep hidp
hidp                   48192  2
l2cap                  41120  10 rfcomm,hidp
bluetooth              82596  8 hci_usb,rfcomm,hidp,l2cap

Do you know what 'Bad address' can be? is it address of a device, or 
address of a pointer?
Also, I suppose that some kind of /dev/input/something is created by 
hidd so that xfree can read it but nothing appears.

Thanks again.

-- 
	
	Zhares


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
