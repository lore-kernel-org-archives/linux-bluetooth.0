Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 24 Jul 2006 20:34:33 +0200
From: Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060724203433.7184d301@localhost.localdomain>
In-Reply-To: <1153758912.25058.3.camel@localhost>
References: <44BE5DB3.7090406@gmail.com>
	<1153356539.4094.9.camel@aeonflux.holtmann.net>
	<2172AACE-61A5-4D43-90E2-059D659D8830@infitsrl.com>
	<20060724103824.1ff98fa6@McGee-XPC> <44C4CC37.1060308@infitsrl.com>
	<20060724155621.02cd5e11@localhost.localdomain>
	<1153758912.25058.3.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] It's rfcomm connect problem
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

Hi Marcel,

i see the problem here and studied the mails about that. We workaround
it by retrying socket a couple of times which works OK even if it wont
scale too good up to the theoretical maximum of connections.

In the moment I'm debugging some phenomena that sends hci_reset to
hci devices that run more than one connection while pumping on maximum
negotiated MTU (Obex Layer). I don't know where its coming from yet, I'll
keep you updated on my findings. =


I would be happy joining the work on the L2CAP later.

Greetings

Andy

On Mon, 24 Jul 2006 18:35:12 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Andreas,
> =

> > thank your for that information. I guess your problem is just the same
> > you had with sdp some while ago. A single BT Device can not *start*
> > connecting to two different remote devices at the same time. =

> > =

> > To solve this you have to find a way to:
> > =

> > 1. Create Connection to device A =

> > 2. Wait until Connect Complete for A's bdaddr happens (no matter if fai=
led or succ.)
> > 3. Then continue with other Create Connection Commands
> =

> we have a plan to make the L2CAP layer handle multiple ACL connects and
> try again if one attempt fails. However the last patch I wrote for it
> got lost somehow and it was broken anyway. The mailing list should
> contain a thread where I proposed how this must be handled. I don't have
> time to look at it at the moment. So if anybody wants to work on it,
> please do so and send in a patch.
> =

> Regards
> =

> Marcel
> =

> =

> =

> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-- =

-- =

mit freundlichen Gr=FC=DFen / best regards,

Andreas Gaufer

Office: +49 951-700428-91
Fax: 	+49 951-700428-87
Mail: 	Andreas.Gaufer@bluecellnetworks.com

I fully agree with RFC 1855


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
