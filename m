Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Christoph Lukas <christoph.lukas@gmx.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <44970CBD.8000802@xmission.com>
References: <1150746967.5012.13.camel@localhost>
	<44970CBD.8000802@xmission.com>
Content-Type: multipart/mixed; boundary="=-j4cGYh6SRrgTLkFh2L1+"
Date: Wed, 05 Jul 2006 16:25:11 +0200
Message-Id: <1152109512.11387.24.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Slow connection to Motorola H500 Headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--=-j4cGYh6SRrgTLkFh2L1+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I have digged some further into this and found out the following:

Just after pairing the headset l2ping shows ping times of about 45 msec.
After starting btsco and about 5 sec after btsco has connected hcidump
shows:


1152107748.832103 < ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0042 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
1152107748.835034 > ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 15
1152107748.840034 > HCI Event: Number of Completed Packets (0x13) plen 5
1152107754.511244 > HCI Event: Mode Change (0x14) plen 6


After this last 'Mode Change' is received l2ping takes 4000-6000 msec
which corresponds to the delay in starting audio playback.

Additionally the hcidump for l2ping -c1 looks different (btsco running):

This is before we receive HCI Event: Mode Change (0x14) plen 6:


1152108661.495583 < ACL data: handle 43 flags 0x02 dlen 52
    L2CAP(s): Echo req: dlen 44
1152108661.516393 > HCI Event: Number of Completed Packets (0x13) plen 5
1152108661.546387 > ACL data: handle 43 flags 0x02 dlen 27
1152108661.548386 > ACL data: handle 43 flags 0x01 dlen 25
    L2CAP(s): Echo rsp: dlen 44


and this after we received HCI Event: Mode Change (0x14) plen 6:


1152106935.430096 < ACL data: handle 42 flags 0x02 dlen 52
    L2CAP(s): Echo req: dlen 44
1152106936.918474 > HCI Event: Number of Completed Packets (0x13) plen 5
1152106939.474570 > ACL data: handle 42 flags 0x02 dlen 17
1152106939.476566 > ACL data: handle 42 flags 0x01 dlen 17
1152106939.477589 > ACL data: handle 42 flags 0x01 dlen 17
1152106939.478582 > ACL data: handle 42 flags 0x01 dlen 1
    L2CAP(s): Echo rsp: dlen 44


can anybody tell me what this 'HCI Event: Mode Change (0x14) plen 6' is
about and probably how to prevent this?

A full hcidump from pairing the headset and starting btsco is attached.

Thanks in advance,
Christoph

--=-j4cGYh6SRrgTLkFh2L1+
Content-Disposition: attachment; filename=hcidump.log.gz
Content-Type: application/x-gzip; name=hcidump.log.gz
Content-Transfer-Encoding: base64

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
AA==


--=-j4cGYh6SRrgTLkFh2L1+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-j4cGYh6SRrgTLkFh2L1+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=-j4cGYh6SRrgTLkFh2L1+--
