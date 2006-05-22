Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4471DE09.5050405@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: broadcom in disguise...
References: <4461A33F.1060702@killesreiter.de> <44634846.3000006@xmission.com> <Pine.LNX.4.63.0605111727560.7379@redbean.intranet.gw-instruments.de> <4461FE7D.3050108@killesreiter.de> <447105B1.3060908@killesreiter.de> <447140B7.2090100@xmission.com> <44718942.10609@killesreiter.de>
In-Reply-To: <44718942.10609@killesreiter.de>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Mon, 22 May 2006 09:51:37 -0600

Gerhard

>> A couple of manufacturers switched from csr to broadcom around the time
>> bluecore4 and the other edr chips came out. Not sure why.
>>   
> I find this highly annoying. I have written to typhoon and asked for an
> explanation.

this is unfortunately a fairly standard practice across the computer
hardware industry.

bluetake has done the switcheroo as well but currently their BT007EX is
our only source for a class 1 bluecore4 dongle so we like them again.

>>  If you've used the adapter in windows
>> for sco audio
>>  then it might change some nvram settings.

I really don't know much about the broadcom models or even if they do
have nvram settings for this. It's possible they ship something that
can't do sco out of the box but will do it after the windows driver
initializes it. That's my "all out of ideas" suggestion.

Brad



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
