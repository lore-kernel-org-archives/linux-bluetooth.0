Return-Path: <cyrus@holtmann.org>
Message-ID: <04d401c8dbac$28051a20$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <1214593557.6131.26.camel@bongo><1214606647.4435.71.camel@cookie.hadess.net><031301c8da4d$0bce3720$6701a8c0@freqonedev><1214813891.4435.149.camel@cookie.hadess.net><035501c8dab3$5596b380$6701a8c0@freqonedev>
	<2d5a2c100806301527y21f80385vc75acdf9da62029c@mail.gmail.com>
Date: Tue, 1 Jul 2008 13:56:20 -0500
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Wizard patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello David,

>>Hello Luis

> I read the docs and when the code works as expected it is good enough.
> However, I have had a number of problems making the code work =

> (partially
> implemented "experimental" 4.x features in release 3.33 and before).

You should first understand that the documentation in doc/ are dbus
specifications, they are not normal method calls or gobject signals.
You seems to be confused by using dbus-glib and not really knowing
what dbus is doing, we don't document how to use the API in terms of
language bindings, because it is open to the application developer to
choose between the bindings and the binding itself should document how
it map the different signatures.

>> REPLY (sorry, but Outlook SUX)

>> I appreciate that fact.  I also recognize that Python does an awful =

>> lot for the user, and that perhaps I could develop all of this in =

>> Python...but at this point, I am choosing to use C/C++ and hence, =

>> must use the GLib binding.

>> Really, my comment was about the fact that some of the features =

>> documented in the /doc directory are not quite working, and in fact =

>> are still coming into existance. As a result, when I run into a =

>> problem I cannot figure out what is really going on (is it my code, =

>> or is it something missing in Bluez) without digging through the =

>> Bluez source.  Which has very little documentation (even at the file =

>> level).  Again, when everything is working, the doc files will be =

>> fine.  Just, for now, they are not quite enough.

>> The question you may be asking is why I do not just develop to the =

>> 3.x API?  Why would I do that when in just a few months I would have =

>> to throw all of that away?  (See: bluez-gnome).

> Also, figuring out how to handle some of the formats (e.g., the "dict"
> with variant) are a bit hard to figure out without a code example. =

> SO,
> I often have to dig into the actual code and figure out just what is
> going on.

See my point here, just because dbus-glib maps the signature a{sv}
(that is the real "dict") to a GHashTable using a GValue doesn't mean
any other binding will do the same. It's up to the binding to provides
this kind of documentation not the dbus API which should not be tied
to a single binding.

>> Got it, frankly the Glib binding docs are not very complete. As with =

>> most programs, the documentation handles the most simplistic cases, =

>> and ignores the fact that someone might Actually Want To Use It.  I =

>> did find the DBUS Test directory and got a lot of help from seeing =

>> how the validation tests were coded.

This tutorial should cover what you want:
http://dbus.freedesktop.org/doc/dbus-tutorial.html

>> I have read this tutorial in detail and understood it.  However, the =

>> coverage was still inadequate for a{sv} (dict) and array{string} =

>> ({as}).  At one point, I also had problems with object paths, but =

>> again, with Marcel giving me a hint as to the proper incantation, I =

>> was able to work that out.

>> That said, after finding a few more-complex code examples (especially =

>> the validation code), I have now figured the structures out. =

>> Everything I need to do for now is (apparently) working, and now I am =

>> moving on to getting SSP going between Bluez and my device =

>> (programmed with the CSR BT stack).

>> Thanks again for your response.

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o




-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
