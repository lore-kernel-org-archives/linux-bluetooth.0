Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY117-F28984EE21F82A8C663968FBF800@phx.gbl>
In-Reply-To: <2e9fc96f0701262232t10d635cl450acb9e74133644@mail.gmail.com>
From: "Kelvin Xu" <kyoxu@hotmail.com>
To: bluez-users@lists.sourceforge.net
Subject: RE: [Bluez-users]Re: [Bluez-users] 回覆： Re: pin code
Date: Thu, 01 Mar 2007 15:18:08 +0800
Mime-Version: 1.0
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1380284354=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1380284354==
Content-Type: text/plain; format=flowed


Hi,

i am faced with the sam problems as KS H. I have also cross compiled dBus 
and Bluez Util for ARM using Scratchbox.
I followed the similar steps provided by Prabhu. However, I do not have the 
message.pid entry in /var/run but have an additional "pid" entry in 
/var/run/dbus.

And when i try to execute hcid i received the following error:
# hcid -n -f /etc/bluetooth/hcid.conf
hcid[790]: Bluetooth HCI daemon
hcid[790]: Can't open system message bus connection: Failed to connect to 
socket /var/run/dbus/system_bus_socket: Connection refused
hcid[790]: Unable to get on D-Bus

Please advice. Thank you

Regards,
Kelvin


>From: "Prabhu nath" <gprabhunath@gmail.com>
>Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
>To: "BlueZ users" <bluez-users@lists.sourceforge.net>
>Subject: [Bluez-users]Re: [Bluez-users] 回覆： Re: pin code
>Date: Sat, 27 Jan 2007 12:02:33 +0530
>
>On 1/26/07, KS H <kspam1234@yahoo.com.hk> wrote:
>>
>>Hi
>>
>>I follow the configure described. When I execut 'dbus-daemon --system'
>>it return
>>
>>Failed to start message bus: Could not get UID and GID for username
>>"messagebus"
>>What is that mean?
>
>
><prabhu> U have to create a username by name *messagebus* <prabhu>   #
>adduser -D -H messagebus
>
>and also there is no blue-hcid.conf in hcid folder
>>but I found a file call bluetooth.conf. is that the same file you said
>
>
><prabhu> Sorry it is bluez-hcid.confRegards
>
>SH
>*Prabhu nath <gprabhunath@gmail.com>* 說：
>
>>  You have to cross-compile dbus-1.0, and start dbus-daemon before
>>executing hcid.
>>dbus-daemon --system
>>
>>While cross-compiling dbus-1.0 and bluez-utils, pass the following
>>parameters for the configure script.
>>--localstatedir=/var --sysconfdir=/etc
>>
>>Once you do this, by default hcid will look for hcid.conf in
>>/etc/bluetooth directory.
>>
>>
>>*Warning*. Take a backup of /etc/dbus-1 and /etc/bluetooth, because this
>>will overwrite the previous config, which was already present in ur 
>>system.
>>
>>Run make install for dbus, and u need not run make install for
>>bluez-utils. U can directly copy the hcid.conf and blue-hcid.conf to
>>/etc/bluetooth and /etc/dbus-1/system.d directory respectively.
>>
>>Now, when u start dbus-daemon --system, it will create a system_bus_socket
>>in /var/run/dbus and it will create a message.pid in /var/run/.
>>
>>next, when u start hcid, u should not get problem.
>>
>>-Prabhu
>>
>>
>>
>>
>>On 1/23/07, KS H <kspam1234@yahoo.com.hk> wrote:
>> >
>> > Dear
>> >
>> > I cross compile the bluez3.8 and try to setup the bluetooth in arm. I
>> > connect the arm with CSR BC03 with BCSP configuration. I am able to 
>>make the
>> > Bluez discoverable and try to pair bluez. however i found that there is 
>>no
>> > pin respond from Bluez. So i try to configure bluez using hcid.
>> >
>> > > hcid -n -f /etc/bluetooth/hcid.conf
>> >
>> > it return
>> >
>> > hcid[481]: Can't connect to system message bus: Failed to connect to
>> > socket /usr/local/var/run/dbus/system_bus_socket:  No such file or 
>>directory
>> >
>> > hcid[481]: Unable to get on D-Bus
>> >
>> > My question
>> > 1. where can I found the missing file and what is that used for?
>> > 2. Is there any method to repsond the pin request other than using hcid
>> >
>> > Regards
>> > SH
>> > _______________________________________
>> > YM - 離線訊息
>> > 
>>就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。
>> > http://messenger.yahoo.com.hk
>> >
>> >
>> > 
>>-------------------------------------------------------------------------
>> > Take Surveys. Earn Cash. Influence the Future of IT
>> > Join SourceForge.net's Techsay panel and you'll get the chance to share
>> > your
>> > opinions on IT & business topics through brief surveys - and earn cash
>> >
>> > 
>>http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>> >
>> > _______________________________________________
>> > Bluez-users mailing list
>> > Bluez-users@lists.sourceforge.net
>> > https://lists.sourceforge.net/lists/listinfo/bluez-users
>> >
>> >
>> >
>>-------------------------------------------------------------------------
>>Take Surveys. Earn Cash. Influence the Future of IT
>>Join SourceForge.net's Techsay panel and you'll get the chance to share
>>your
>>opinions on IT & business topics through brief surveys - and earn cash
>>
>>http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV_______________________________________________
>>Bluez-users mailing list
>>Bluez-users@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>>
>>_______________________________________
>>YM - 離線訊息
>>就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。
>>http://messenger.yahoo.com.hk
>>
>>-------------------------------------------------------------------------
>>Take Surveys. Earn Cash. Influence the Future of IT
>>Join SourceForge.net's Techsay panel and you'll get the chance to share
>>your
>>opinions on IT & business topics through brief surveys - and earn cash
>>http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>>
>>_______________________________________________
>>Bluez-users mailing list
>>Bluez-users@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>>
>>


>-------------------------------------------------------------------------
>Take Surveys. Earn Cash. Influence the Future of IT
>Join SourceForge.net's Techsay panel and you'll get the chance to share 
>your
>opinions on IT & business topics through brief surveys - and earn cash
>http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV


>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
Get an advanced look at the new version of Windows Live Messenger. 
http://get.live.com/messenger/overview



--===============1380284354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1380284354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1380284354==--
