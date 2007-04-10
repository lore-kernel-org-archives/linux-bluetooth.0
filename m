Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <60881.80.109.89.243.1176233471.squirrel@webmail.uni-ak.ac.at>
In-Reply-To: <1176214966.18096.2.camel@violet>
References: <62204.80.109.89.243.1176201047.squirrel@webmail.uni-ak.ac.at>
	<1176214966.18096.2.camel@violet>
Date: Tue, 10 Apr 2007 21:31:11 +0200 (CEST)
From: gerhard.ramsebner@uni-ak.ac.at
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Bluez-users] RecHandle
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

>> I'm writing start/stop scripts for bluetooth services.
>> Assuming I want to run several servises of the same type and stop them
>> later on. How can I make a difference between the related sdpd records
>> easily? Unfotunately  'sdptool add' does not provide the RecHandle.
>
> don't even do it this way. The services should register the records by
> themself and all of the ones included in bluez-utils do so.
>

Well, rfcomm does not. Or is there something wrong with mine?


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
