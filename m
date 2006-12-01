Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 1 Dec 2006 14:27:06 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY108-F9E1C2886FA8EB91A3A20384DA0@phx.gbl>
Message-ID: <Pine.LNX.4.63.0612011423030.9177@redbean.intranet.gw-instruments.de>
References: <BAY108-F9E1C2886FA8EB91A3A20384DA0@phx.gbl>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] packet type
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

On Fri, 1 Dec 2006, mark bernard wrote:
> hi,
> is it possible to force bluez to use a self chosen packet type like DH5? or 
> will it automatically switch to the best packet type?

You can set a Mask which packets types the baseband is allowed to use (see 
hcid.conf). However, from the allowed packet types the baseband chooses 
which one it actually uses . Further, some basenband implementations seems 
to interpret this "mask" differently (e.g. when you set the mask to DH5 
the baseband also uses all smaller packet types). 

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
