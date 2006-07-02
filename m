Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e0638ac60607011933s32653a21rec60f5660bcd79f@mail.gmail.com>
Date: Sat, 1 Jul 2006 21:33:38 -0500
From: "Eunsoo Seo" <eunsoo@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Data packet transmissions over SCO connections
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

Hello.
I executed the following code to send data over SCO connections.
When the second write() is called, the system freezes.
Does anybody know why?

And is this the right way of using SCO?
I mean, is it allowed to send non-audio data over SCO connections?

Thank you.

---
struct sockaddr_l2 l2addr;
struct sockaddr_sco saddr;

ad = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
memset(&l2addr, 0, sizeof(l2addr));
l2addr.l2_family = AF_BLUETOOTH;
l2addr.l2_psm = htobs(0x1001);
str2ba( dest, &l2addr.l2_bdaddr );
connect(ad, (struct sockaddr *)&l2addr, sizeof(l2addr));
write(ad, "hello!", 6);

sd = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
memset(&saddr, 0, sizeof(saddr));
saddr.sco_family = AF_BLUETOOTH;
str2ba( dest, &saddr.sco_bdaddr );
status = connect(sd, (struct sockaddr *)&saddr, sizeof(saddr));
status = write(sd, "hello!", 6);

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
