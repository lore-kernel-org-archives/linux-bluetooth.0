Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d23110170608231314h5daa41f4s4fe0ddc31df87ca7@mail.gmail.com>
Date: Wed, 23 Aug 2006 17:14:07 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44ECA22B.6050703@csr.com>
MIME-Version: 1.0
References: <000f01c6c59e$67014940$9d0cc70a@dlh.st.com>
	<1156226067.3956.57.camel@aeonflux.holtmann.net>
	<d23110170608221347p37bc87a5mbdd1271eaf7631c3@mail.gmail.com>
	<44ECA22B.6050703@csr.com>
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

Hi Steven,

On 8/23/06, Steven Singer <steven.singer@csr.com> wrote:
> Sending back the command gives a commitment to the chip that you will
> be able to take another maximum size block of data. Sending the command
> before this is true will lead to a disaster.

Yes, you're right. The problem seems to be knowing when this
commitment can be given if we don't have a preallocated static buffer
or some dynamic allocation strategy implemented.

[ snip ]

> These are all advanced techniques. For the moment, it's probably
> easiest just to send tokens as soon as they become available. Worry
> about optimising it once it's working properly.

Thanks for pointing all that out. :-) We're trying to make it work but
we really have to know when we can be sure a flow control token became
avaialble.

> Don't forget that when a disconnection occurs, all outstanding
> flow control tokens for that handle are returned implicitly.

Right, I won't forget, thanks.

Best regards,

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
