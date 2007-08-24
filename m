Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <9FADD91B-899B-45A5-A018-CAA3F97C976D@cadvium.net>
To: bluez-devel@lists.sourceforge.net
From: robert <rbscott@cadvium.net>
Date: Fri, 24 Aug 2007 08:11:26 -0700
Subject: Re: [Bluez-devel] handsfree profile
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello Marcel,

So I was planning to implement the profile inside of java, which is  
why I am working on the Avetana BT stack, but I don't beleive that I  
can handle any of the SCO communication from java.  Essentially I am  
planning write the command processor for handling the AT commands in  
Java (easier to maintain and debug), and then just create a small  
daemon that handles routing traffic between the SCO channel and the  
Alsa devices.  Perhaps communicate between the two using D-Bus?

Is that possible?

Cheers,
Robert

> Hi Robert,
>
>
>> How would I go about redirecting incoming SCO data to an alsa device,
>> and transmit incoming audio data out as SCO?
>>
>> I have read the following pages,
>> http://wiki.bluez.org/wiki/Audio
>> http://wiki.bluez.org/wiki/HOWTO/AudioDevices
>>
>> but everything described seems to do too much.  I would prefer to
>> handle the RFCOMM channel, and SDP registration elsewhere.
>> Presently, I just want to determine how to redirect the SCO traffic.
>>
>
> actually you can't really do SCO without a profile. In theory you can,
> but that is to compatible with out devices. Since this kind of
> application doesn't really make sense for most people we didn't  
> focus on
> it and so nothing like that is available. However hstest.c and  
> other SCO
> demos can be used to quickly write something like that. The hardest  
> part
> is to get the ALSA thing right. Again, you have to write that by
> yourself since we have no need for this right now.
>
> Regards
>
> Marcel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
