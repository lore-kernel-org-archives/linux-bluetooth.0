Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0511080829n4795636ewfb85de47383da57c@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0511070401v66d86898n41277902d0fbfa9b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0511070401v66d86898n41277902d0fbfa9b@mail.gmail.com>
Subject: [Bluez-devel] Re: [DBUS PATCH] Disconnect
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
Date: Tue, 8 Nov 2005 14:29:23 -0200

Hi Marcel,

Do you have any comments about this patch?

In order to see how it works restart the dbus-daemon
$/etc/init.d/dbus-1 stop
$/etc/init.d/dbus-1 start


Regards,
Claudio.

On 11/7/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> Hi,
>
> Here is patch do handle the dbus system "Disconnect" signal.
>
> When the signal is received, a timer is started to try reconnect to
> the system bus each 5sec.
>
>
> Regards,
> Claudio.
> --
> ---------------------------------------------------------
> Claudio Takahasi
> Instituto Nokia de Tecnologia - INdT
>
>
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
