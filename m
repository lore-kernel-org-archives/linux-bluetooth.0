Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <9ed2cedd0612080825l42882e3dr7a216b9bb8d9f308@mail.gmail.com>
References: <9ed2cedd0612080825l42882e3dr7a216b9bb8d9f308@mail.gmail.com>
Date: Sun, 10 Dec 2006 09:30:17 +0100
Message-Id: <1165739418.5945.7.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Are there any docs to BlueZ implementation?
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

Hi Waldek,

Am Freitag, den 08.12.2006, 17:25 +0100 schrieb Waldemar Rymarkiewicz:
> Can I find any technical docs concernig BlueZ implementation (what,
> where, data flow etc.)?  Is reverse engineering the only way to find
> out how the stuff works?
> I've  worked with Qualcomm BT stack (QBT) and wanna take a look what
> is going on in BlueZ. Unfortunately have not experience with linux
> kernel hacking :/ .... 

the implementation of L2CAP Flow Control Mode ended in a study thesis
for my university. The thesis itself contains some information about my
experiences in BlueZ kernel hacking and is written in English -- this
may be worth a look:
http://www.roehricht.info/files/studienarbeit_bluez.pdf

Besides that it is rather hard to find BlueZ specific documentation.
Mainly the source is the documentation. Anyway the source is easy to
read once you got the basic understanding from the specification.
You will mainly need the official specification as a reference. At the
end of my thesis is a bibliography with some useful books that might
help you, too.

Martin


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
