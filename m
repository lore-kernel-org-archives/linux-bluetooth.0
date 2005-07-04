Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42C8BB9E.30304@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] problem using skype + BT headset, Linux OS
References: <42C29EB2.8080502@lesagepono.be>
In-Reply-To: <42C29EB2.8080502@lesagepono.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sun, 03 Jul 2005 22:31:26 -0600

yes, there is a "noisy microphone" bug in our sourceforge list. I 
suspect it's happening somewhere other than btsco (the daemon) and btsco 
(the kernel module)

Laurent@lesagepono.be wrote:
> Hi all,
> 
> back again with a persistent problem. It seems specific with this 
> "assembly" (?) : Linux OS + BT headset + skype. In fact there is no 
> problem when I use the headset to listen : the problem is when I use the 
> microphone. The first time I set up btsco, and use Skype (or other phone 
> client), the micrphone creates a terrible noise. I hangup. I reconnect. 
> Generally, this is OK. (don't know why it doesn't work the first time). 
> But with skype, the problem appears again. I can place one or two calls, 
> then the noise appear and my peer does not hear anything he could 
> understand. After that, I often get this error with "btsco -v"
> 
>> i/o needed: connecting sco...
>> Can't connect SCO audio channel
>> : Software caused connection abort
>>
>>
> 
> while with hcidump, nothing is visible. I just see the dump of the last 
> call:
> 
>> > SCO data: handle 44 dlen 48
>> > SCO data: handle 44 dlen 48
>> > SCO data: handle 44 dlen 48
>> > SCO data: handle 44 dlen 48
>> > SCO data: handle 44 dlen 48
>> > SCO data: handle 44 dlen 48
>> > SCO data: handle 44 dlen 48
>> > SCO data: handle 44 dlen 48
>> > SCO data: handle 44 dlen 48
>>
> 
> I remeber someone had a similar problem a few days ago. Any idea? A bug?
> 
> thanks
> 
> Laurent
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
