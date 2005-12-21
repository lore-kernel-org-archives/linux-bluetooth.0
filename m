Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Filippo Giunchedi <filippo@esaurito.net>
Message-ID: <pan.2005.12.21.15.28.25.525548@esaurito.net>
References: <pan.2005.12.20.13.54.45.442703@esaurito.net> <1135105157.3627.13.camel@localhost.localdomain> <pan.2005.12.21.13.51.15.163756@esaurito.net> <1135174278.14627.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Re: Re: [PATCH]
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
Date: Wed, 21 Dec 2005 16:28:25 +0100

On Wed, 21 Dec 2005 15:11:18 +0100, Marcel Holtmann wrote:
> it is already in the CVS. However I have some people doing the following
> transition (instead of no flags):
> 
> DBUS_NAME_FLAG_PROHIBIT_REPLACEMENT -> DBUS_NAME_FLAG_DO_NOT_QUEUE
> 
> Any comments on this?

I think it makes sense not to wait for dbus name, so
DBUS_NAME_FLAG_DO_NOT_QUEUE makes sense

filippo



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
