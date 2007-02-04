Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 3 Feb 2007 23:45:14 -0800 (PST)
From: Sergey Krivov <krivov@yahoo.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45C5490C.5090703@gmail.com>
MIME-Version: 1.0
Message-ID: <542526.5346.qm@web31005.mail.mud.yahoo.com>
Subject: Re: [Bluez-devel] a2dp and multiple headsets
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

Hi JP,

I was able to stream A2DP to two headsets
simultaneously. So, in principle, you dont need 35
transmitters :). At lower a2dp bit rates the ratio may
increase, i did not test it though. 

--- "JP Freeley (GMAIL-NYC)" <jpf321@gmail.com> wrote:

> brad --
> 
> last question....if I indeed wanted to install 35
> transmitters and 35 
> headsets, as crazy as that may sound, must I then
> worry about RF 
> interference in the room?



 
____________________________________________________________________________________
TV dinner still cooling? 
Check out "Tonight's Picks" on Yahoo! TV.
http://tv.yahoo.com/

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
