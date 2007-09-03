Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46DBE94E.1070509@kameleon-media.com>
Date: Mon, 03 Sep 2007 13:00:30 +0200
From: Laurent BARBIER <lbarbier@kameleon-media.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <46B0A557.9080000@kameleon-media.com>
	<1186856876.6698.48.camel@violet>
In-Reply-To: <1186856876.6698.48.camel@violet>
Subject: Re: [Bluez-users] Problem building a piconet with pand
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Thanks for the answer :)

I'm back from vacancies and i solved my problem a few hours after =

posting. my problem was in fact that i didn't specified on the piconet =

master to be master on the bluetooth connection. (--master flag).

For the 3.14 version, i currently can't upgrade to this version, i'm =

using bluez on an embedded device and currently it does not support the =

last bluez lib. (cross compile, kernel...)

Laurent

Marcel Holtmann a =E9crit :
> Hi Laurent,
>
>   =

>> I'm actually working on a project where I need embedded devices to
>> communicate between them. We decided to use bluetooth dongles and pan
>> to build a piconet.
>> Actually this work fine when we have only 3 devices : 1 GN & 2 PANU
>> (PANU#1 & PANU#2). When we try to add a third PANU (PANU#3), pand say
>> the host is down. If I shut down the connection of one of the two
>> thers PANU, I'm able to establish a connection with PANU#3 to the GN.
>> I try to setup a different GN on a linux desktop, same result, 1 GN &
>> 2 PANU.
>>
>> On my server I do this : =

>> pand --listen --nosdp --role GN -i yy:yy:yy:yy:yy:yy
>> I use brctl on the GN to bridge the interface
>>
>> On my clients I do this :
>> pand --nodetach -i xx:xx:xx:xx:xx:xx --role PANU --connect
>> yy:yy:yy:yy:yy:yy
>>
>> On connected PANU i have :
>> pand[7334]: Bluetooth PAN daemon version 2.25
>> pand[7334]: Connecting to yy:yy:yy:yy:yy:yy
>> pand[7334]: bnep0 connected
>>
>> On PANU's I can't connect:
>> pand[8492]: Bluetooth PAN daemon version 2.25
>> pand[8492]: Connecting to yy:yy:yy:yy:yy:yy
>> pand[8492]: Connect to yy:yy:yy:yy:yy:yy failed. Host is down(112)
>>
>>
>> I have read & reread the HOWTO-PAN. I mainly used it to setup my pan.
>> I know there is a limitation of 7 PANU max but there I'm far away of
>> the 7 devices. Is there is something I have forgotten ?
>> misconfigured  ... ? A problem with my dongles ?
>> If anyone could help me
>>     =

>
> your version of pand is ancient. Install bluez-utils-3.14.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>   =


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
