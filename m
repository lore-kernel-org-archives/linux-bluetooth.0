Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Antony C. Roberts" <acr@acroberts.com>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20040323173139.19B991D01C5@sc8-sf-uberspam1.sourceforge.net>
Message-Id: <20040323183316.0D30C5EE02E@pfepb.post.tele.dk>
Subject: [Bluez-devel] RE: Accessing HCI on Windows
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
Date: Tue, 23 Mar 2004 19:33:23 +0100

Check out FreeBT (www.freebt.net) it's open source and includes the full
source code to a Generic Windows Bluetooth USB Driver as well as various
levels of HCI abstraction (with full access to the HCI layer) in C++.

Regards,
Antony C. Roberts.

> Hello folks,
> 
> I'm quite new to this "professional developer stuff" and mailing lists
> (so far only used to forums), so sorry if I do something wrong here.
> 
> I'm writing a little "Location Awareness using Bluetooth"-thing for my
> Bachelor of CS degree. On Linux, everything is fine and I just have to
> look into the  BlueZ code. But it would be nice if there was a
> possibility to port my work to Windows. Unfortunately I have found no
> documentation about how to access the HCI on Windows. All I need would
> be a simple "SendHCICommand()" or something. My Question: Does anyone
> know how to do this? Do I have to deal with the Widcomm drivers (seem to
> be monopolists) or is there a common way?
> 
> I know that this is not a Windows mailing list, but I just don't know
> where else to ask. I'd really appreciate any help or hint. Thanks in
> advance!
> 
> Kind regards
> Stefan



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
