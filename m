Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45081402.8020909@vasmac.com>
Date: Wed, 13 Sep 2006 10:21:54 -0400
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <450603BA.3090302@vasmac.com>	<Pine.LNX.4.63.0609121038180.17868@redbean.intranet.gw-instruments.de>	<1158050613.14015.1.camel@localhost>
	<Pine.LNX.4.63.0609121206040.17868@redbean.intranet.gw-instruments.de>
In-Reply-To: <Pine.LNX.4.63.0609121206040.17868@redbean.intranet.gw-instruments.de>
Subject: Re: [Bluez-devel] socket connect returns EAGAIN
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Peter Wippich wrote:
> Hi Marcel, 
>
> On Tue, 12 Sep 2006, Marcel Holtmann wrote:
>
>   
>> Hi Peter,
>>
>>     
>>> see my last post on this subject about 4 days ago. From my understanding 
>>> they shall return EINPROGRESS when the connection to the remote device is 
>>> pending. Returning EAGAIN looks like a small bug. See also man 2 connect 
>>> or man 7 socket. 
>>>       
>> this has been raised a long time ago. However the Bluetooth core inside
>> the kernel doesn't sets the wrong error. It is one of the network
>> functions we use.
>>     
>
> Are you sure ?!? 
>
> I think the problem is in bt_sock_wait_state(...). This always returns 
> -EAGAIN if timeout is zero (which it is if the socket is set non 
> blocking). But may be I'm missing something. 
>
> Ciao, 
>
> Peter 
>
>   
Hi Peter,

I've come to a similar conclusion. I'm not sure why it's returning -EAGAIN.
However, looking at the x25 transport (af_x25.c), it takes a different 
approach;
if O_NONBLOCK is set they don't call the blocking routine at all. Maybe a
similar approach should be taken here.

Jose


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
