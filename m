Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4214975C.7000808@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm question 3
References: <20050217053715.12789.qmail@web60907.mail.yahoo.com>
In-Reply-To: <20050217053715.12789.qmail@web60907.mail.yahoo.com>
Content-Type: text/plain; charset=Big5
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 17 Feb 2005 14:08:44 +0100

Ka Kin Cheung wrote:
> Hi all!
>     I'm still doing my project. Now I face a problem
> that the T610 still cannot connect to PC. Then my
> tutor said that I have to write a sdp program to let
> the phone to connect to PC.

this has nothing to do with it. i think you tutor is wrong...
if your pc is listening on a rfcomm channel, then you can connect with a
url like btspp://0123456789AB:4
the first part is the protocol, the second the mac address, the last one
the channel number.
have you tried/understood my last post to you:
http://sourceforge.net/mailarchive/message.php?msg_id=10756581

you need a sdp-entry only if the mobile phone wants to do a service search
(paging) what's not needed. a inquiry could get you the mac address and you
then can connect to the listening port in your program.

if it still doesn't work, please send a description of what you exactly do
and what the exact results are. please use hcidump as well...

regards
Marco


> I wish to know that is
> there any guideline or even the source code for sdp
> programming? It is urgent as my tutor said he used two
> months to do it before. 
>     Thank you very much for your kindness.
> Michael
> 
> 
> _______________________________________________________________________
> 新年願望第一位 : 找到友緣人
> http://personals.yahoo.com.hk
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
