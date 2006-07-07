Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0607071117q1a22bb24yfdefc69377c9acb8@mail.gmail.com>
Date: Fri, 7 Jul 2006 15:17:03 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44AADFBA.1030901@runbox.com>
MIME-Version: 1.0
References: <44A9923A.4050200@runbox.com>
	<e1effdeb0607040642j3c3e0a34l67565401acb2f318@mail.gmail.com>
	<44AADFBA.1030901@runbox.com>
Subject: Re: [Bluez-devel] hcid fails to start after upgrade to
	bluez-libs/bluez-utils 3.1 (Continued)
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

Hi Tom,

this dump doesn't contain the command status and the command complete events.
Could you send it again with "hcidump -X -a -V"?

BR,
Claudio.

On 7/4/06, Tom K <tomk@runbox.com> wrote:
> Claudio Takahasi wrote:
> > Hi Tom,
> >
> > I was not able to reproduce the problem that you described. I found
> > some problems with dongles that doesn't support set the inquiry mode,
> > but I never noticed "Connection timed out".
> > Could you send the hcidump?
> >
> > BR,
> > Claudio.
> >
>
> Here's the dump file, Claudio. I started hcidump immediately after
> plugging in the dongle, and then started the bluetooth daemons. I got
> the same sequence of USB and hcid log messages as before, and let it
> cycle through 6 consecutive USB addresses before shutting it down. To my
> inexpert eye, there doesn't seem to be much in the dump, but hopefully
> it will mean something to you.
>
> TIA
> Tom.
>
>
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>
>


-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
