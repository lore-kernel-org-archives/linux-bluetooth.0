Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41E6ED75.2060800@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] multiple BT dongles
References: <18514.1105613960@www29.gmx.net> <1105614296.7961.162.camel@pegasus>
In-Reply-To: <1105614296.7961.162.camel@pegasus>
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
Date: Thu, 13 Jan 2005 22:51:49 +0100

Hello Marcel

Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>If i've connected multiple bluetooth dongles to my computer, is it possible
>>to seperate those two within bluez?
>>I mean controlling wich services run on wich dongle...
> 
> 
> you can assign the services (application like pand) for each dongle, but
> right now you can't make the sdpd differ between them.

I think we talk about the same thing, but just to get shure:
If i program two different rfcomm services, that would mean that i can 
control which service runs on which dongle?

>>Another little question:
>>Does anybody know a bluetooth dongle that supports inquiry scan during
>>active connections?
> 
> 
> Every CSR dongle with at least HCI 16.4 firmware.

Is the firmware updateable?
Do i have to contact the manufacturer?


Thanks a lot for your help Marcel! As always, you're a big help!


kind regards
Marco Trudel


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
