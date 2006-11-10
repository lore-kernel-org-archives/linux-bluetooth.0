Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Hilzinger <mhilzinger@linuxnewmedia.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 10 Nov 2006 14:18:50 +0100
References: <4550B23D.8090706@palmsource.com> <455151FF.7040301@xmission.com>
	<4551ABFD.2080909@palmsource.com>
In-Reply-To: <4551ABFD.2080909@palmsource.com>
MIME-Version: 1.0
Message-Id: <200611101418.50750.mhilzinger@linuxnewmedia.de>
Subject: Re: [Bluez-devel] [patch]
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Am Mittwoch, 8. November 2006 11:05 schrieb Fr=E9d=E9ric DALLEAU:
> Sorry Brad,
> This is far more useful than whitespaces :D
> Fred

Hi Fr=E9d=E9ric,

I applied your patch on the cvs-code from today and now I get these errors =

randomly:

Nov 10 14:15:55 kim kernel: l2cap_recv_acldata: Unexpected continuation fra=
me =

(len 0)
Nov 10 14:15:55 kim kernel: l2cap_recv_acldata: Unexpected continuation fra=
me =

(len 0)
Nov 10 14:15:55 kim kernel: l2cap_recv_acldata: Unexpected continuation fra=
me =

(len 0)
Nov 10 14:15:56 kim kernel: l2cap_recv_acldata: Unexpected continuation fra=
me =

(len 0)

the error means, that for 1-2 seconds there is no sound.


Any idea, if it's due to the patch or just "par hazard"?

-- =

Mit freundlichen Gr=FC=DFen,
Marcel Hilzinger

Linux New Media AG
S=FCskindstr. 4
D-81929 M=FCnchen
Tel: +49 (89) 99 34 11 0
Fax: +49 (89) 99 34 11 99

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
