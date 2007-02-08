Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45CB36E2.7000406@free.fr>
Date: Thu, 08 Feb 2007 15:42:42 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1170700026.3240.56.camel@localhost> <eq9ugs$63s$1@sea.gmane.org>
In-Reply-To: <eq9ugs$63s$1@sea.gmane.org>
Subject: Re: [Bluez-devel] Plugz with Dell inbuilt-BT
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

Hi,

Mark Hellman wrote:
> Jon Barnett wrote:
> 
>> The only problem is that skype can't use the plugz device as it doesn't
>> recognize it  - since it doesn't do detection of available pcm devices.
> 
>>>From a user's perspective that is, in my opinion, the main problem with
> using plugz instead of btsco. Skype and Ekiga are the reasons why 90% of
> users want to install plugz.
> 
> Is this an ALSA limitation, or isn't Skype using the right functions from
> the ALSA's API to enumerate all available devices? Who must be fixes: Skype
> of ALSA?

Thing is : sadly, there is no ALSA function to enumerate available PCMs 
on the system. There are only features to enumerate hardware cards. 
That's a known ALSA weakness, but this is how things are as of to today 
in Linux world :-(

> Could some developer enlighten us on this issue?

Just use Skype in OSS mode, and use skype_bt_hijacker available in 
contrib directory to redirect sound to ALSA headset. I haven't tested it 
myself recently, but theorically this should work.

Cheers,

Fabien


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
