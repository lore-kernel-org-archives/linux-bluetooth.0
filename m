Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Services testing
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1128882652.32294.5.camel@randel.hadess.net>
References: <1128882652.32294.5.camel@randel.hadess.net>
Content-Type: text/plain
Message-Id: <1128884041.5536.5.camel@blade>
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
Date: Sun, 09 Oct 2005 20:54:01 +0200

Hi Bastien,

> I've been trying to find a way to test obexftp and friends on my
> machine, without requiring a server on another machine/device.
> 
> Should I use "FF:FF:FF:00:00:00" as the remote address for this? (For
> example:
> obexftpd -b
> and
> obexftp -b -B 4 FF:FF:FF:00:00:00 -l
> )
> 
> Anyone ever tried using services in "loopback" (as you would with normal
> network services)?

Bluetooth itself doesn't support any loopback services and BlueZ will
not emulate a loopback interface. However you can use a second dongle to
test things with only one machine (exception is BNEP).

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
