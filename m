Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0606060952r7b08262doe46cfef478a8f3c4@mail.gmail.com>
Date: Tue, 6 Jun 2006 13:52:58 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4485929B.8010602@palmsource.com>
MIME-Version: 1.0
References: <4485929B.8010602@palmsource.com>
Subject: Re: [Bluez-devel] [PATCH] DBus GetRemoteName problem
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

Hi Frederic,

It's necessary consider some extra conditions:

1. DiscoverDevices running
2. DiscoverDevicesWithoutNameResolving running
3. non D-Bus inquiry request(eg: hcitool, kbluetoothd, ..)
4. After receive a connection complete event, a HCI remote  name
request is sent to update the remote name

The GetRemoteName request can arrive under these conditions.

I already fixed this bug, but it needs more tests.

Claudio.

-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

On 6/6/06, Frederic Danis <frederic.danis@palmsource.com> wrote:
> Hello,
>
> When I use GetRemoteName of dbus-test program I receive a
> DiscoveryCompleted signal after the RemoteNameUpdated (or
> RemoteNameFailed) signal.
> You can find attached a patch to fix this.
>
> Hope this helps.
>
> Regards
>
> Fred
>
> --
> -----------------------------------------------
> It is not by improving the oil lamp that one invents the electric bulb!
> -----------------------------------------------
> Danis Frederic            PalmSource Europe
> Software engineer
> Mail : mailto:frederic.danis@palmsource.com
> -----------------------------------------------
>
>
>
> --- dbus-adapter.c.orig 2006-06-06 11:35:32.000000000 +0200
> +++ dbus-adapter.c      2006-06-06 14:51:57.000000000 +0200
> @@ -1255,8 +1255,7 @@
>          * Otherwise, send the HCI cmd to get the remote name
>          */
>         if (dbus_data->discover_state == STATE_IDLE) {
> -               if (!disc_device_req_name(dbus_data))
> -                       dbus_data->discover_state = STATE_RESOLVING_NAMES;
> +               disc_device_req_name(dbus_data);
>         }
>
>         return error_request_deferred(conn, msg);
>
>
>
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
