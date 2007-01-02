Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <459AED37.20008@glidos.net>
Date: Tue, 02 Jan 2007 23:39:35 +0000
From: Paul Gardiner <osronline@glidos.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>	<1167725398.30886.32.camel@violet>	<57c68ddc0701020016y29fafa8duf77494bb50ac6d75@mail.gmail.com>	<20070102081813.6a264b0e.ml133@netpole.com.br>	<57c68ddc0701020229w6ddfaab3yf989a8e3999cbd1@mail.gmail.com>	<20070102094414.f7b9cef1.ml133@netpole.com.br>	<57c68ddc0701020446y3a7e70edh74f6ea5e0b05d07f@mail.gmail.com>	<1167743069.30886.54.camel@violet>
	<459A60A1.80906@glidos.net>	<1167745840.30886.77.camel@violet>
	<459AC8B4.7090407@glidos.net> <1167772692.30886.117.camel@violet>
In-Reply-To: <1167772692.30886.117.camel@violet>
Subject: Re: [Bluez-users]
 problem	in	making	multiple	connections	using	single bluetooth adapter	using
 bluez
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> Hi Paul,
> 
>>>>> And once again "hcidump -X -V" is your friend in showing what
>>>>> actually happens on the Bluetooth chip level.
>>>> Are there people on this list that might be willing to look over
>>>> a posted dump then?  My problem with DUN produced a trace, but
>>>> I gave up on it because there was no way I could understand
>>>> it. Is it worth my posting a dump?
>>> depends on what level the problem actually is. If it is hidden somewhere
>>> in the PPP part it is unlikely that you get a fast answer. If it is
>>> something obvious you might get your problem solved very quickly. So it
>>> is always worth posting the hcidump.
>> Great. Thanks for at least having a look.  I think the problem is
>> early on because I get nothing in my logs from dund.

Thanks for taking a look.

> even if some howtos tell you to use sdptool to add a service record.
> Simply don't do that. The dund will do it for you when needed and with
> the correct attributes.

As you say, I got that from a howto, but I also had signs it was
needed, in that if I don't issue that command then my S100 wont
consider using the Bluez device as a modem. The device appears
in the S100's list of all bluetooth devices, but when trying to
create a new "Network Connection", Bluez doesn't appear in the
list of bluetooth devices that should be considered for that
use.

That and your statement above would imply that dund is
not seeing fit to add a service record, or it is adding
one with a different set of attributes, which the S100
doesn't like. Any idea why that might be?

> Check /sys/class/bluetooth/rfcomm that you really have a listening
> RFCOMM socket on the right channel after starting dund.

Will do. Thanks.

> And since you connect from a Windows OS, it might do something crazy or
> expect something strange and that could be the reason why it is not
> working.

Yeah I see what you mean, but it can't be insurmountable because all
this was working with the earlier version of Bluez that was shipped
with opensuse 10.1.

Cheers,
	Paul.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
