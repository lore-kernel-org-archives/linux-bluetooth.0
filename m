Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44FC4CD8.1070304@evilgenius.de>
Date: Mon, 04 Sep 2006 17:57:12 +0200
From: Martin Karger <martin@evilgenius.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F22717.1080308@evilgenius.de>	<1156772287.5613.31.camel@aeonflux.holtmann.net>	<44F32933.90808@evilgenius.de>	<1156799873.5613.51.camel@aeonflux.holtmann.net>	<44F353E9.7080406@evilgenius.de>	<1156809428.5613.59.camel@aeonflux.holtmann.net>	<44F43AA3.3020600@evilgenius.de>
	<1156874442.4026.22.camel@aeonflux.holtmann.net>
In-Reply-To: <1156874442.4026.22.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] flexible bt-dongle and bccmd
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

Marcel Holtmann wrote:

> 
>> right now i am having no idea how to add a new pskey. modifying and
>> delting works for me, but i did not yet found out how to create a new
>> one. it would be great if i could add a pskey with features to ps storage.
> 
> No need for that. You can simply set it. However you must select the
> correct store (default will be volatile memory). Can't remember that
> from memory. Look it up in the documentation.

ok, works now. but i do not yet understand the syntax for setting pskey
"features".
btw, the firmware of the bt-6030 does not care about a "remver" pskey.
the levelone dongle does.

bye
martin

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
