Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0511250547o16e60b21y5c3a81a5639102cc@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
In-Reply-To: <1132872886.3170.3.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com>
	 <20051118082828.GA16438@localhost.localdomain>
	 <3013cac80511180251w1d2fa8f5s80ce1da7318327e7@mail.gmail.com>
	 <20051118112611.GA17062@localhost.localdomain>
	 <3013cac80511180500h5539d5d9y3f19ce224f9e38b7@mail.gmail.com>
	 <1132660308.28644.37.camel@blade>
	 <3013cac80511221152t2911f513jb28f3944097c1b09@mail.gmail.com>
	 <1132805822.5982.15.camel@blade>
	 <3013cac80511241050o2f3d67aele639b2c69de41360@mail.gmail.com>
	 <1132872886.3170.3.camel@blade>
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
Date: Fri, 25 Nov 2005 11:47:34 -0200

Hi,

IMHO, it's enough two level of security. My suggestion is create a
bluezadmin group to
allow the device setup operations(write operations). Read operations
can be allowed to
bluezusers and bluezadmin. Another point is only the root can own the
service, I mean,
Only the root can run the hcid daemon.

/org/bluez/Manager
    - get default device
    - list adapters
/org/bluez/Device/hciX
    - UP  (*)
    - Down (*)
    - SetProperty (*)
    - GetProperty
/org/bluez/Device/hciX/Controller
/org/bluez/Device/hciX/Network
/org/bluez/Device/hciX/Serial

Configuration file suggestion:
<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

  <!-- This configuration file specifies the required security policies
       for the BlueZ to work. -->

  <!-- Only root can own the BlueZ service -->
  <policy user=3D"root">
    <allow own=3D"org.bluez"/>
  </policy>

  <policy group=3D"bluezadmin">
    <allow receive_interface=3D"org.bluez.Manager"/>
    <allow receive_interface=3D"org.bluez.Device"/>
    <allow send_interface=3D"org.bluez.Manager"/>
    <allow send_interface=3D"org.bluez.Device"/>
  </policy>

  <policy group=3D"bluezusers">
    <allow receive_interface=3D"org.bluez.Manager"/>
    <allow receive_interface=3D"org.bluez.Device"/>
    <allow send_interface=3D"org.bluez.Manager"/>
    <allow send_interface=3D"org.bluez.Device"/>
    <deny send_interface=3D"org.bluez.Device" send_member=3D"Up"/>
    <deny send_interface=3D"org.bluez.Device" send_member=3D"Down"/>
    <deny send_interface=3D"org.bluez.Device" send_member=3D"SetProperty"/>
  </policy>

  <!-- Deny anyone to invoke methods on the Manager and Device interfaces -=
->
  <policy context=3D"default">
    <deny own=3D"org.bluez"/>
    <deny send_interface=3D"org.bluez.Manager"/>
    <deny send_interface=3D"org.bluez.Device"/>
    <deny receive_interface=3D"org.bluez.Manager"/>
    <deny receive_interface=3D"org.bluez.Device"/>
  </policy>

</busconfig>

Regards,
Claudio

On 11/24/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Eduardo,
>
> > maybe we should create a bluetooth group and only allow users of that
> > group to make write operations. I'll also check eht dbus auth to see
> > if that can help. Do you have in mind any operation->"security level"
> > map?
>
> come up with some proposals. I have real clue, but we should have some
> special rights for the current session user.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
