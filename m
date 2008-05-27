Return-Path: <cyrus@holtmann.org>
Message-ID: <685df2130805270710se605e9cv8412c145578b8eb9@mail.gmail.com>
Date: Tue, 27 May 2008 10:10:42 -0400
From: "Joshua Bryant" <josh@bryantweb.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] How do you start the audio service in bluez-utils
	3.30-3
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0695735021=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0695735021==
Content-Type: multipart/alternative;
	boundary="----=_Part_16143_1901539.1211897442584"

------=_Part_16143_1901539.1211897442584
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

To get the audio plugin to load, you have to recompile with the
--enable-glib switch.

The Activate service call isn't helpful anymore. It used to return the bus
id of the audio service, but now the audio service is a plugin. So the
service you want is actually "org.bluez"

You don't need to call ActivateService anymore. Just replace ":X.Y" in your
dbus calls with "org.bluez"

I had to figure this out on my own since the documentation on
wiki.bluez.orgis outdated.

On Tue, May 27, 2008 at 9:08 AM, <bluez-users-request@lists.sourceforge.net>
wrote:

> Send Bluez-users mailing list submissions to
>        bluez-users@lists.sourceforge.net
>
> To subscribe or unsubscribe via the World Wide Web, visit
>        https://lists.sourceforge.net/lists/listinfo/bluez-users
> or, via email, send a message with subject or body 'help' to
>        bluez-users-request@lists.sourceforge.net
>
> You can reach the person managing the list at
>        bluez-users-owner@lists.sourceforge.net
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Bluez-users digest..."
>
>
> Today's Topics:
>
>   1. Re: CSR bluecore initial problem (attaboyu@163.com)
>   2. Re: Syncing a Treo 680 (jayjwa)
>   3. How do you start the audio service in bluez-utils 3.30-3
>      (ShiroiKuma)
>   4. hcid problem (attaboyu)
>   5. Re: How do you start the audio service in bluez-utils     3.30-3
>      (ShiroiKuma)
>   6. Bluetooth Keyboard Kernel 2.4 (Fritz Code)
>   7. Re: Syncing a Treo 680 (Raymond Ingles)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Mon, 26 May 2008 15:34:18 +0800 (CST)
> From: attaboyu@163.com
> Subject: Re: [Bluez-users] CSR bluecore initial problem
> To: "BlueZ users" <bluez-users@lists.sourceforge.net>
> Message-ID:
>        <25980571.990131211787258597.JavaMail.coremail@bj163app120.163.com>
> Content-Type: text/plain; charset="utf-8"
>
> Thanks indeed, it works!
>
> ?2008-05-24?"Peter Wurmsdobler" <peter@wurmsdobler.org> ???
> >
> >
> >Hello,
> >
> >a few months back I encountered a similar problem. hciattach did not
> >(and still does not) always succeed, and bccmd seems to have a problem
> >using the BlueCore serial protocol (bcsp), possibly a race condition.
> >That's why I have to use:
> >
> >      /usr/sbin/hciattach /dev/ttymxc2 bcsp 57600 flow
> >      /usr/sbin/hciconfig hci0 up
> >      /usr/sbin/bccmd -t hci psload -r
> /usr/etc/bluetooth/apm6628BT-UART.psr
> >      killall hciattach
> >      /usr/sbin/hciattach /dev/ttymxc2 bcsp 115200 flow
> >      /usr/sbin/hciconfig hci0 up
> >
> >Notice the bccmd -t hci, so you have to attach first using bcsp, then
> >use bccmd with this hci in order to download the psr file (which will
> >reset the BlueCore), then kill the hci and re-attach.
> >
> >Hope this helps,
> >peter
> >
> >
> >
> >
> >');
> >       }
> >//-->
> >
> >
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
> Message: 2
> Date: Mon, 26 May 2008 05:44:02 -0400
> From: jayjwa <jayjwa@atr2.ath.cx>
> Subject: Re: [Bluez-users] Syncing a Treo 680
> To: BlueZ users <bluez-users@lists.sourceforge.net>
> Message-ID: <alpine.LNX.1.00.0805251428300.13798@nge2.ngu.pk>
> Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
>
>
>
> On Sat, 24 May 2008, bluez-users.10.judebert@spamgourmet.com wrote:
>
> -> I gave both pages a fair shake.  Short story: I'm still willing to
> provide
> -> $20 for a walkthrough.  Long story: I had the following problems:
>
> I don't have a Treo, or have seen one, but maybe I can help on the bluez
> side of things.
>
> -> >
> http://www.gurulabs.com/goodies/Using_Linux_and_Bluetooth_DUN_with_the_Treo650.php
> -> >
> -> That page is set up for Red Hat.  Debian doesn't have the bluez-pin
> package,
> -> and its hcid.conf is a little different: it contains the PIN, and
> doesn't
> -> have a dbus_pin_helper (not in any of the packages, either). There's
> also no
> -> system-config-security-level.  Nevertheless, everything seems to go
> well,
> -> until I enter my PIN. Even when I set up the "feed-pin.sh" file, I get
> an
> -> error dialog on the Treo 680 titled "Bluetooth Security": "Unable to add
> -> ComputerName-0 to your trusted device list."
>
> Red Hat is moldy-oldy and those objects/packages are now obsolete from the
> current bluez setup. PIN/pairing you do with bluez-gnome or I use the
> passkey-agent/auth-agent that's in the bluez-utils source, from the command
> line since gnome stuff won't build on my system as I don't have gnome nor
> its
> libraries. The "Unable to...trusted device list." likely means there was
> nothing on your system answering the pairing request (properly). You seem
> to
> have pairing down, as you said below.
>
> -> > http://howto.pilot-link.org/bluesync/
> -> >
> -> This page also requires packages not available on Debian: bluez-lib,
> -> bluez-pan and bluez-sdp.  The Palm pieces seem more relevant to my Treo;
> -> however, the Treo seems to already have a Bluetooth HotSync profile.  It
> has
> -> a nice little tutorial that, after the equivalent of figure 5-8, says I
> have
> -> to set up a virtual serial port on my computer.  I assume that's what
> hcid,
> -> pand, and rfcomm are doing, and carry on.  Actually clicking the "Launch
> -> HotSync" button leads to a message: "Connecting with the desktop using
> -> ComputerName-0", followed by an error dialog titled "HotSync Problem":
> -> "Unable to initiate HotSync operation because the port is in use by
> another
> -> application."
>
> pand is part of bluez-utils. sdpd as a binary is gone. The actual packages
> are
> listed at http://www.bluez.org/download.html. Distributions mix & match
> those
> and create many packages from those listed few.
>
>
> Changelog:
>
> ver 3.30:
> ...
>         Remove build option for deprecated sdpd binary.
>
>
> You can use hcid -s to enable sdp. Setting up a serial port with rfcomm is
> something like so, using my phone's bluetooth modem as an example:
>
> root@vdrl /tmp # hcitool scan
> Scanning ...
>         00:1C:62:19:B1:6A       LG VX8300
>
> passkey-agent --default 0000 00:1C:62:19:B1:6A &  <-- Use bluez-gnome for
> auth-agent &                                          these. It doesn't
> build
>                                                       on my system due to
> lack
>                                                       of gnome.
>
> sdptool browse 00:1C:62:19:B1:6A
>
> Passkey request for device 00:1C:62:19:B1:6A
> Browsing 00:1C:62:19:B1:6A ...
>
> ....
>
> Service Name: BT DIAG
> Service RecHandle: 0x10005
> Service Class ID List:
>   "Serial Port" (0x1101)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 16                <--- channel 16
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100
> Profile Descriptor List:
>   "Serial Port" (0x1101)       <-- serial port
>
> rfcomm --help
>
> RFCOMM configuration utility ver 3.31
> Usage:
>         rfcomm [options] <command> <dev>
>
> Options:
>         -i [hciX|bdaddr]      Local HCI device or BD Address
>         -h, --help            Display help
>         -r, --raw             Switch TTY into raw mode
>         -A, --auth            Enable authentication
>         -E, --encrypt         Enable encryption
>         -S, --secure          Secure connection
>         -M, --master          Become the master of a piconet
>         -f, --config [file]   Specify alternate config file
>         -a                    Show all devices (default)
>
> Commands:
>         bind     <dev> <bdaddr> [channel]       Bind device
>         release  <dev>                          Release device
>         show     <dev>                          Show device
>         connect  <dev> <bdaddr> [channel]       Connect device
>         listen   <dev> [channel [cmd]]          Listen
>         watch    <dev> [channel [cmd]]          Watch
>
> rfcomm -i hci0 bind 0 00:1C:62:19:B1:6A 16   <-- "0" means "rfcomm0"
> rfcomm -a
> rfcomm0: 00:0A:3A:7C:5C:74 -> 00:1C:62:19:B1:6A channel 16 clean
>
> Then you'd give /dev/rfcomm0 to whatever was needing it (pppd, etc.) Make
> sure
> the rfcomm device files exist and are correct (procinfo -a should show the
> major number for rfcomm, here it's 216):
>
> crw-rw-rw- 1 root root 216, 0 2007-12-16 07:29 /dev/rfcomm0
> crw-rw-rw- 1 root root 216, 1 2007-12-16 07:29 /dev/rfcomm1
> crw-rw-rw- 1 root root 216, 2 2007-12-16 07:29 /dev/rfcomm2
>
>
> Using dund might skip the above step, as it might bind /dev/rfcomm0 itself.
> Note when using dund/pppd you usually use a script to hold the options to
> pppd
> and then a connection script. If you put the script in
> /etc/ppp/peers/ (whatever) you can do 'pppd call (whatever)'
>
> rfcomm0: 00:0A:3A:7C:5C:74 -> 00:1C:62:19:B1:6A channel 16 connected
> [tty-attached]
>
> Unfortunately, Verizon does a major disservice to their customers by
> crippling
> the phone's modem via bluetooth so I can't show you pppd in action since
> the
> phone ignores the bt commands from here on out (but I have done it via USB
> so
> I know it works).
>
> Release rfcomm after you use it. Maybe the 'port is in use' is from that?
>
> rfcomm release 0
>
>
>
> -> I assume this is because it never asked for a PIN, but I just don't
> know.
> -> When I carry on, adding the /etc/bluetooth/pin file as instructed in
> Chapter
> -> 6, I get the same "Unable to add" message as above.
>
> That file isn't used anymore, as far as I can tell. Bluez is a fast moving
> target (as I write this I find there's another new release now). They
> release
> new versions with major fixes and functionality changes all the time. When
> you
> use a distribution's packaged version, you run into a problem - whether to
> try
> to make something that's already out-dated and containing bugs/missing
> functionality (as compared to the current bluez source releases) work, or
> to
> try to go it alone and build the current bluez sources yourself. Problems
> arise when you try to help someone out as well, because of the differences
> in
> versions and lag time between disto/packaged bluez and the released
> sources.
>
>
> -> Unfortunately, I still got the "port is in use" error.  I went back
> through
> -> the second link, added my computer as a network, and tried to follow the
> -> setup in Chapter 7.1 for surfing the web (because Chapter 7.2 says that
> I
> -> need the pppd set up here), but I don't have sdpd running, and I don't
> know
> -> where to find it.
>
> The rest of the tut looks OK, from 7-1 on, with the exception that sdpd is
> gone from bluez-utils and hcid -s takes its place.
>
>
>
>
> ------------------------------
>
> Message: 3
> Date: Tue, 27 May 2008 02:18:54 +0200
> From: "ShiroiKuma" <bluez-users@sumou.com>
> Subject: [Bluez-users] How do you start the audio service in
>        bluez-utils     3.30-3
> To: bluez-users@lists.sourceforge.net
> Message-ID: <20080527001041.M20414@ShiroiKuma.org>
> Content-Type: text/plain;       charset=utf-8
>
> Hi:
>
> I'm having some difficulties using bluez-audio. I'm using Debian sid
> bluez-utils 3.30-3
>
> I've seen that since version 3.30-1 the bluez-audio service is no longer
> started via
> /usr/lib/bluetooth/bluetoothd-service-audio and instead bluez-utils
> switched to shared library objects which are loaded
> by hcid
>
> How do I start the audio service now?
>
> dbus-send --system --print-reply --dest=org.bluez /org/bluez
> org.bluez.Manager.ListServices gives me:
> method return sender=:1.45 -> dest=:1.50 reply_serial=2
>   array [
>   ]
>
> and dbus-send --system --type=method_call --print-reply --dest=org.bluez
> /org/bluez org.bluez.Manager.ActivateService
> string:audio gives me:
> Error org.bluez.Error.NoSuchService: No such service
>
> I've googled, but haven't found anything that would point me towards a
> solution, the only mention, The bluez Wiki at
> http://wiki.bluez.org/wiki/HOWTO/AudioDevices just says:
> Make sure the audio service is installed
>
> So how should I proceed?
>
>
>
> ------------------------------
>
> Message: 4
> Date: Tue, 27 May 2008 10:36:01 +0800 (CST)
> From: attaboyu <attaboyu@163.com>
> Subject: [Bluez-users] hcid problem
> To: "BlueZ users" <bluez-users@lists.sourceforge.net>
> Message-ID:
>        <11216581.210541211855761644.JavaMail.coremail@bj163app120.163.com>
> Content-Type: text/plain; charset="gbk"
>
>  Hi all
>  I have got a hcid problem below:
>  $hcid -f /etc/bluetooth/hcid.conf
>  BUG: scheduling while atomic: hcid/0x00000101/51
>  caller is schedule+0xec/0x12c
>
>  There is no hcid process running from ps view. if run hcid again,
> something will be issued:
>
> BUG: scheduling while atomic: swapper/0x00000103/0
> caller is schedule+0xec/0x12c
> BUG: scheduling from the idle thread!
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000004
> pgd = c0004000
> [00000004] *pgd=
>
>  as kernel version is 2.6.10, so I use a old bluez version 3.12
>
>
>
>
>
> --
>
>  Best Regards
>  ------------
>  Tony
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
> Message: 5
> Date: Tue, 27 May 2008 09:29:54 +0200
> From: "ShiroiKuma" <bluez-users@sumou.com>
> Subject: Re: [Bluez-users] How do you start the audio service in
>        bluez-utils     3.30-3
> To: BlueZ users <bluez-users@lists.sourceforge.net>
> Message-ID: <20080527072731.M23487@ShiroiKuma.org>
> Content-Type: text/plain;       charset=utf-8
>
> Further to this problem, I've found in the syslog the following:
> Can't init plugin /usr/lib/bluetooth/plugins/libaudio.so
>
> There's mention of this problem at
> http://article.gmane.org/gmane.linux.bluez.user/13790
>
> Is there any solution other than recompiling bluez-utils?
>
>
>
>
> ------------------------------
>
> Message: 6
> Date: Tue, 27 May 2008 09:34:10 +0200
> From: "Fritz Code" <codefritz@googlemail.com>
> Subject: [Bluez-users] Bluetooth Keyboard Kernel 2.4
> To: bluez-users@lists.sourceforge.net
> Message-ID:
>        <3e9cdced0805270034s3409b6aby382454375651b711@mail.gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Hi,
>
> I have to connect a bluetooth keyboard, I'm using Kernel 2.4.21.
> The bluetooth subsystem and bluez utils (hcitool, hcid, hciconfig) work so
> far.
>
> Well I have two options now, try this way (which is not related to bluez):
> http://klausler.com/msbtkb-linux.html
>
> Or try to use bluez.
> If I use bluez I have to load hidp.o module, right?
> But my kernel 2.4.21 doesn't provide such a module.
>
> So I'm not sure what to do in order to get a bluetooth keyboard running in
> my Kernel 2.4.21.
> If there are any hints / experiences.
>
> Note: I'm flexible in the keyboard type and manufactuarer,  so if anybody
> can recommend a keyboard for the use of Kernel 2.4.21 I would appreciate
> that.
>
> Thanks.
> Fritz.
>
>
> --
> Regards,
> --Codefritz
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
> Message: 7
> Date: Tue, 27 May 2008 09:08:45 -0400
> From: "Raymond Ingles" <sorceror171@gmail.com>
> Subject: Re: [Bluez-users] Syncing a Treo 680
> To: "BlueZ users" <bluez-users@lists.sourceforge.net>
> Message-ID:
>        <a481fbf0805270608y343d265av25ded1e58cf9db25@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> On Sat, May 24, 2008 at 12:46 AM,
> <bluez-users.10.judebert@spamgourmet.com> wrote:
> > I gave both pages a fair shake.  Short story: I'm still willing to
> > provide $20 for a walkthrough.  Long story: I had the following problems:
>
>  I'm using Ubuntu 7.10. Here's what I've used to get bluetooth
> connectivity with my Treo 650:
>
>  1. Edit /etc/default/bluetooth, and set the following variables:
>     DUND_ENABLED=1
>     DUND_OPTIONS="--listen --persist --msdun call treo"
>     PAND_ENABLED=1
>     PAND_OPTIONS="--listen --role NAP"
>     SDPTOOL_OPTIONS="add --channel=1 SP"
>
>  (Note, that's not the whole file, it's just the variables that need to be
> set.)
>
>  2. If you want to surf the web on the Palm through your computer,
> create the file /etc/init.d/btinternet with the following contents:
>
>    #!/bin/sh
>    # enable IP forwarding
>    echo 1 > /proc/sys/net/ipv4/ip_forward
>    # enable masquerading onto eth0
>    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
>
>  (Assuming eth0 is your computer's connection to the internet.)
>
>  3. Create the file /etc/ppp/peers/treo with the following contents:
>
>    proxyarp
>    115200
>    172.16.10.1:172.16.10.2
>    local
>    ms-dns IP.ADDR.OF.DNS.SERVER
>    noauth
>    debug
>    ktune
>
>  Note: the "IP.ADDR.OF.DNS.SERVER" needs to be the ip address of the
> DNS server your computer's using. Use "nslookup www.google.com" and
> copy the ip address in the line starting with "Server:".
>
>  4. Edit /etc/bluetooth/hcid.conf and set the following values:
>
>        security auto;
>        passkey "WHATEVER PASSKEY YOU WANT";
>
>  Obviously, you set a PIN number there for pairing.
>
> 5. Edit /etc/bluetooth/rfcomm.conf and set the following values:
>
>       # Automatically bind the device at startup
>        bind yes;
>        # The Bluetooth address of your Treo (find with hcitool scan
> when Treo is discoverable)
>        device DE:AD:BE:EF:D0:0D;
>       # RFCOMM channel for the connection
>        channel 1;
>       # Description of the connection
>        comment "Palm link";
>
> 6. Restart bluetooth services (/etc/init.d/bluetooth stop;
> /etc/init.d/bluetooth start), run the btinternet script above as root.
>
> 7. Now we're on the Treo. Pair the Treo with the computer using the
> PIN you set above. (Bluetooth app, "Setup Devices", "Nearby Devices",
> pick your computer, enter the PIN when prompted.)
>
> 8. Go to "Preferences", choose "Connection", and name it something
> like "BT PAN conn". "Connect to: Local Network; Via: Bluetooth;
> Device: your-machine-name". Details - Speed: 115,200; Flow Ctl:
> Automatic."
>
> 9. Prefs -> Network. Create a new service, "BT PAN nw", set the
> Connection to the one you just created in step 8. Username: your user
> name on the machine, Password: prompt. Details: set the idle timeout
> to whatever you like. Choose "Advanced" from "Details", and set "IP
> Address" to "Automatic", unset "Query DNS", and put the DNS server you
> found above in the "Primary DNS" field.
>
>  At this point, you *should* be able to get a network connection via
> PAN, and surf the net through your Palm. Using the normal commands to
> do network hotsyncs and things *should* work. If not, we also
> configured DUN (PPP over emulated serial) above. In my experience,
> it's been a bit slower/less reliable than PAN, but it also works.
> Here's how to set *that* up:
>
> 10. Go to "Preferences", choose "Connection", and name it something
> like "BT DUN conn". "Connect to: PC; Via: Bluetooth; Device:
> your-machine-name". Details - Speed: 115,200; Flow Ctl: Automatic."
>
> 11. Prefs -> Network. Create a new service, "BT DUN nw", set the
> Connection to the one you just created in step 10. Username: your user
> name on the machine, Password: prompt. Details: set the idle timeout
> to whatever you like. Choose "Advanced" from "Details", and set "IP
> Address" to "Automatic", set "Query DNS" to active (checkbox set). No
> script is needed.
>
>  This has worked for me on two different machines with two different
> Bluetooth dongles, from Ubuntu 6.10 onward. If it works for you,
> donate the money to the Free Software Foundation, or the Debian
> project.
>
>
>
> ------------------------------
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>
> ------------------------------
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
> End of Bluez-users Digest, Vol 25, Issue 21
> *******************************************
>

------=_Part_16143_1901539.1211897442584
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

To get the audio plugin to load, you have to recompile with the --enable-glib switch.<br><br>The Activate service call isn&#39;t helpful anymore. It used to return the bus id of the audio service, but now the audio service is a plugin. So the service you want is actually &quot;org.bluez&quot;<br>
<br>You don&#39;t need to call ActivateService anymore. Just replace &quot;:X.Y&quot; in your dbus calls with &quot;org.bluez&quot;<br><br>I had to figure this out on my own since the documentation on <a href="http://wiki.bluez.org">wiki.bluez.org</a> is outdated. <br>
<br><div class="gmail_quote">On Tue, May 27, 2008 at 9:08 AM,  &lt;<a href="mailto:bluez-users-request@lists.sourceforge.net">bluez-users-request@lists.sourceforge.net</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Send Bluez-users mailing list submissions to<br>
 &nbsp; &nbsp; &nbsp; &nbsp;<a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a><br>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
 &nbsp; &nbsp; &nbsp; &nbsp;<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
or, via email, send a message with subject or body &#39;help&#39; to<br>
 &nbsp; &nbsp; &nbsp; &nbsp;<a href="mailto:bluez-users-request@lists.sourceforge.net">bluez-users-request@lists.sourceforge.net</a><br>
<br>
You can reach the person managing the list at<br>
 &nbsp; &nbsp; &nbsp; &nbsp;<a href="mailto:bluez-users-owner@lists.sourceforge.net">bluez-users-owner@lists.sourceforge.net</a><br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of Bluez-users digest...&quot;<br>
<br>
<br>
Today&#39;s Topics:<br>
<br>
 &nbsp; 1. Re: CSR bluecore initial problem (<a href="mailto:attaboyu@163.com">attaboyu@163.com</a>)<br>
 &nbsp; 2. Re: Syncing a Treo 680 (jayjwa)<br>
 &nbsp; 3. How do you start the audio service in bluez-utils 3.30-3<br>
 &nbsp; &nbsp; &nbsp;(ShiroiKuma)<br>
 &nbsp; 4. hcid problem (attaboyu)<br>
 &nbsp; 5. Re: How do you start the audio service in bluez-utils &nbsp; &nbsp; 3.30-3<br>
 &nbsp; &nbsp; &nbsp;(ShiroiKuma)<br>
 &nbsp; 6. Bluetooth Keyboard Kernel 2.4 (Fritz Code)<br>
 &nbsp; 7. Re: Syncing a Treo 680 (Raymond Ingles)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Mon, 26 May 2008 15:34:18 +0800 (CST)<br>
From: <a href="mailto:attaboyu@163.com">attaboyu@163.com</a><br>
Subject: Re: [Bluez-users] CSR bluecore initial problem<br>
To: &quot;BlueZ users&quot; &lt;<a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a>&gt;<br>
Message-ID:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;&lt;<a href="mailto:25980571.990131211787258597.JavaMail.coremail@bj163app120.163.com">25980571.990131211787258597.JavaMail.coremail@bj163app120.163.com</a>&gt;<br>
Content-Type: text/plain; charset=&quot;utf-8&quot;<br>
<br>
Thanks indeed, it works!<br>
<br>
?2008-05-24?&quot;Peter Wurmsdobler&quot; &lt;<a href="mailto:peter@wurmsdobler.org">peter@wurmsdobler.org</a>&gt; ???<br>
&gt;<br>
&gt;<br>
&gt;Hello,<br>
&gt;<br>
&gt;a few months back I encountered a similar problem. hciattach did not<br>
&gt;(and still does not) always succeed, and bccmd seems to have a problem<br>
&gt;using the BlueCore serial protocol (bcsp), possibly a race condition.<br>
&gt;That&#39;s why I have to use:<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp;/usr/sbin/hciattach /dev/ttymxc2 bcsp 57600 flow<br>
&gt; &nbsp; &nbsp; &nbsp;/usr/sbin/hciconfig hci0 up<br>
&gt; &nbsp; &nbsp; &nbsp;/usr/sbin/bccmd -t hci psload -r /usr/etc/bluetooth/apm6628BT-UART.psr<br>
&gt; &nbsp; &nbsp; &nbsp;killall hciattach<br>
&gt; &nbsp; &nbsp; &nbsp;/usr/sbin/hciattach /dev/ttymxc2 bcsp 115200 flow<br>
&gt; &nbsp; &nbsp; &nbsp;/usr/sbin/hciconfig hci0 up<br>
&gt;<br>
&gt;Notice the bccmd -t hci, so you have to attach first using bcsp, then<br>
&gt;use bccmd with this hci in order to download the psr file (which will<br>
&gt;reset the BlueCore), then kill the hci and re-attach.<br>
&gt;<br>
&gt;Hope this helps,<br>
&gt;peter<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;&#39;);<br>
&gt; &nbsp; &nbsp; &nbsp; }<br>
&gt;//--&gt;<br>
&gt;<br>
&gt;<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Mon, 26 May 2008 05:44:02 -0400<br>
From: jayjwa &lt;<a href="mailto:jayjwa@atr2.ath.cx">jayjwa@atr2.ath.cx</a>&gt;<br>
Subject: Re: [Bluez-users] Syncing a Treo 680<br>
To: BlueZ users &lt;<a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a>&gt;<br>
Message-ID: &lt;<a href="mailto:alpine.LNX.1.00.0805251428300.13798@nge2.ngu.pk">alpine.LNX.1.00.0805251428300.13798@nge2.ngu.pk</a>&gt;<br>
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII<br>
<br>
<br>
<br>
On Sat, 24 May 2008, <a href="mailto:bluez-users.10.judebert@spamgourmet.com">bluez-users.10.judebert@spamgourmet.com</a> wrote:<br>
<br>
-&gt; I gave both pages a fair shake. &nbsp;Short story: I&#39;m still willing to provide<br>
-&gt; $20 for a walkthrough. &nbsp;Long story: I had the following problems:<br>
<br>
I don&#39;t have a Treo, or have seen one, but maybe I can help on the bluez<br>
side of things.<br>
<br>
-&gt; &gt; <a href="http://www.gurulabs.com/goodies/Using_Linux_and_Bluetooth_DUN_with_the_Treo650.php" target="_blank">http://www.gurulabs.com/goodies/Using_Linux_and_Bluetooth_DUN_with_the_Treo650.php</a><br>
-&gt; &gt;<br>
-&gt; That page is set up for Red Hat. &nbsp;Debian doesn&#39;t have the bluez-pin package,<br>
-&gt; and its hcid.conf is a little different: it contains the PIN, and doesn&#39;t<br>
-&gt; have a dbus_pin_helper (not in any of the packages, either). There&#39;s also no<br>
-&gt; system-config-security-level. &nbsp;Nevertheless, everything seems to go well,<br>
-&gt; until I enter my PIN. Even when I set up the &quot;feed-pin.sh&quot; file, I get an<br>
-&gt; error dialog on the Treo 680 titled &quot;Bluetooth Security&quot;: &quot;Unable to add<br>
-&gt; ComputerName-0 to your trusted device list.&quot;<br>
<br>
Red Hat is moldy-oldy and those objects/packages are now obsolete from the<br>
current bluez setup. PIN/pairing you do with bluez-gnome or I use the<br>
passkey-agent/auth-agent that&#39;s in the bluez-utils source, from the command<br>
line since gnome stuff won&#39;t build on my system as I don&#39;t have gnome nor its<br>
libraries. The &quot;Unable to...trusted device list.&quot; likely means there was<br>
nothing on your system answering the pairing request (properly). You seem to<br>
have pairing down, as you said below.<br>
<br>
-&gt; &gt; <a href="http://howto.pilot-link.org/bluesync/" target="_blank">http://howto.pilot-link.org/bluesync/</a><br>
-&gt; &gt;<br>
-&gt; This page also requires packages not available on Debian: bluez-lib,<br>
-&gt; bluez-pan and bluez-sdp. &nbsp;The Palm pieces seem more relevant to my Treo;<br>
-&gt; however, the Treo seems to already have a Bluetooth HotSync profile. &nbsp;It has<br>
-&gt; a nice little tutorial that, after the equivalent of figure 5-8, says I have<br>
-&gt; to set up a virtual serial port on my computer. &nbsp;I assume that&#39;s what hcid,<br>
-&gt; pand, and rfcomm are doing, and carry on. &nbsp;Actually clicking the &quot;Launch<br>
-&gt; HotSync&quot; button leads to a message: &quot;Connecting with the desktop using<br>
-&gt; ComputerName-0&quot;, followed by an error dialog titled &quot;HotSync Problem&quot;:<br>
-&gt; &quot;Unable to initiate HotSync operation because the port is in use by another<br>
-&gt; application.&quot;<br>
<br>
pand is part of bluez-utils. sdpd as a binary is gone. The actual packages are<br>
listed at <a href="http://www.bluez.org/download.html" target="_blank">http://www.bluez.org/download.html</a>. Distributions mix &amp; match those<br>
and create many packages from those listed few.<br>
<br>
<br>
Changelog:<br>
<br>
ver 3.30:<br>
...<br>
 &nbsp; &nbsp; &nbsp; &nbsp; Remove build option for deprecated sdpd binary.<br>
<br>
<br>
You can use hcid -s to enable sdp. Setting up a serial port with rfcomm is<br>
something like so, using my phone&#39;s bluetooth modem as an example:<br>
<br>
root@vdrl /tmp # hcitool scan<br>
Scanning ...<br>
 &nbsp; &nbsp; &nbsp; &nbsp; 00:1C:62:19:B1:6A &nbsp; &nbsp; &nbsp; LG VX8300<br>
<br>
passkey-agent --default 0000 00:1C:62:19:B1:6A &amp; &nbsp;&lt;-- Use bluez-gnome for<br>
auth-agent &amp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;these. It doesn&#39;t build<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; on my system due to lack<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; of gnome.<br>
<br>
sdptool browse 00:1C:62:19:B1:6A<br>
<br>
Passkey request for device 00:1C:62:19:B1:6A<br>
Browsing 00:1C:62:19:B1:6A ...<br>
<br>
....<br>
<br>
Service Name: BT DIAG<br>
Service RecHandle: 0x10005<br>
Service Class ID List:<br>
 &nbsp; &quot;Serial Port&quot; (0x1101)<br>
Protocol Descriptor List:<br>
 &nbsp; &quot;L2CAP&quot; (0x0100)<br>
 &nbsp; &quot;RFCOMM&quot; (0x0003)<br>
 &nbsp; &nbsp; Channel: 16 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;--- channel 16<br>
Language Base Attr List:<br>
 &nbsp; code_ISO639: 0x656e<br>
 &nbsp; encoding: &nbsp; &nbsp;0x6a<br>
 &nbsp; base_offset: 0x100<br>
Profile Descriptor List:<br>
 &nbsp; &quot;Serial Port&quot; (0x1101) &nbsp; &nbsp; &nbsp; &lt;-- serial port<br>
<br>
rfcomm --help<br>
<br>
RFCOMM configuration utility ver 3.31<br>
Usage:<br>
 &nbsp; &nbsp; &nbsp; &nbsp; rfcomm [options] &lt;command&gt; &lt;dev&gt;<br>
<br>
Options:<br>
 &nbsp; &nbsp; &nbsp; &nbsp; -i [hciX|bdaddr] &nbsp; &nbsp; &nbsp;Local HCI device or BD Address<br>
 &nbsp; &nbsp; &nbsp; &nbsp; -h, --help &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Display help<br>
 &nbsp; &nbsp; &nbsp; &nbsp; -r, --raw &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Switch TTY into raw mode<br>
 &nbsp; &nbsp; &nbsp; &nbsp; -A, --auth &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Enable authentication<br>
 &nbsp; &nbsp; &nbsp; &nbsp; -E, --encrypt &nbsp; &nbsp; &nbsp; &nbsp; Enable encryption<br>
 &nbsp; &nbsp; &nbsp; &nbsp; -S, --secure &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Secure connection<br>
 &nbsp; &nbsp; &nbsp; &nbsp; -M, --master &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Become the master of a piconet<br>
 &nbsp; &nbsp; &nbsp; &nbsp; -f, --config [file] &nbsp; Specify alternate config file<br>
 &nbsp; &nbsp; &nbsp; &nbsp; -a &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Show all devices (default)<br>
<br>
Commands:<br>
 &nbsp; &nbsp; &nbsp; &nbsp; bind &nbsp; &nbsp; &lt;dev&gt; &lt;bdaddr&gt; [channel] &nbsp; &nbsp; &nbsp; Bind device<br>
 &nbsp; &nbsp; &nbsp; &nbsp; release &nbsp;&lt;dev&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Release device<br>
 &nbsp; &nbsp; &nbsp; &nbsp; show &nbsp; &nbsp; &lt;dev&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Show device<br>
 &nbsp; &nbsp; &nbsp; &nbsp; connect &nbsp;&lt;dev&gt; &lt;bdaddr&gt; [channel] &nbsp; &nbsp; &nbsp; Connect device<br>
 &nbsp; &nbsp; &nbsp; &nbsp; listen &nbsp; &lt;dev&gt; [channel [cmd]] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Listen<br>
 &nbsp; &nbsp; &nbsp; &nbsp; watch &nbsp; &nbsp;&lt;dev&gt; [channel [cmd]] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Watch<br>
<br>
rfcomm -i hci0 bind 0 00:1C:62:19:B1:6A 16 &nbsp; &lt;-- &quot;0&quot; means &quot;rfcomm0&quot;<br>
rfcomm -a<br>
rfcomm0: 00:0A:3A:7C:5C:74 -&gt; 00:1C:62:19:B1:6A channel 16 clean<br>
<br>
Then you&#39;d give /dev/rfcomm0 to whatever was needing it (pppd, etc.) Make sure<br>
the rfcomm device files exist and are correct (procinfo -a should show the<br>
major number for rfcomm, here it&#39;s 216):<br>
<br>
crw-rw-rw- 1 root root 216, 0 2007-12-16 07:29 /dev/rfcomm0<br>
crw-rw-rw- 1 root root 216, 1 2007-12-16 07:29 /dev/rfcomm1<br>
crw-rw-rw- 1 root root 216, 2 2007-12-16 07:29 /dev/rfcomm2<br>
<br>
<br>
Using dund might skip the above step, as it might bind /dev/rfcomm0 itself.<br>
Note when using dund/pppd you usually use a script to hold the options to pppd<br>
and then a connection script. If you put the script in<br>
/etc/ppp/peers/ (whatever) you can do &#39;pppd call (whatever)&#39;<br>
<br>
rfcomm0: 00:0A:3A:7C:5C:74 -&gt; 00:1C:62:19:B1:6A channel 16 connected [tty-attached]<br>
<br>
Unfortunately, Verizon does a major disservice to their customers by crippling<br>
the phone&#39;s modem via bluetooth so I can&#39;t show you pppd in action since the<br>
phone ignores the bt commands from here on out (but I have done it via USB so<br>
I know it works).<br>
<br>
Release rfcomm after you use it. Maybe the &#39;port is in use&#39; is from that?<br>
<br>
rfcomm release 0<br>
<br>
<br>
<br>
-&gt; I assume this is because it never asked for a PIN, but I just don&#39;t know.<br>
-&gt; When I carry on, adding the /etc/bluetooth/pin file as instructed in Chapter<br>
-&gt; 6, I get the same &quot;Unable to add&quot; message as above.<br>
<br>
That file isn&#39;t used anymore, as far as I can tell. Bluez is a fast moving<br>
target (as I write this I find there&#39;s another new release now). They release<br>
new versions with major fixes and functionality changes all the time. When you<br>
use a distribution&#39;s packaged version, you run into a problem - whether to try<br>
to make something that&#39;s already out-dated and containing bugs/missing<br>
functionality (as compared to the current bluez source releases) work, or to<br>
try to go it alone and build the current bluez sources yourself. Problems<br>
arise when you try to help someone out as well, because of the differences in<br>
versions and lag time between disto/packaged bluez and the released sources.<br>
<br>
<br>
-&gt; Unfortunately, I still got the &quot;port is in use&quot; error. &nbsp;I went back through<br>
-&gt; the second link, added my computer as a network, and tried to follow the<br>
-&gt; setup in Chapter 7.1 for surfing the web (because Chapter 7.2 says that I<br>
-&gt; need the pppd set up here), but I don&#39;t have sdpd running, and I don&#39;t know<br>
-&gt; where to find it.<br>
<br>
The rest of the tut looks OK, from 7-1 on, with the exception that sdpd is<br>
gone from bluez-utils and hcid -s takes its place.<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Tue, 27 May 2008 02:18:54 +0200<br>
From: &quot;ShiroiKuma&quot; &lt;<a href="mailto:bluez-users@sumou.com">bluez-users@sumou.com</a>&gt;<br>
Subject: [Bluez-users] How do you start the audio service in<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bluez-utils &nbsp; &nbsp; 3.30-3<br>
To: <a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a><br>
Message-ID: &lt;20080527001041.M20414@ShiroiKuma.org&gt;<br>
Content-Type: text/plain; &nbsp; &nbsp; &nbsp; charset=utf-8<br>
<br>
Hi:<br>
<br>
I&#39;m having some difficulties using bluez-audio. I&#39;m using Debian sid bluez-utils 3.30-3<br>
<br>
I&#39;ve seen that since version 3.30-1 the bluez-audio service is no longer started via<br>
/usr/lib/bluetooth/bluetoothd-service-audio and instead bluez-utils switched to shared library objects which are loaded<br>
by hcid<br>
<br>
How do I start the audio service now?<br>
<br>
dbus-send --system --print-reply --dest=org.bluez /org/bluez org.bluez.Manager.ListServices gives me:<br>
method return sender=:1.45 -&gt; dest=:1.50 reply_serial=2<br>
 &nbsp; array [<br>
 &nbsp; ]<br>
<br>
and dbus-send --system --type=method_call --print-reply --dest=org.bluez /org/bluez org.bluez.Manager.ActivateService<br>
string:audio gives me:<br>
Error org.bluez.Error.NoSuchService: No such service<br>
<br>
I&#39;ve googled, but haven&#39;t found anything that would point me towards a solution, the only mention, The bluez Wiki at<br>
<a href="http://wiki.bluez.org/wiki/HOWTO/AudioDevices" target="_blank">http://wiki.bluez.org/wiki/HOWTO/AudioDevices</a> just says:<br>
Make sure the audio service is installed<br>
<br>
So how should I proceed?<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 4<br>
Date: Tue, 27 May 2008 10:36:01 +0800 (CST)<br>
From: attaboyu &lt;<a href="mailto:attaboyu@163.com">attaboyu@163.com</a>&gt;<br>
Subject: [Bluez-users] hcid problem<br>
To: &quot;BlueZ users&quot; &lt;<a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a>&gt;<br>
Message-ID:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;&lt;<a href="mailto:11216581.210541211855761644.JavaMail.coremail@bj163app120.163.com">11216581.210541211855761644.JavaMail.coremail@bj163app120.163.com</a>&gt;<br>
Content-Type: text/plain; charset=&quot;gbk&quot;<br>
<br>
&nbsp;Hi all<br>
&nbsp;I have got a hcid problem below:<br>
&nbsp;$hcid -f /etc/bluetooth/hcid.conf<br>
&nbsp;BUG: scheduling while atomic: hcid/0x00000101/51<br>
&nbsp;caller is schedule+0xec/0x12c<br>
<br>
&nbsp;There is no hcid process running from ps view. if run hcid again, something will be issued:<br>
<br>
BUG: scheduling while atomic: swapper/0x00000103/0<br>
caller is schedule+0xec/0x12c<br>
BUG: scheduling from the idle thread!<br>
Unable to handle kernel NULL pointer dereference at virtual address 00000004<br>
pgd = c0004000<br>
[00000004] *pgd=<br>
<br>
&nbsp;as kernel version is 2.6.10, so I use a old bluez version 3.12<br>
<br>
<br>
<br>
<br>
<br>
--<br>
<br>
&nbsp;Best Regards<br>
&nbsp;------------<br>
&nbsp;Tony<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
<br>
------------------------------<br>
<br>
Message: 5<br>
Date: Tue, 27 May 2008 09:29:54 +0200<br>
From: &quot;ShiroiKuma&quot; &lt;<a href="mailto:bluez-users@sumou.com">bluez-users@sumou.com</a>&gt;<br>
Subject: Re: [Bluez-users] How do you start the audio service in<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bluez-utils &nbsp; &nbsp; 3.30-3<br>
To: BlueZ users &lt;<a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a>&gt;<br>
Message-ID: &lt;20080527072731.M23487@ShiroiKuma.org&gt;<br>
Content-Type: text/plain; &nbsp; &nbsp; &nbsp; charset=utf-8<br>
<br>
Further to this problem, I&#39;ve found in the syslog the following:<br>
Can&#39;t init plugin /usr/lib/bluetooth/plugins/libaudio.so<br>
<br>
There&#39;s mention of this problem at <a href="http://article.gmane.org/gmane.linux.bluez.user/13790" target="_blank">http://article.gmane.org/gmane.linux.bluez.user/13790</a><br>
<br>
Is there any solution other than recompiling bluez-utils?<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 6<br>
Date: Tue, 27 May 2008 09:34:10 +0200<br>
From: &quot;Fritz Code&quot; &lt;<a href="mailto:codefritz@googlemail.com">codefritz@googlemail.com</a>&gt;<br>
Subject: [Bluez-users] Bluetooth Keyboard Kernel 2.4<br>
To: <a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a><br>
Message-ID:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;&lt;<a href="mailto:3e9cdced0805270034s3409b6aby382454375651b711@mail.gmail.com">3e9cdced0805270034s3409b6aby382454375651b711@mail.gmail.com</a>&gt;<br>
Content-Type: text/plain; charset=&quot;iso-8859-1&quot;<br>
<br>
Hi,<br>
<br>
I have to connect a bluetooth keyboard, I&#39;m using Kernel <a href="http://2.4.21." target="_blank">2.4.21.</a><br>
The bluetooth subsystem and bluez utils (hcitool, hcid, hciconfig) work so<br>
far.<br>
<br>
Well I have two options now, try this way (which is not related to bluez):<br>
<a href="http://klausler.com/msbtkb-linux.html" target="_blank">http://klausler.com/msbtkb-linux.html</a><br>
<br>
Or try to use bluez.<br>
If I use bluez I have to load hidp.o module, right?<br>
But my kernel 2.4.21 doesn&#39;t provide such a module.<br>
<br>
So I&#39;m not sure what to do in order to get a bluetooth keyboard running in<br>
my Kernel <a href="http://2.4.21." target="_blank">2.4.21.</a><br>
If there are any hints / experiences.<br>
<br>
Note: I&#39;m flexible in the keyboard type and manufactuarer, &nbsp;so if anybody<br>
can recommend a keyboard for the use of Kernel 2.4.21 I would appreciate<br>
that.<br>
<br>
Thanks.<br>
Fritz.<br>
<br>
<br>
--<br>
Regards,<br>
--Codefritz<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
<br>
------------------------------<br>
<br>
Message: 7<br>
Date: Tue, 27 May 2008 09:08:45 -0400<br>
From: &quot;Raymond Ingles&quot; &lt;<a href="mailto:sorceror171@gmail.com">sorceror171@gmail.com</a>&gt;<br>
Subject: Re: [Bluez-users] Syncing a Treo 680<br>
To: &quot;BlueZ users&quot; &lt;<a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a>&gt;<br>
Message-ID:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;&lt;<a href="mailto:a481fbf0805270608y343d265av25ded1e58cf9db25@mail.gmail.com">a481fbf0805270608y343d265av25ded1e58cf9db25@mail.gmail.com</a>&gt;<br>
Content-Type: text/plain; charset=ISO-8859-1<br>
<br>
On Sat, May 24, 2008 at 12:46 AM,<br>
&lt;<a href="mailto:bluez-users.10.judebert@spamgourmet.com">bluez-users.10.judebert@spamgourmet.com</a>&gt; wrote:<br>
&gt; I gave both pages a fair shake. &nbsp;Short story: I&#39;m still willing to<br>
&gt; provide $20 for a walkthrough. &nbsp;Long story: I had the following problems:<br>
<br>
&nbsp;I&#39;m using Ubuntu 7.10. Here&#39;s what I&#39;ve used to get bluetooth<br>
connectivity with my Treo 650:<br>
<br>
&nbsp;1. Edit /etc/default/bluetooth, and set the following variables:<br>
 &nbsp; &nbsp; DUND_ENABLED=1<br>
 &nbsp; &nbsp; DUND_OPTIONS=&quot;--listen --persist --msdun call treo&quot;<br>
 &nbsp; &nbsp; PAND_ENABLED=1<br>
 &nbsp; &nbsp; PAND_OPTIONS=&quot;--listen --role NAP&quot;<br>
 &nbsp; &nbsp; SDPTOOL_OPTIONS=&quot;add --channel=1 SP&quot;<br>
<br>
&nbsp;(Note, that&#39;s not the whole file, it&#39;s just the variables that need to be set.)<br>
<br>
&nbsp;2. If you want to surf the web on the Palm through your computer,<br>
create the file /etc/init.d/btinternet with the following contents:<br>
<br>
 &nbsp; &nbsp;#!/bin/sh<br>
 &nbsp; &nbsp;# enable IP forwarding<br>
 &nbsp; &nbsp;echo 1 &gt; /proc/sys/net/ipv4/ip_forward<br>
 &nbsp; &nbsp;# enable masquerading onto eth0<br>
 &nbsp; &nbsp;iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE<br>
<br>
&nbsp;(Assuming eth0 is your computer&#39;s connection to the internet.)<br>
<br>
&nbsp;3. Create the file /etc/ppp/peers/treo with the following contents:<br>
<br>
 &nbsp; &nbsp;proxyarp<br>
 &nbsp; &nbsp;115200<br>
 &nbsp; &nbsp;172.16.10.1:172.16.10.2<br>
 &nbsp; &nbsp;local<br>
 &nbsp; &nbsp;ms-dns IP.ADDR.OF.DNS.SERVER<br>
 &nbsp; &nbsp;noauth<br>
 &nbsp; &nbsp;debug<br>
 &nbsp; &nbsp;ktune<br>
<br>
&nbsp;Note: the &quot;IP.ADDR.OF.DNS.SERVER&quot; needs to be the ip address of the<br>
DNS server your computer&#39;s using. Use &quot;nslookup <a href="http://www.google.com" target="_blank">www.google.com</a>&quot; and<br>
copy the ip address in the line starting with &quot;Server:&quot;.<br>
<br>
&nbsp;4. Edit /etc/bluetooth/hcid.conf and set the following values:<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;security auto;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;passkey &quot;WHATEVER PASSKEY YOU WANT&quot;;<br>
<br>
&nbsp;Obviously, you set a PIN number there for pairing.<br>
<br>
5. Edit /etc/bluetooth/rfcomm.conf and set the following values:<br>
<br>
 &nbsp; &nbsp; &nbsp; # Automatically bind the device at startup<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bind yes;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;# The Bluetooth address of your Treo (find with hcitool scan<br>
when Treo is discoverable)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;device DE:AD:BE:EF:D0:0D;<br>
 &nbsp; &nbsp; &nbsp; # RFCOMM channel for the connection<br>
 &nbsp; &nbsp; &nbsp; &nbsp;channel 1;<br>
 &nbsp; &nbsp; &nbsp; # Description of the connection<br>
 &nbsp; &nbsp; &nbsp; &nbsp;comment &quot;Palm link&quot;;<br>
<br>
6. Restart bluetooth services (/etc/init.d/bluetooth stop;<br>
/etc/init.d/bluetooth start), run the btinternet script above as root.<br>
<br>
7. Now we&#39;re on the Treo. Pair the Treo with the computer using the<br>
PIN you set above. (Bluetooth app, &quot;Setup Devices&quot;, &quot;Nearby Devices&quot;,<br>
pick your computer, enter the PIN when prompted.)<br>
<br>
8. Go to &quot;Preferences&quot;, choose &quot;Connection&quot;, and name it something<br>
like &quot;BT PAN conn&quot;. &quot;Connect to: Local Network; Via: Bluetooth;<br>
Device: your-machine-name&quot;. Details - Speed: 115,200; Flow Ctl:<br>
Automatic.&quot;<br>
<br>
9. Prefs -&gt; Network. Create a new service, &quot;BT PAN nw&quot;, set the<br>
Connection to the one you just created in step 8. Username: your user<br>
name on the machine, Password: prompt. Details: set the idle timeout<br>
to whatever you like. Choose &quot;Advanced&quot; from &quot;Details&quot;, and set &quot;IP<br>
Address&quot; to &quot;Automatic&quot;, unset &quot;Query DNS&quot;, and put the DNS server you<br>
found above in the &quot;Primary DNS&quot; field.<br>
<br>
&nbsp;At this point, you *should* be able to get a network connection via<br>
PAN, and surf the net through your Palm. Using the normal commands to<br>
do network hotsyncs and things *should* work. If not, we also<br>
configured DUN (PPP over emulated serial) above. In my experience,<br>
it&#39;s been a bit slower/less reliable than PAN, but it also works.<br>
Here&#39;s how to set *that* up:<br>
<br>
10. Go to &quot;Preferences&quot;, choose &quot;Connection&quot;, and name it something<br>
like &quot;BT DUN conn&quot;. &quot;Connect to: PC; Via: Bluetooth; Device:<br>
your-machine-name&quot;. Details - Speed: 115,200; Flow Ctl: Automatic.&quot;<br>
<br>
11. Prefs -&gt; Network. Create a new service, &quot;BT DUN nw&quot;, set the<br>
Connection to the one you just created in step 10. Username: your user<br>
name on the machine, Password: prompt. Details: set the idle timeout<br>
to whatever you like. Choose &quot;Advanced&quot; from &quot;Details&quot;, and set &quot;IP<br>
Address&quot; to &quot;Automatic&quot;, set &quot;Query DNS&quot; to active (checkbox set). No<br>
script is needed.<br>
<br>
&nbsp;This has worked for me on two different machines with two different<br>
Bluetooth dongles, from Ubuntu 6.10 onward. If it works for you,<br>
donate the money to the Free Software Foundation, or the Debian<br>
project.<br>
<br>
<br>
<br>
------------------------------<br>
<br>
-------------------------------------------------------------------------<br>
This SF.net email is sponsored by: Microsoft<br>
Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
<a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
<br>
------------------------------<br>
<br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
<br>
<br>
End of Bluez-users Digest, Vol 25, Issue 21<br>
*******************************************<br>
</blockquote></div><br>

------=_Part_16143_1901539.1211897442584--


--===============0695735021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0695735021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0695735021==--
