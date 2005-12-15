Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Remote name delay
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051214215318.GA25332@localhost.localdomain>
References: <e1effdeb0512011117i730f7dd0p4ffc099d06a09cb8@mail.gmail.com>
	 <1133470780.18554.2.camel@blade>
	 <e1effdeb0512020321g2b492f1cl5c553d7c3b24bfb8@mail.gmail.com>
	 <1133523028.20834.8.camel@blade>
	 <e1effdeb0512020833q3f319166lfe8e63e612a86c4e@mail.gmail.com>
	 <1133548573.20834.83.camel@blade>
	 <e1effdeb0512131359x7ff7a330j435a8bde0779e958@mail.gmail.com>
	 <1134511532.24447.18.camel@blade>
	 <e1effdeb0512141035w5cc40fach9d77ead5df00cf2@mail.gmail.com>
	 <20051214215318.GA25332@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1134624339.5198.18.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 15 Dec 2005 06:25:39 +0100

Hi Johan,

> > ok. We will extend the GetProperty(string:info) returning the
> > following arguments:
> > - MAC Address: String
> > - Device Status: String(UP/DOWN)
> > - Manufacturer: String
> > - HCI Version: String
> > - HCI Revision: String
> > - LMP Version: String
> > - LMP Sub Version: String
> 
> Currently we have three different property types: string, boolean and
> byte. Are you proposing that the above information be bundled to one
> "info" property? That would create a fourth property type which, in my
> opinion, would complicate the code unecessarely. Maybe those pieces of
> information should be split into one property each (or maybe that's what
> you're suggesting, sorry if I misunderstood)? If there still exists a
> complelling reason to bundle all that info into one property, then I'd
> suggest creating a new property with the type DBUS_TYPE_STRUCT in order
> to maintain consistency with the parameters of the property signal and
> methods.

from the first looking at it, I would say that it should be an info
structure, but I agree that this will make the code to complex. On the
other hand, I don't like to have too many properties only for some
device information.

Do you think anyone will parse them ever? I think they will only be
displayed by the user interface, right? So maybe something like

	Address:	"00:09:DD:xx:xx:xx"
	Manufacturer:	"Cambridge Silicon Radio"
	HCI Version:	"2.0 (revision 0xa3e)"
	LMP Version:	"2.0 (subversion 0xa3e)"

will do for now. But we maybe need to have the integer values and the
strings available. I don't wanna force the need for any integer-string
conversion tables in the user applications.

And btw it would be also good to present the feature bits.

> Also, all of the above pieces of information, excluding the device
> status, are of a read-only nature so the SetProperty method and
> PropertyChanged signal don't really apply to them. Therefore the
> question should be asked whether the "properties" feature is the right
> one to use for them (I'm not saying it isn't, just that it should be
> questioned). E.g. you would need to think about what error should be
> returned if SetProperty is called for one of them.

Let's leave out the device status for now.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
