Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41EE22F8.8080901@cc.hut.fi>
From: Heikki Vuolteenaho <hvuoltee@cc.hut.fi>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Receiving multiple (>2) incoming rfcomm connections?
References: <41EB8C5C.2090708@cc.hut.fi> <1105960994.8080.32.camel@pegasus> <41ECD643.6060101@cc.hut.fi>
In-Reply-To: <41ECD643.6060101@cc.hut.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 19 Jan 2005 11:06:00 +0200

Heikki Vuolteenaho wrote:
> Marcel Holtmann wrote:
> 
>>
>> your device must become master of the piconet and the phones should
>> support the role switch.
>>
> 
> You mean the USB BT device should take master role? Any pointers on how 
> this is done? Or some good documents, I guess I'll have to study a bit 
> more on this...
> 

Searching the web (http://www.phptr.com/articles/article.asp?p=21324) 
and mailing list archive helped, I just changed the link mode to 
master,accept and now it's working. Thanks!

-Hege-



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
