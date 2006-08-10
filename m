Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d23110170608100600m26c94ba8ua9ca68ad8c8eab86@mail.gmail.com>
Date: Thu, 10 Aug 2006 10:00:36 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003c01c6bc57$f5b033e0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
References: <d23110170608080552gcfb8ad3tb341ea0b08083172@mail.gmail.com>
	<003c01c6bc57$f5b033e0$9d0cc70a@dlh.st.com>
Subject: Re: [Bluez-devel] Host Controller to Host Flow Control
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

Hi Mayank,

On 8/10/06, Mayank BATRA <mayank.batra@st.com> wrote:
> Here are some of my observations, please correct me in case I am wrong.
>
> (i) For enabling FC from HC to Host, the host first of all sends Host Buffer
> Size Command providing the number of ACL and SCO buffers and their
> respective sizes.
> (ii) The host then issues Set Host Controller To Host Flow Control Command.
> (iii) Host will send a Host Number of Completed Packets Command to the
> controller. But my question is when??
> After every ACL Packet received?

Yeah, that is exactly what we've already discussed [1] and Marcel
suggested to send a Host Number of Completed Packets command after
every packtet for starters even though that is not what we really want
(we might want to wait for 8 packets he said).

Best regards,

-- Ulisses

[1] http://article.gmane.org/gmane.linux.bluez.devel/8188

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
