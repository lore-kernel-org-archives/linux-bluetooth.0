Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44DB5B71.2080601@xmission.com>
Date: Thu, 10 Aug 2006 10:14:41 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <056BF200E9632F4285220E570FEED673DBCA31@GBMDDMH202AMSX.gb001.siemens.net>
	<44DB5935.6050608@palmsource.com>
In-Reply-To: <44DB5935.6050608@palmsource.com>
Subject: Re: [Bluez-devel] a2pd
 btsco	won'tcompile	(FIX)	plus	xmmserror(trials and tribulations)	howcool
 is	this!!!	new patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fr=E9d=E9ric

>>Then the not so good avrcp seems very flaky now =


fyi, I think I forgot to comment on volume control with avrcp. I put
code in the playground that I understood from the ieee1394 docs would
control volume on the set. It didn't work, so I may be doing it wrong or
it may just not be implemented in the set. the avrcp spec is a mix of
bluetooth and ieee1394 which leads to a lack of clarity on these points.

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
