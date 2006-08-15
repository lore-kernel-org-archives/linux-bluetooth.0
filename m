Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44E1EAB3.8000308@mackintoshweb.com>
Date: Tue, 15 Aug 2006 11:39:31 -0400
From: Terry Mackintosh <terry@mackintoshweb.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <44E1187E.6030401@mackintoshweb.com>
	<20060815012354.GB15576@refinery.twat.com.ar>
In-Reply-To: <20060815012354.GB15576@refinery.twat.com.ar>
Subject: Re: [Bluez-users] Totally confused
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

Hi

redondos wrote:
> On Mon, Aug 14 20:42, Terry Mackintosh wrote:
> 
>>Hi
>>
>>
>>There are so many pieces to the puzzle: hci* sdp* rfcomm others?
>>
>>What comes first? second? ...?
>>
>>I just want to get pictures off my Motorola V710 picture phone.
>>Has anyone done this?
>>
>>What programs do I run in what order and what config/password files need 
>>to be messed with?
>>
> Check the many HOWTOs that can be found on the net.

I have, none seem to directly apply and all are confusing at best.

> You can use obexftp(1) to fetch files from your phone.
> 
> Something like:
> $ obexftp -b AA:BB:CC:DD:EE:FF -B <channel> -c Pictures -g Pic1.jpg
> should work.

Will try it, however the manual for the phone says it does not support 
obex, so this probably will not work.

No other programs need run to setup the connection? no config files 
setup? no rfcomm? just obexftp by itself?

Thanks

-- 
Terry Mackintosh <terry@mackintoshweb.com>
http://www.mackintoshweb.com/mars/ Mars Society, FL chapter.
Proudly powered by ROCKLinux, Apache, PHP, PostgreSQL, etc.
"If you don't know where you are going, how can you get there?"

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
