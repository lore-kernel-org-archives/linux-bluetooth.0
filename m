Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
From: Marcel Holtmann <marcel@holtmann.org>
To: KeiHachi <keihachi@swissinfo.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003401c45c2b$b6eab240$0364a8c0@haruo>
References: <003401c45c2b$b6eab240$0364a8c0@haruo>
Content-Type: text/plain
Message-Id: <1088359746.3774.20.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 27 Jun 2004 20:09:07 +0200

Hi Keihachi,

> Our company is investigating now about BlueZ,
> to determine whether it is useful to use in our commercial product, or not.

about what kind of product are you talking?

> Q1. development schedule in the future
> I saw  "http://www.bluez.org/todo.html"
> But there is no information I want to know.
> Please tell me the following things.

This list only shows kernel related items that other people can start
working on if they want to contribute anything to BlueZ. My personal
todo list is much longer.

> - eSCO (enhanced SCO) in Bluetooth 1.2
> Do you have any plan to develop these?

Define what kind of eSCO support do you need? Must the SCO packets go
though the HCI layer or through an extra PCM interface?

Do you own Bluetooth chips that supports eSCO? I only own two devboards
and both don't support SCO over HCI and they also don't came with a PCM
codec on it.

> - Audio/Video related profiles
> Do you have any plan to develop these(A2DP, AVRCP)?

Audio/video is along with HID one of the two major things that will be
supported in the future. However talking about A2DP the problem I see is
that there is not free GPL code for the suband codec at the moment and I
am not an audio expert. I haven't spent any time with thinking about the
remote control profiles.

> Q2. maintenance/support
> I found some examples about the support of open-source that
> companies which want to use such a open-source software,
> pay some maintenance fee to the community or some companies which
> provide the service to maintain it, so that
> the community or such companies ensure the quality of their software is a certain level.
> For example, MySQL, JBoss, etc.
> These open-sources are maintained to ensure the quality,
> by some kind of organizations which get the maintenance fee.
> 
> Does BlueZ allow such a business model?

Many business models are possible, but you must be more specific about
that what you had in mind. What kind of maintenance and support do you
need?

> Q3. version control
> Many open-sources are composed of two versions,
> one is a "testing version", and another is a "stable version". 
> But I think BlueZ has only a "testing version".
> 
> Why doesn't BlueZ have a "stable version"?
> Do you have any plan to have a "stable version" of BlueZ?

That is wrong. BlueZ itself is stable. Speaking about the kernel part
then every code in a stable kernel like 2.4 and 2.6 is stable. Bugs
exists and later kernel releases are more stable than previous, but
every BlueZ code in the kernel can be considered as stable.

The -mh patches for 2.4 are also stable, because they don't add new
features. They only make it possible to use the latest BlueZ code 2.4
with older kernel releases. I did this, because embedded developers are
very stuck to some kernel versions.

Starting with 2.6 I changed the use case of my -mh patches. They are
only maintained for the latest kernel version and they include testing
code. For example the upcoming HIDP support.

The BlueZ library and utils are also stable. The next generation work
(or may you wanna call it "testing") can be found in CVS under libs2 and
utils2.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
