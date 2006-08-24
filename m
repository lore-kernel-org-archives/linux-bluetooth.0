Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <44ED5BB7.9090808@arcor.de>
Date: Thu, 24 Aug 2006 09:56:39 +0200
From: Simon Siemens <Simon.Siemens@arcor.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <20060824041210.69369.qmail@web50514.mail.yahoo.com>
In-Reply-To: <20060824041210.69369.qmail@web50514.mail.yahoo.com>
Subject: Re: [Bluez-users] Inquiry in Bluetooth 1.2
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

Hi Mahtab,

thanks for your explanation of the discovery process. I only knew the
10.24 seconds, but not exactly, how it is calculated.

Now some hints to your questions: The complete inquiry process remains
unchanged from the discoverer's point of view. I think they did this for
compatibility reasons. Both, enhanced inquiry scan and interlaced
inquiry scan, should be modifications on the listening (scanning) side
(the one who wants to be discovered). Therefore a Bluetooth v1.2 still
takes 10.24 seconds for a complete inquiry, but v1.2 device around it
should be found faster.

For interlaced inquiry this is definitely the case: The listening device
scans in both trains at once, halving the time to _be_ discovered. This
is obvious from your description.

For enhanced inquiry scan I cannot speak, because I don't really know
what it is. But - as the name says - it should be on the scanning
(listening) side. I will do some further investigations on this.

So if the complete inquiry still takes 10.24 seconds, how does it help
then. It only helps, if you don't need all devices, but only a certain
one. E.g. you could offer the user each device at the point in time it
is found. Then he can immediately react, as soon as he sees the desired
device.

Another example: I need this for some kind of mesh networking. For me,
the first device I find is sufficient. If the maximum time for a BT v1.2
device to be discovered is indeed 5 seconds (or 2.5 seconds with
interlaced inquiry), then it is obvious, that I finished my inquiry
within those 5 seconds.

You can test this behaviour with

    hcitool inq --flush --numrsp=1

You can then see, that it always takes a different time to discover the
first device. It is between about 1 and 11 seconds. (You can find more
options for inq with hcitool inq --help). I'm currently writing a small
piece of Java software, which should perform many inquiries and do some
statistics on it. If there is no device it scans between 10.26 and 10.31
seconds. The difference to the 10.24 seconds might be processing time
before and after the inquiry.

Best regards,

Simon



Mahtab Hossain schrieb:
> Hi,
>
> As far as I know about bluetooth's inquiry (no idea about Interlaced
> scan though), it is suggested to take 10.24 sec to complete. I will
> try to explain a bit what I had read in Bluetooth spec. 1.2:
>
> It uses 32 dedicated freq. (16 in one train and 16 in another) - one
> train is 10 ms long with 16 transmit slots (each 312.5 micro-sec long)
> and 16 corresponding receive slots which make the time period for one
> train 10 ms  long (16*312.5*2 = 10 ms). Now one train is suggested to
> repeat at least 256 times before switching to another train and the
> whole process repeats itself. There are 3 such switches. So the total
> time becomes = 256 * 10 * 4 = 10.24 sec. But there is no hard-bound
> limit on this time-period according to specification.
>
> How did you measure the time taken for your inquiry taking 10 sec? Are
> you using "hcitool inq" command or anything else? I also plan to vary
> the inquiry time period to see the effects. Any idea how can I achieve
> this - I mean how to vary the default 10 sec period of inquiry time to
> make a bit shorter or larger? Or is it absolutely chip-dependent and
> can't be altered using the BlueZ stack? Any help on this would be
> appreciated!
>
> Thanks in Advance
> Mahtab
>
> */Simon Siemens <Simon.Siemens@arcor.de>/* wrote:
>
>     The Bluetooth 1.2 specification has to major improvements to
>     reduce the
>     inquiry time: Enhanced Inquiry Scan and Interlaced Inquiry Scan
>     (http://wireless.sys-con.com/read/43887.htm). The article states, that
>     enhanced inquiry scan reduces the maximum inquiry time from 10 to 5
>     seconds and improves the reliability. Interlaced inquiry scan should
>     halve the inquiry time further.
>
>     As far as I understood things both mechanisms act on the side of the
>     listener, not the discoverer. I can also find both names in the
>     feature
>     section of the Bluetooth 1.2 specification (section 3.2 on page 203).
>     The interlaced inquiry scan is described in section 8.4.1 "Inquiry
>     scan
>     substate" (on page 144) as a method, where the scanning device checks
>     not only one but two frequencies in both trains at once. This
>     halves the
>     maximum inquiry time.
>
>     However I could not find anything further about enhanced inquiry scan.
>     And tests with two Bluetooth v2.0 +EDR devices did not reduce the
>     maximum inquiry time (without interlaced inquiry) below 10 seconds.
>
>     So what is this enhanced inquiry scan? How is it compared to the old
>     v1.1 inquiry scan? How can I activate it? (Currently one device is a
>     Nokia N70 and the other is a Linux computer with a MSI 3X BToes
>     dongle.)
>
>     Thanks a lot,
>
>     Simon
>
>
>
>     -------------------------------------------------------------------------
>     Using Tomcat but need to do more? Need to support web services,
>     security?
>     Get stuff done quickly with pre-integrated technology to make your
>     job easier
>     Download IBM WebSphere Application Server v.1.0.1 based on Apache
>     Geronimo
>     http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>     _______________________________________________
>     Bluez-users mailing list
>     Bluez-users@lists.sourceforge.net
>     https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
> ------------------------------------------------------------------------
> Do you Yahoo!?
> Everyone is raving about the all-new Yahoo! Mail.
> <http://us.rd.yahoo.com/evt=42297/*http://advision.webevents.yahoo.com/mailbeta>
>
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
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
