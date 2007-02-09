Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45CCD2A4.6040605@gmail.com>
Date: Fri, 09 Feb 2007 11:59:32 -0800
From: Xamindar <junkxamindar@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45CA05A6.5000808@gmail.com>	<20070207102742.gs40wgg8coc4048w@www.webmail4.com>	<45CA1BE6.5040907@pracucci.com>
	<45CA257C.9020904@gmail.com>	<5b9417770702071127t4dcc7835h2e860b7992e2bb0c@mail.gmail.com>	<45CA29F7.6070607@gmail.com>	<5b9417770702071206t733f7c64s966c9249f7eadf28@mail.gmail.com>	<45CA47A8.5000109@gmail.com>
	<20070208200339.GA15750@jolt.modeemi.cs.tut.fi>
In-Reply-To: <20070208200339.GA15750@jolt.modeemi.cs.tut.fi>
Subject: Re: [Bluez-users] Is this list dead? Here is my problem...
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

I run that command and then I get a prompt both on my phone and with the
gnome bluetooth applet to pair.  I type the same code in on my phone and
on my gnome bluetooth applet and the applet reports "created bond to
Jared's phone".  Once that happens I get the error in the console:

# rfcomm connect hci0 00:12:56:5A:92:59 8
Can't create RFCOMM TTY: Address already in use



Anssi Saari wrote:
> On Wed, Feb 07, 2007 at 01:42:00PM -0800, Xamindar wrote:
>   
>> John H. wrote:
>>     
>>> Yes, it looks as though you do.  Can you do a regular rfcomm connect?
>>> What if you use rfcomm1?
>>>   
>>>       
>> What is a regular rfcomm connect?  On the console it just gives me errors.
>>     
>  
> That would be rfcomm connect hci0 00:12:56:5A:92:59 8
>
> Maybe you need to remove that weird stuff from rfcomm.conf first too. And what
> about pairing, you haven't said anything about it?
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier.
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
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
