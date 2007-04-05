Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4614A31C.4010806@free2move.net>
References: <4614A31C.4010806@free2move.net>
Date: Thu, 05 Apr 2007 11:31:26 +0200
Message-Id: <1175765486.5815.598.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] How to set packet-type and role from source-code?
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

Hi Markus,

> I need to set SCO packet type to HV1 as well as I'd like to specify
> that my device should be the "master" in a SCO connection. I known
> that I can do this from the command-line using the hci* utilities, but
> I'd like to set the packet-types to a known state when I initialize my
> application (from code) and I'm sorry to say that I cannot find how to
> go about and to that...
> 
> It has to be possible, but I've search through the hci_lib but without
> success - yet ;)
> Could someone point me in the right direction?

since hciconfig and hcitool can do it, you might wanna have a look at
their source code and see how they handle it.

However I can't advise you to play with the packet types at all. Leave
them as they are. The link manager of the Bluetooth chip knows best what
to do and what packet type to choose.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
