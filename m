Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d23110170610310630x3af9217by79d36cace3962009@mail.gmail.com>
Date: Tue, 31 Oct 2006 11:30:41 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <004401c6fcf0$0e4fa8d0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
References: <d23110170608221347p37bc87a5mbdd1271eaf7631c3@mail.gmail.com>
	<004401c6fcf0$0e4fa8d0$9d0cc70a@dlh.st.com>
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

On 10/31/06, Mayank BATRA <mayank.batra@st.com> wrote:
> I am wondering whether this code(i.e. controller to host flow control) has
> been included in one of the -mh kernel patch.
> Can you please confirm?

I don't think so. You're probably confusing it with the L2CAP
retransmission and flow control patch that is included in the latest
-mh patches.

Regards,

-- Ulisses

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
