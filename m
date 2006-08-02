Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 2 Aug 2006 13:04:53 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1154488406.3905.37.camel@aeonflux.holtmann.net>
Message-ID: <Pine.LNX.4.63.0608021302130.6321@redbean.intranet.gw-instruments.de>
References: <200608011329.03106.denis.kenzior@trolltech.com>
	<1154488406.3905.37.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Patch: GetRemoteClass
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



Hi All, 

On Wed, 2 Aug 2006, Marcel Holtmann wrote:
> Hi Denis,
> 
> > Attached is a patch to get remote class of device information as a uint32.  
> > This introduces a new method with signature:
> > uint32 GetRemoteClass(string address), which returns the class of device 
> > information encoded as a 32 bit integer.
> > 
> > The reasoning is that some applications might want to rely on their own 
> > conversion routines for the Major, Minor and Service class attributes, and 
> > thus the DBUS GetRemoteMajorClass, GetRemoteMinorClass, etc methods that 
> > return strings are not useful.
> 
> the patch is clean. So before I apply it and so extend the API, does
> someone else thinks it is useful to have?
> 
I'm currently not using the DBUS API, but I think this would be something 
very usefull. 

Ciao, 

Peter 



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
