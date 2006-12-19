Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4587DAEC.8000603@glidos.net>
Date: Tue, 19 Dec 2006 12:28:28 +0000
From: Paul Gardiner <osronline@glidos.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4587BB0E.2070909@glidos.net> <1166523629.29972.18.camel@violet>
In-Reply-To: <1166523629.29972.18.camel@violet>
Subject: Re: [Bluez-users] hcid.conf seemingly ignored
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
> Hi Paul,
> 
>> I had my server (running SuSE 10.1) set up as a gateway for my PDA
>> following the advice in: 
>> http://wiki.xda-developers.com/index.php?pagename=bluetoothnetworking
>>
>> I've just swapped over to SuSE 10.2 which has bluesz 3.7-14 and
>> the set up no longer works.
>>
>> hciconfig says:
>>
>> hci0:   Type: USB
>>          BD Address: 00:09:DD:50:47:BB ACL MTU: 384:8 SCO MTU: 64:8
>>          UP RUNNING PSCAN
>>          RX bytes:401 acl:0 sco:0 events:18 errors:0
>>          TX bytes:317 acl:0 sco:0 commands:17 errors:0
>>
>> with ISCAN missing, although my hcid.conf file has  "iscan enable".
 >
> to make this work you need to set discovto to 0, because otherwise hcid
> will automatically switch you device into non-discoverable mode to
> protect you.
> 
> You can of course install bluez-gnome and use bluetooth-properties to do
> this configuration with a shiny UI.

I can't get that to work. It seems very flaky. Sometimes I get INQUIRY
instead of PSCAN. Other times I get nothing.  I think the SuSE 10.2
installation may be messed up.  I've installed it on two computers
and had the same problems.

For now I seem to be able to at least make progress by issuing:

   hciconfig hci0 auth encryt

and

   hciconfig hci0 piscan

at least then my PDA can find the device.  I then run into another
problem with dund, which I'll ask about in a new thread.

Thanks for your help, anyway.

Cheers,
	Paul.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
