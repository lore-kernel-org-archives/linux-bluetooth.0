Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <425175E9.8040509@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] a2dp timing
References: <42439ADA.5000006@xmission.com>	 <1111756476.9195.105.camel@pegasus>  <42443FDB.3070205@xmission.com> <1111771895.9195.133.camel@pegasus>
In-Reply-To: <1111771895.9195.133.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 04 Apr 2005 11:14:17 -0600

Marcel

FYI, I found alsa-lib post-1.0.8 has fixed up the plugin api so plugins 
really can be built standalone. The plugins were moved to a different 
cvs project "alsa-plugins" and the api changed in the process.

I changed our reference plugin to be based on the new oss plugin. I will 
work on the a2dp source side of things here. It looks much more 
straightforward now.

I suppose we could implement a2dp sink as well, but I don't think 
connections can be initiated by a sink--it has to listen for the source 
to make the connection.

I'm keeping the cvs code up to date in case anyone wants to look (in 
btsco/bt)

On a more pragmatic note, I sold my bluetake to a friend so it won't be 
as easy to try things on it. I bought one of the iTech sets so hopefully 
development can go well with the new headset.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
