Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44CE11FA.7020302@kernelconcepts.de>
Date: Mon, 31 Jul 2006 16:21:46 +0200
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <20060727083312.81035.qmail@web27915.mail.ukl.yahoo.com>
	<1154177867.25939.15.camel@localhost>
In-Reply-To: <1154177867.25939.15.camel@localhost>
Subject: Re: [Bluez-users] can't connect EPOX Keyboard BT-KB01B
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

Marcel Holtmann schrieb:
> Hi Wolfram,
Hi!

>> I'm trying to connect my EPOX Buetooth Keyboard BT-KB01B but without success so far. The error message is:
>>  hcitool conf
>> Connections:
>>         > ACL 00:04:61:81:F7:C8 handle 44 state 1 lm SLAVE
>>         < ACL 00:04:61:82:03:4A handle 41 state 1 lm MASTER
>> root@woraBox:/home/rw024419# hidd --connect 00:04:61:82:03:4A
>> Can't create HID control channel: Connection timed out
> 
> how many times do I have to mention this. Include "hcidump -X -V" output
> or nobody will ever will be able to help you.

Probably make it as default for hcidump and let "-X" and "-V" turn it off?

> Regards
> Marcel
Cheers
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
--

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
