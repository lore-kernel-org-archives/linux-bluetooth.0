Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d23110170608211410l1c4cae0aufa41d8f589bda68d@mail.gmail.com>
Date: Mon, 21 Aug 2006 18:10:55 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <004b01c6c518$d298e400$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
References: <1156167261.3956.20.camel@aeonflux.holtmann.net>
	<004b01c6c518$d298e400$9d0cc70a@dlh.st.com>
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

On 8/21/06, Mayank BATRA <mayank.batra@st.com> wrote:
> There is no wrong behaviour as such. Just that Host Number of completed
> packets is being sent as soon as we get ACL Data on any connection handle.
>
> Do you think that the attached patch is decent enough for sending Host
> Number of completed packets to the raw queue? (or is there a better way than
> this?)

I've noticed you sent a diff against hci.h from bluez-libs and not the
one in the kernel, so please check that. One other thing is that you
have to be careful with endianess issues (please check your patch
against hci_core.c).

And I really think we should have a hci_send_cmd_raw() or something
like that instead of messing with hci_send_cmd(). Or maybe a new
function that creates a skb from scratch just to send the host number
of completed packets command? Marcel, what do you think?

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
