Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <8272108050119101561d8eb9b@mail.gmail.com>
From: tcalexander <tcalexander@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: bluez-utils-2.14 compile error: make returns "cannot find -lbluetooth"
In-Reply-To: <csllc3$c6d$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <82721080501190249144cfac0@mail.gmail.com>
	 <csllc3$c6d$1@sea.gmane.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 19 Jan 2005 20:15:20 +0200

Added /usr/local/bluez/lib (even tried /usr/local/bluez), ran ldconfig as root.
ldconfig -p | grep bluetooth
        libbluetooth.so.1 (libc6) => /usr/local/bluez/lib/libbluetooth.so.1
        libbluetooth.so (libc6) => /usr/local/bluez/lib/libbluetooth.so
Same thing gets spat out during make. :((
bluez-libs...I had that installed first...at least that's what I
presume I did. :)
I've even turned religous - started praying, that is. :P

On Wed, 19 Jan 2005 13:55:30 +0100, Sebastian Roth
<sebastian.roth@esk.fhg.de> wrote:
> Hello!
> 
> I guess your linker just can't find the bluetooth library because you
> have installed it into a non-standard path.
>  > ./configure --prefix=/usr/local/bluez
> 
> make install runs the command `ldconfig -n /usr/local/bluez/lib' but the
> option -n forces ldconfig just to create the library links and not to
> update the cache. (man ldconfig)
> Add this path to your /etc/ld.so.conf and re-run ldconfig as root.
> 
> `ldconfig -p | grep bluetooth' should show libbluetooth now!
> 
> Best regards,
> Sebastian


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
