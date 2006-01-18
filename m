Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus tasks planning
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: Claudio Takahasi <cktakahasi@gmail.com>
In-Reply-To: <1137569915.12927.9.camel@bluez.bueche.ch>
References: <e1effdeb0601170535yadd5f6fy93c3a5ea64a8499f@mail.gmail.com>
	 <1137505788.28239.18.camel@localhost>
	 <1137569915.12927.9.camel@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1137590308.27515.14.camel@localhost>
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
Date: Wed, 18 Jan 2006 14:18:28 +0100

Hi Charles,

> > > I've just started planning the activities for this year. I would like
> > > receive feedbacks/comments about the items below. There are some tasks
> > > suggested and a lot of clouds :)  I consider these tasks essential to
> > > make the D-Bus services usable and necessary to start the development
> > > of Network, Serial, HID, ... services over D-Bus.
> > > 
> > > * Move hcid to bluetoothd
> > 
> > since I don't wanna use threads, 
> ...
> 
> I'm not knowledgeable about threads in C and within bluez, but during my
> projects in Perl, I have found them a valuable asset. For my curiosity,
> what are the reasons behind your decision ?

since the bluetoothd should also run on any embedded system, it is a
good idea to not use thread, because they might not be as portable as an
event loop.

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
