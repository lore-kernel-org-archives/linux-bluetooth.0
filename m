Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH] BlueZ D-Bus redesign
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060213073021.GA29708@localhost.localdomain>
References: <e1effdeb0602101029v4f1b6e9dw8a0a75a4daf6ba55@mail.gmail.com>
	 <1139596810.26234.73.camel@localhost>
	 <20060210230043.GA15483@localhost.localdomain>
	 <1139630105.2098.10.camel@localhost>
	 <20060213073021.GA29708@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1139817802.31372.11.camel@localhost>
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
Date: Mon, 13 Feb 2006 09:03:22 +0100

Hi Johan,

> > > Btw Marcel, the API document should probably be added to CVS or
> > > published on this list since AFAIK currently you, I, Claudio and Eduardo
> > > are the only ones in posession of it.
> > 
> > Actually I wanted to wait until it is in a better shape, but since they
> > mentioned it several times on the mailing list, we should make it public
> > anyway. Please do a last review and then I commit it to the CVS.
> 
> I don't have currently any big issues with it. One thing we may want to
> add to it in the future is descriptions of the different types of errors
> that the methods can return.

and I am thinking of re-designing the errors. Once you deal with
languages like C# or Java, you might wanna have clear exceptions.

However we need an updated dbus-test script. Can someone please address
this.

> > > > Should we split the Manager interface and the Device interface into two
> > > > separate files?
> > > 
> > > I think that would make sense. That way you could also define clearer
> > > interfaces between them in the code (function wise).
> > 
> > Any proposals on how we gonna do the split?
> 
> I see you've already made the split in CVS, and it looks ok. I'd
> probably split the dbus.h file also into separate files (one for each .c
> file). At some point we might also need a "dbus-common.c" file for
> common helper functions (e.g. the client lifetime tracking may be one
> thing that could go into it).

The split is not perfect, because we have overlaps for that I had to
introduce some ugly hacks to get them working. However the current split
makes it a little bit easier to work with the code. I also introduced
some generic device handling. In the end this layer should take care of
the inquiry cache and the connection tracking.

The Manager part should work now as expected, but I had some small race
condition with the BD_ADDR. So I think we send the DeviceAdded signal a
little bit too soon. I worked around it with re-reading the address if
it hasn't been set correctly.

Does anybody know how to receive D-Bus signals within C#? I started to
write some bluetooth-sharp bindings for the BlueZ D-Bus API, but I can't
find any documentation on how to deal with the signals. The methods
stuff is working perfect.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
