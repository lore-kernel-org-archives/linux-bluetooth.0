Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 31 Jul 2006 20:11:06 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060731181105.GI29916@suse.de>
References: <200607311518.57014.dgollub@suse.de>
	<200607311850.09567.dgollub@suse.de>
	<1154373472.4982.21.camel@aeonflux.holtmann.net>
	<200607312007.23046.dgollub@suse.de>
Mime-Version: 1.0
In-Reply-To: <200607312007.23046.dgollub@suse.de>
Subject: Re: [Bluez-devel] Addition for hcid passkey dbus request
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

Hi Daniel,

On Mon, Jul 31, 2006 at 08:07:22PM +0200, Daniel Gollub wrote:

> I planned to register kbluetoothd as default passkey agent and listen for=
 all =

> passkey request. Have to recjet this and think about a new solution. I am =


I believe that you still can do this.

> confused now, how to achieve that the pin dialog now can detect if it is =
the =

> initiator side. When another application triggers the pairing without cal=
ling =

> CreateBonding().

Well, improve kbluetoothd in a way, that it is just way more convenient
to pair devices by using it than with any other application :-)
Once you know that you initiated the pairing, you can pre-fill the pin
field with a generated value.

Basically, i think we do not want many applications doing the pairing
stuff, there should be one application (per desktop environment...), that
handles this stuff well in a centralized place. For KDE, this could be
kbluetoothd (or maybe a control-center plugin, which could then communicate
with kbluetoothd). This probably give the best user experience.

-- =

Stefan Seyfried                     | "Please, just tell people
QA / R&D Team Mobile Devices        |               to use KDE."
SUSE LINUX Products GmbH, N=FCrnberg  |          -- Linus Torvalds

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
