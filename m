Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 20 Oct 2006 16:19:31 -0400
From: "Robert Moskowitz" <rgm@htt-consult.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <45392F53.3070003@htt-consult.com>
In-Reply-To: <453915B1.2010303@brainhub.org>
References: <45390A62.4050805@htt-consult.com>
References: <453915B1.2010303@brainhub.org>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Current information on bluetooth mouse support
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

Andrey Jivsov wrote:
> Robert Moskowitz wrote:
>   
>> I am trying to find information on bluetooth utilities.  Everything I 
>> have found so far is either at least a year old, and does not map to 
>> files on my system.
>>
>> Anyway, I have an HP NC4010.
>>
>> I am using a Cables Unlimited dongle:
>>
>>
>> But I loose connection with this mouse if it goes idle long enough, and 
>> so far I have had to power it off and reconnect.
>>
>> I have read messages like:
>>
>> http://article.gmane.org/gmane.linux.bluez.user/6609/match=automatically+accepting+pairing+mouse
>>
>> But I don't have a /etc/default/bluez-utils file to add:
>>
>> 	HIDD_ENABLED=1
>> 	HIDD_OPTIONS="--server"
>>
>> Nor can I figure out what file this now goes into.
>>
>>     
>
> Hello Robert. I successfully solved this problem. You don't even need to 
> power-off or reset the mouse. Follow the directions in my earlier e-mail:
>
> http://sourceforge.net/mailarchive/forum.php?thread_id=30640322&forum_id=1883
> ( or search for "Microsoft IntelliMouse with kernel 2.6.18 and 
> patch-2.6.18-mh1 is broken (fix provided)" ).
>   
Well I am running Centos 4.4, that means Bluez 2.1 for now. As far as 
the kernel, well.....

But when I look at your notes, I am left straggling in the dust. I am 
not a unix heavy, missed my chance 10+ years ago with Solaris 
3.whatever.... And I don't do kernel sources.

Why are you initializing the mouse at boot? I only use my wireless mouse 
sometimes.

WHere is the sleep script? Or is that notebook suspend?

>   
>> Also how do I get the Gnome bluetooth tools working on my Centos desktop?
>>
>> I still have my headphone, stereo headset, and TREO 650 to connect....
>>
>>     
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>   

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
