Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATH] RemoveBonding
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602210649n3f391d0bgb3b6192e60ac083a@mail.gmail.com>
References: <e1effdeb0602210649n3f391d0bgb3b6192e60ac083a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140541511.22767.11.camel@localhost>
Mime-Version: 1.0
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
Date: Tue, 21 Feb 2006 18:05:11 +0100

Hi Claudio,

> Here is the patch to remove bondings.
> 
> Please check the logic. I read the BlueZ D-Bus API and the Bluetooth
> Spec, but I am not complete sure if I am covering all scenarios.

the logic looks fine to me. However it is not that important at the
moment, because we can sort out the details later.

Some small notes. The textfile_get() is not needed. Simply delete the
link key. If it fails, because it doesn't exists, this is fine. And use
hci_disconnect() instead of implementing it by yourself.

> Regarding the HCI disconnect complete event, I think we need notify
> the connected applications sending a D-Bus signal. What do you think?

We need to inform applications about the disconnect, but this is not the
job of this method. It will be done by other routines inside hcid.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
