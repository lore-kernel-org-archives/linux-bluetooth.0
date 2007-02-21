Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45DBD9D1.90509@xmission.com>
Date: Tue, 20 Feb 2007 22:34:09 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <5b9417770702181902v287f5d44uc513b4d8bc8f1a79@mail.gmail.com>	<45D91EC2.5000201@xmission.com>	<5b9417770702191013x63a8ebfdu7cefaf3e781b0f86@mail.gmail.com>	<45DA6241.8030507@xmission.com>	<5b9417770702200044k290111f0m880d009c17f6f577@mail.gmail.com>	<45DB87B6.60100@xmission.com>
	<5b9417770702201830t4e8dc0a3ie29fa0b89a597fa4@mail.gmail.com>
In-Reply-To: <5b9417770702201830t4e8dc0a3ie29fa0b89a597fa4@mail.gmail.com>
Subject: Re: [Bluez-devel] if using bluetooth DUN,
	how to get best performance?
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

John

> brad, unfortunately, I have gotten ZERO help on bluez lists about PAN,
> never once eliciting even a reply:(
> 
> I have gotten my device to connect to pand on my desktop and say it's
> on the "pan" now, but do not know anything else I can do beyond that.
> You cannot seem to set the IP on the device itself.

It sounds like you were using your desktop as the network access point
(nap), but I'm suggesting you try it the other way around, making the
phone perform the "nap" side of the connection. You could sort of follow
along with the nokia way and do the "770" steps on your laptop and the
"debian" equivalent steps on your q.

http://maemo.org/maemowiki/HOWTO-BluetoothNetworking

> not that it matters, but the actual name of the device is a
> smartphone, as pocketpc software does not seem to work for this
> device.  that being said, is it possible for a registry change to fix
> the problem, or should i contact motorola and ask them if they "limit"
> bandwidth in BTDUN?

I really believe this is a problem in the wince bluetooth stack, not an
intentional limit. Find a better forum to ask about the wince stack and
the motorola policy and you'll get a lively response.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
