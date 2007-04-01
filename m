Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <187c15580704010341h7e6f29e9i341970064be4f754@mail.gmail.com>
Date: Sun, 1 Apr 2007 11:41:37 +0100
From: "=?ISO-8859-1?Q?Lu=EDs_Sousa?=" <llsousa@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <187c15580703311838s5a4903abxfb0b6a0dbb4f8561@mail.gmail.com>
MIME-Version: 1.0
References: <187c15580703281446p1732a40eifdce3dc4c1261789@mail.gmail.com>
	<187c15580703311838s5a4903abxfb0b6a0dbb4f8561@mail.gmail.com>
Subject: Re: [Bluez-users] Paired with Nokia phone but not connected
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

Before this, I had also to issue the command:
rfcomm release <phone MAC address>

On 4/1/07, Lu=EDs Sousa <llsousa@gmail.com> wrote:
> Already found the problem.
> The connection on .gammurc was wrong. Should be bluephonet.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
