Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
Message-ID: <20040627125235.GA15938@gmx.net>
References: <003401c45c2b$b6eab240$0364a8c0@haruo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <003401c45c2b$b6eab240$0364a8c0@haruo>
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
Date: Sun, 27 Jun 2004 14:52:35 +0200

On  0, KeiHachi <keihachi@swissinfo.org> wrote:
> I have some questions about BlueZ.
> 
> Our company is investigating now about BlueZ,
> to determine whether it is useful to use in our commercial product, or not.

If this is the first GPL software you are using, please read and 
understand the implications of this license. This is no offense, but i
think some DVD and Router manufacturer didn't do this before integrating
linux code in their products.

> Q1. development schedule in the future
> I saw  "http://www.bluez.org/todo.html"
> But there is no information I want to know.
> Please tell me the following things.
> 
> - eSCO (enhanced SCO) in Bluetooth 1.2
> Do you have any plan to develop these?

I am not Marcel and not writing any kernel code, but i listened his talk
at Linuxtag Karlsruhe. I think the problem is the lack of the end-user
products already supporting this. But it is on his plan:

http://www.holtmann.org/papers/bluetooth/lt2004_slides.pdf

> - Audio/Video related profiles
> Do you have any plan to develop these(A2DP, AVRCP)?

He posted some time ago a request, that if people supply him such
hardware he would implent those support.

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

I don't understand, are you looking for a company that provides such
support or you want to start a business providing such support?
I don't know of the first, but contacting the developer directly, one
may provide such support. The second is of course possible.

> Q3. version control
> Many open-sources are composed of two versions,
> one is a "testing version", and another is a "stable version". 
> But I think BlueZ has only a "testing version".
> 
> Why doesn't BlueZ have a "stable version"?
> Do you have any plan to have a "stable version" of BlueZ?

It is so stable, you don't need one, ;) Just kidding. Why do you think,
there is no stable version? I think the releases are considered stable
and the CVS stuff and the utils2/libs2 are the testing branch.

nicholas


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
