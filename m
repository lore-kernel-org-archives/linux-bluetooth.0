Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS]BondingRemoved signal question
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602220808v6e7796c4xebad39dd2cd2c28a@mail.gmail.com>
References: <e1effdeb0602220808v6e7796c4xebad39dd2cd2c28a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140630371.4519.32.camel@localhost>
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
Date: Wed, 22 Feb 2006 18:46:11 +0100

Hi Claudio,

> I am going to start the development of the BondingRemoved signal. But
> before start coding I would like define some requirements.
> 
> When it must be sent?  Currently, the code is not checking the result
> of the HCI delete stored key request, textfile_del return result or
> disconnect result. What should be the rule for sending the
> BondingRemoved signal?
> 1. Wait the command complete event for the delete stored link key request?
> 2. Check only the result of the textfile_del call?
> 3. Or if one of these condition(TRUE) is enough to send the
> BondingRemoved signal
> 
> As long as I could understand, we can have the scenario where the link
> key is NOT stored in the Bluetooth Controller, but it is stored in the
> linkkeys file. For connected devices, the disconnect can be another
> assumption, considering that the keys are automatically delete when
> disconnecting.

actually it is the normal scenario that the link key is not stored on
the chip. However for now it is enough if we simply send out the
BondingRemoved signal. We deal with the details later if we have an
application making us of it.

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
