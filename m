Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: andreas.knuth@daimlerchrysler.com
To: bluez-devel@lists.sourceforge.net
Message-id: <OF6C4333A9.A9953808-ONC125702A.00447737-C125702A.0049AD28@dcx.dcx>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] using scanner with bluez and question to csr-hci-commands
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
Date: Fri, 24 Jun 2005 15:24:45 +0200





Hi,

A time ago I installed csrsniff and bpasniff from cvs. I have a FTS and=
 a
BPA-Sniffer.

When I'm looking now into the cvs I can't find the code again. Why?

Now its time for me to try using this with linux too. currently I am on=
ly
tried the bpasniff. It works.  the outcome from the bpasniff looks like=

baseband packages.
Have someone written some tools for decoding the packages? Or are there=

some source /info-link available for this topic?

Second question.
The csr-ships supporting a lot of additional HCI-commands (I guess its
implementation specific ...). What I have found in your CVS is the
possibility to set the BT-Address.
Is there someone working on getting the following HCI-commands implemen=
ted
in bluez - at least in cvs for testing - too?

Display supported key length of the module
Display acl connection keylength
warm-reset Resets the module
cold-reset Resets the module
Get or set the min keylen
Get or set the max keylen
Get or set if a unitkey is used

It would be helpful for testing BT implementaions, because testing the
black boxes from our supplier is not so easy without tools.
Is this genrally possible - or are there some restrictions from CSR?



Mit freundlichen Gr=FC=DFen / kind regards

Andreas Knuth
=




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
