Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45E2A6C5.3070205@pracucci.com>
Date: Mon, 26 Feb 2007 09:22:13 +0000
From: Marco Pracucci <development@pracucci.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45DECF51.2020901@pracucci.com> <1172447493.20450.17.camel@violet>
In-Reply-To: <1172447493.20450.17.camel@violet>
Subject: Re: [Bluez-users] Timeout on sdp_connect()
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
>> I would like to set a timeout on sdp_connect(), because the default 
>> socket timeout is too high for my application. Is there any way to do it?
>>     
>
> my guess is that you wanna modify the page timeout. Look up on that.
>   
No.
Sometimes it happens that the paging is done successfully but, for any 
reason, the L2CAP connection to the remote SDP server fails with a 
"Connection timeout". This could happen when the remote device exits 
from the coverage area of the device that created the connection. 
However, the default timeout is too high for my application, so I would 
like to decrease it. Is there any way to do it?

Thanks,
Marco Pracucci


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
