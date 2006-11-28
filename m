Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 28 Nov 2006 15:57:34 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY108-F14D0E2C437D8EE10A1C0CF84E50@phx.gbl>
Message-ID: <Pine.LNX.4.63.0611281554510.30196@redbean.intranet.gw-instruments.de>
References: <BAY108-F14D0E2C437D8EE10A1C0CF84E50@phx.gbl>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] connections
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



Hi Mark, 


On Tue, 28 Nov 2006, mark bernard wrote:

> hi,
> im trying to connect 7 devices on bluetooth, but i get stuck at 3 devices.
> the 4th device refuses to connect.
> http://by108fd.bay108.hotmail.msn.com/cgi-bin/compose?&curmbox=00000000%2d0000%2d0000%2d0000%2d000000000001&a=d56e940c65c89244b0be101733a1c79516289b6786b97bffd0ecea592e886438#
> Verzenden
> the message i got from hcidump is:

No quite sure but it is a problem with your BT chip. It only allows 3 
connection. If it is a CSR chip may be soembody has configured it to allow 
only 3 ACL connections. You can find out using bccmd. There is a PS-key 
named something like MAX_ACL_CONNECTIONS.

Ciao, 

Peter  



|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
