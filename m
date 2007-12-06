Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4757DCBD.40602@access-company.com>
Date: Thu, 06 Dec 2007 12:27:57 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] [Patch] org.bluez.audio.headset.Connect() to handsfree
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

As of today, when calling org.bluez.audio.headset.Connect(), the hfp 
profile is searched only if the headset->hfp_handle is initialized.
This member variable is initialized upon CreateDevice the first time the 
device is created (during resolve_services).
The variable is not initialized when the audio service is restarted, so 
after restarting audio service, it is no longer possible to connect to hfp.

The attached patch fix the problem as follow : first search the hfp 
profile handle, then search an hsp profile handle, by getting rfcomm 
channel to connect to.

It is based against latest git tree.

Frederic.


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
