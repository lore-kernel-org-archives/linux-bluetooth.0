Return-Path: <cyrus@holtmann.org>
Message-Id: <B62B87AD-F178-42F5-9DE7-FAF2DB186220@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20080326125015.60e5fa96@news01>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Wed, 26 Mar 2008 17:24:00 +0100
References: <5eee8c670802281451i392c0debq7a16286d76d33bfb@mail.gmail.com>
	<a8e1da0803021721m3145bc7fpd896760d4bed7d97@mail.gmail.com>
	<a8e1da0803021724h654f65ceif24b2035dc94a5ec@mail.gmail.com>
	<5eee8c670803030335v49536053j136b8b46addb8129@mail.gmail.com>
	<5eee8c670803031419k10c8e625p447f8f98ac27dcb9@mail.gmail.com>
	<5eee8c670803170528o44384744pe238c378953dbc02@mail.gmail.com>
	<a8e1da0803180014u262a7ee0h25ff58a0e6363dfd@mail.gmail.com>
	<5eee8c670803201019q4703c779wbb597b806cf4d7c@mail.gmail.com>
	<20080326125015.60e5fa96@news01>
Subject: Re: [Bluez-users] hciconfig hci0 reset bug
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

Hi Peter,

>> So, if I'm reading this correctly, you should issue the reset for all
>> CSR-based dongles with build id > 118.
>>
>> Am I on the right track here? Does this information look accurate  
>> to you
>> guys?
>
> This is basically correct in that the fix appeared in firmware  
> around then
> (the internal log says 117, but possibly that was never released--- 
> I've
> confined my search to the development side).
>
> However, it's not that simple in that releases of earlier firmware  
> branches
> were still being made for some time.  Our ID numbers increase  
> monotonically
> so these would have later numbers.  I haven't done an exhaustive  
> search;
> mostly these releases had L2CAP + RFCOMM on chip for embedded  
> applications,
> so you wouldn't care about them.  I don't see any evidence of a  
> later HCI
> release based on the old code, offhand (but don't take this as  
> gospel).

this is what Steven told me. We don't have to worry about the RFCOMM  
builds since they don't include a HCI interface.

> If you want to be quite sure not to pick up a build which didn't  
> have the
> fix for reset, you could restrict the change to BlueCore 2 and later  
> chips
> using the "bcget chipver" call.  The early branches without the fix
> only ever ran on BlueCore 1: the fix was made in major release 12 and
> BlueCore 2 first ran on major release 14.

No vendor specific setup/init quirks that would have to call vendor  
commands :)

Regards

Marcel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
