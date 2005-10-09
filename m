Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Services testing
From: Bastien Nocera <hadess@hadess.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1128884041.5536.5.camel@blade>
References: <1128882652.32294.5.camel@randel.hadess.net>
	 <1128884041.5536.5.camel@blade>
Content-Type: text/plain
Message-Id: <1128888797.32294.8.camel@randel.hadess.net>
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
Date: Sun, 09 Oct 2005 21:13:17 +0100

On Sun, 2005-10-09 at 20:54 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > I've been trying to find a way to test obexftp and friends on my
> > machine, without requiring a server on another machine/device.
> > 
> > Should I use "FF:FF:FF:00:00:00" as the remote address for this? (For
> > example:
> > obexftpd -b
> > and
> > obexftp -b -B 4 FF:FF:FF:00:00:00 -l
> > )
> > 
> > Anyone ever tried using services in "loopback" (as you would with normal
> > network services)?
> 
> Bluetooth itself doesn't support any loopback services and BlueZ will
> not emulate a loopback interface. However you can use a second dongle to
> test things with only one machine (exception is BNEP).

That's a shame. Good thing I brought a spare bluetooth dongle then ;)

Thanks Marcel.

-- 
Bastien Nocera <hadess@hadess.net>



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
