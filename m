Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0704190935j7252456fu5677f66d39e2dcd9@mail.gmail.com>
Date: Thu, 19 Apr 2007 13:35:20 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <462794A6.6000503@access-company.com>
MIME-Version: 1.0
References: <462794A6.6000503@access-company.com>
Subject: Re: [Bluez-devel] Input service usage
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

On 4/19/07, Frederic Danis <frederic.danis@access-company.com> wrote:
> Hello,
>
> I am trying to use the new "input" service.
>
> When I use new Service interface, all works fine :
>   ~ # dbus-send --system --print-reply --dest='org.bluez' /org/bluez
> org.bluez.Manager.ListServices
>   method return sender=:1.48 -> dest=:1.55
>      array [
>         string "/org/bluez/service_input"
>      ]
>   ~ # dbus-send --system --print-reply --dest='org.bluez'
> /org/bluez/service_input org.bluez.Service.GetName
>   method return sender=:1.48 -> dest=:1.54
>      string "Input service"
>
> But, I can not access to the input service :
>   ~ # dbus-send --system --print-reply --dest='org.bluez.input'
> /org/bluez/input org.bluez.input.Manager.ListDevices
>   Error org.freedesktop.DBus.Error.ServiceUnknown: The name
> org.bluez.input was not provided by any .service files
>
>   ~ # dbus-send --system --print-reply --dest='org.bluez'
> /org/bluez/input org.bluez.input.Manager.ListDevices
>   Error org.bluez.Error.UnknownMethod: Method "ListDevices" with
> signature "" on interface "org.bluez.input.Manager" doesn't exist
>
> Did I made a mistake ?
>
> Thanks
>
> Fred
>
> --
> -----------------------------------------------
> It is not by improving the oil lamp that one invents the electric bulb!
> -----------------------------------------------
> Danis Frederic                   Access Company
> Software engineer
> Mail : mailto:frederic.danis@access-company.com
> -----------------------------------------------
>
>

Hi Frederic,

Services don' t have a well known name, you can' t send a message to
'org.bluez.input'. You have to call ActivateService to get the Bus id
and send the message to that address.

'org.bluez' doesn't implement input paths or interfaces. I will try
update the BlueZ wiki to explain how the input service works. Give me
some hours.
http://wiki.bluez.org/wiki/Input

btw, the network service has a similar behavior and its documentation
is more complete. Check the wiki: http://wiki.bluez.org/wiki/Network

BR,
-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
