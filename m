Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <7ceeaed30608080425w46302cadk554001c7d3830e3a@mail.gmail.com>
Date: Tue, 8 Aug 2006 13:25:18 +0200
From: Arkaitz <arkaitzj@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <7ceeaed30608080311i110e67a4x822d22692f4ff5ac@mail.gmail.com>
MIME-Version: 1.0
References: <7ceeaed30608051104n266c2cd4m28382c474a41dc58@mail.gmail.com>
	<7ceeaed30608080311i110e67a4x822d22692f4ff5ac@mail.gmail.com>
Subject: Re: [Bluez-devel] SCO Connection not working in handsfree with a
	Nokia 6600
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
I've uploaded one dump of my problem at:

http://wiki.liakona.com/Hcidump_disconnect

I see that the 6600 is doing some SDP, maybe asking for some service
in my laptop? After that when I try to call it asks a disconnection to
the cid 0x0041. The SCO socket is never opened, but I think that that
cid 0x041 connection is something related to the sco connection.
The fact is that I've registered with sdptool add all the services
that sdptool can handle and the disconnection is always there.
Maybe somebody can take a look to the dump and tell me something i don't know.
Thanks a lot for your time and sorry if i am writing too much to the
list, im a bit worried with this.


-- 
Arkaitz

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
