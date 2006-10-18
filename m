Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sf.net
Date: Wed, 18 Oct 2006 19:32:18 +0200
MIME-Version: 1.0
Message-Id: <200610181932.21788.dgollub@suse.de>
Subject: [Bluez-devel] Bonding methods only avaliable for present adapters
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

Hi,

i started porting the kcm_btpaired module (KDE controlcenter menu) to make use 
of the BlueZ DBus API. The kcm_btpaired module is intended to 
view/list/delete/export/... linkkeys of remote devices. The bonding methods 
(and other adapter specifics methods ..) can only used when the adapter is 
present. So the linkkey list in kcm_btpaired will be empty, when there is no 
bluetooth dongle connected. 

Is this intended in the DBus API? That methods, which are based on stored 
data, not avaliable?

If not, maybe a new object path for known devices would be helpful. 
Like: /org/bluez/FF:FF:FF:FF:FF or /org/bluez/adapters/FF:FF:FF:FF:FF

Which should provide near the same methods as a present adapter.  At least the 
function which based on stored stuff from /var/lib/bluetooth/*/*
Maybe this can also be done with the org.bluez.Adapter interface.

Other suggestions? 
Or is direct access to linkkeys via filesystem the only way?

best regards,
Daniel

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
