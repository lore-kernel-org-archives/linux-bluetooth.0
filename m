Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4757DCBD.40602@access-company.com>
References: <4757DCBD.40602@access-company.com>
Date: Thu, 06 Dec 2007 12:40:26 +0100
Message-Id: <1196941226.12292.192.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [Patch] org.bluez.audio.headset.Connect()
	to	handsfree
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

Hi Frederic,

> As of today, when calling org.bluez.audio.headset.Connect(), the hfp 
> profile is searched only if the headset->hfp_handle is initialized.
> This member variable is initialized upon CreateDevice the first time the 
> device is created (during resolve_services).
> The variable is not initialized when the audio service is restarted, so 
> after restarting audio service, it is no longer possible to connect to hfp.

we had to disable HFP with a config setting since we are not fully
supporting it at the moment. So this must depend on the config setting
if we search for HFP and if we consider it for the connect. By default
we only support HSP.

Regards

Marcel




-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
