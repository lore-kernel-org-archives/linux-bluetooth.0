Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4519C072.9010003@ibdcon.org.br>
Date: Tue, 26 Sep 2006 21:06:10 -0300
From: Paulo Wollny <paulo.wollny@ibdcon.org.br>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45198820.8060701@ibdcon.org.br>	<1159301349.800.26.camel@localhost>
	<45198F20.6040504@ibdcon.org.br>	<1159304274.800.33.camel@localhost>
	<451996AE.8040207@ibdcon.org.br>
	<1159312090.800.48.camel@localhost>
In-Reply-To: <1159312090.800.48.camel@localhost>
Subject: Re: [Bluez-users] bluez-utils 3.5 and pairing
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

Hi Marcel,
ok, but i do have the entry security auto; in the hcid.conf file.
Regards,
Paulo

Marcel Holtmann schrieb:
> Hi Paulo,
>
>   
>> the output of the log/messages for the transaction was:
>>
>> Sep 26 17:28:24 hirschberg hcid[25949]: name_listener_add(:1.358)
>> Sep 26 17:28:24 hirschberg hcid[25949]: Adding match rule
>> "interface=org.freedesktop.DBus,member=NameOwnerChanged,arg0=:1.358"
>> failed: Unknown key "arg0" in match rule
>> Sep 26 17:28:24 hirschberg hcid[25949]: Default passkey agent (:1.358,
>> /org/bluez/passkey_agent_30629) registered
>> Sep 26 17:29:07 hirschberg sudo:    paulo : TTY=pts/1 ; PWD=/home/paulo
>> ; USER=root ; COMMAND=/usr/sbin/hcidump -X -V
>> Sep 26 17:30:03 hirschberg hcid[25949]: pin_code_request
>> (sba=00:0C:55:F9:7D:6D, dba=00:05:16:5B:17:2C)
>> Sep 26 17:30:53 hirschberg syslog-ng[5024]: STATS: dropped 0
>> Sep 26 17:36:21 hirschberg hcid[25949]: name_listener_remove(:1.358)
>> Sep 26 17:36:21 hirschberg hcid[25949]: remove_name_listener: no
>> listener for :1.358
>> Sep 26 17:36:21 hirschberg hcid[25949]: Default passkey agent (:1.358,
>> /org/bluez/passkey_agent_30629) unregistered
>>
>> As seen, the passkey-agent was registered....
>>     
>
> I overlooked that in the first place. Since this is an incoming security
> mode 3 connection you need to set "security user" in hcid.conf to make
> it use the passkey agent. I assumed that was default, but actually it
> was not. Which is fixed now.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>   


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
