Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Microsoft Bluethooth "Elite" Keyboard & Mouse - UPDATE:  works with stock 2.6.10 
Message-ID: <20050120191228.GA1662@virgilio.it>
References: <20050116174616.GA2201@virgilio.it> <200501161851.01291.cijoml@volny.cz> <1105898506.8080.20.camel@pegasus> <20050116193732.GA2326@virgilio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050116193732.GA2326@virgilio.it>
From: Francesco Bochicchio <bockman@virgilio.it>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 20 Jan 2005 20:12:29 +0100

On Sun, Jan 16, 2005 at 08:37:33PM +0100, Francesco Bochicchio wrote:
> On Sun, Jan 16, 2005 at 07:01:46PM +0100, Marcel Holtmann wrote:
> > Hi Michal,
> > 
> > > You should use 2.6.10-mh1 and latest firmware for Digianswer dongle (adapter 
> > > use it I think)
> > 
> > using the 2.6.10-mh1 is a good idea, but it is a Broadcom dongle with
> > HID proxy and this don't need any extra firmware. However since the
> > other Broadcom HID proxy that I have does the switch into HCI mode when
> > you send a HCI_Reset (CSR HID Proxy needs an extra tool btw), the one
> > from Microsoft may need some extra magic to fully work without problems.
> 
> Ok. Thanks. I will try out 2.6.10-mh1 anyway.
> 
> 

Hi all,

just un update for the records.

I tried with plain 2.6.10 (from debian kernel-source package, without any
patch other than Debian's) and it seems to work fine with my BT keyboard & mouse. Only
needed an "hidd --connect" after inserting the dongle (the one coming with
the keyboard).
It might be that in the future I will experience the problems hinted by
Marcel, but for now I am happy :-).

I'm trying now to make the dongle work with my SonyEricsson T610; for now the
phone it is discovered (and is capable to discover the PC), but I'm not
yet succeeded to use OpenObex tools with the bluetooth connection.
But that is another story.

Question: what would be the advantage now of applying the 2.6.10-mh1 patch
to sthe standard kernel sources?

Ciao
-----
FB


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
