Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 18 Dec 2006 18:40:08 +0100
From: Stefan Seyfried <seife@suse.de>
To: "Mark S. Townsley" <mstownsley@gmail.com>
Message-ID: <20061218174008.GD13541@suse.de>
References: <be976db60612171036i7281422dj3680b209a9f90e6@mail.gmail.com>
	<20061218090305.GA960@suse.de> <20061218093828.GD960@suse.de>
	<be976db60612180918n6666e9tec5d7c6a9a80dfe7@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <be976db60612180918n6666e9tec5d7c6a9a80dfe7@mail.gmail.com>
Cc: BlueZ development <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] dund and bluez
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Mon, Dec 18, 2006 at 09:18:09AM -0800, Mark S. Townsley wrote:
> Hi Stefan:
> =

> Many thanks for those dund files.  I have followed the steps and seem to =
get

They were most probably already on your machine in
/usr/share/doc/packages/bluez* ;-)

> dund listening just fine.  However, when I minicom over /dev/rfcomm0, I
> still get /dev/rfcomm0 not found.

I think this is an authentication problem. Look in the logs.

> Can I ask you a few stupid questions:

Yes, but better direct them to the list, since there are many knowledgeable
people there that might actually be able to help better than i am :-)

>  1)  I am trying to get my SuSE box to talk to a bluetooth module made by
> Ezurio (attached).  It is sending AT commands to me (and likewise, I can =
AT
> over if I want to interact).  Do I need PPP?  I think I need DUND to hand=
le
> the AT commands but I am not sure if I need PPP.

I have no idea.

>  2)  Can you tell me, programtically (say from C or C++), how can I comma=
nd
> DUND to respond or issue AT commands to a remote host?  Most examples I
> google'ed show it how from some AT scripts living under /etc/ppp/.....

I think that dund just listens for incoming connection and hands those over
to pppd, but to be honest, i have only tried it once.

If you now would mention which version of SUSE you are using (and maybe even
which version of bluez-utils is installed), then even more knowledgeable
people might be able to help you :-)

Have fun,

    Stefan

-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
