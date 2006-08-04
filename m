Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Bearcat M. Sandor" <Bearcat@feline-soul.com>
To: Marcel Holtmann <marcel@holtmann.org>
Date: Fri, 4 Aug 2006 11:29:58 -0600
References: <200608031855.50972.Bearcat@feline-soul.com>
	<1154686183.3905.84.camel@aeonflux.holtmann.net>
In-Reply-To: <1154686183.3905.84.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-Id: <200608041129.59081.Bearcat@feline-soul.com>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users]  error when starting bluetooth..any ideas?
Reply-To: Bearcat@feline-soul.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

Marcel,

Thanks. This may be the root of my problems. I'll wait till the next version 
to play with all this again. Any ideas when it may be out?

Bearcat M. Sandor
On Friday 04 August 2006 04:09 in an email titled "Re: [Bluez-users] error 
when starting bluetooth..any ideas?" Marcel Holtmann wrote:
>Hi Bearcat,
>
>> I'm still working on connecting this keyboard and headset. However i
>> noticed something in my logs that is probably pertainent:
>> Aug  3 18:42:53 [sdpd] Bluetooth SDP daemon_
>> Aug  3 18:43:59 [hcid] Bluetooth HCI daemon
>> Aug  3 18:43:59 [hcid] Register path:/org/bluez fallback:1
>> Aug  3 18:43:59 [hcid] Device hci0 has been added
>> Aug  3 18:43:59 [hcid] Starting security manager 0
>> Aug  3 18:43:59 [hcid] Can't write inquiry mode for hci0: Input/output
>> error (5)
>> Aug  3 18:43:59 [hcid] Register path:/org/bluez/hci0 fallback:0
>> Aug  3 18:44:38 [hidd] Bluetooth HID daemon
>>
>> Note the [hcid} lines seem to have an error. I have looked all over google
>> and the bluetooth mailing lists and not found anything regarding it.
>
>looks like some chips get confused when trying to set the inquiry mode
>and they don't support this command. It has been fixed in the CVS now.
>
>Regards
>
>Marcel

-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor
Jabber: bearcatsandor@jabber.org


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
