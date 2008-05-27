Return-Path: <cyrus@holtmann.org>
Message-ID: <a481fbf0805270608y343d265av25ded1e58cf9db25@mail.gmail.com>
Date: Tue, 27 May 2008 09:08:45 -0400
From: "Raymond Ingles" <sorceror171@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <48379DBC.50504@judebert.com>
MIME-Version: 1.0
References: <48336FD4.9040803@judebert.com>
	<F60A3CE9E807BE49B5F56BD80B894D20016883DF@sc-exch03.marvell.com>
	<48379DBC.50504@judebert.com>
Subject: Re: [Bluez-users] Syncing a Treo 680
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Sat, May 24, 2008 at 12:46 AM,
<bluez-users.10.judebert@spamgourmet.com> wrote:
> I gave both pages a fair shake.  Short story: I'm still willing to
> provide $20 for a walkthrough.  Long story: I had the following problems:

 I'm using Ubuntu 7.10. Here's what I've used to get bluetooth
connectivity with my Treo 650:

 1. Edit /etc/default/bluetooth, and set the following variables:
     DUND_ENABLED=1
     DUND_OPTIONS="--listen --persist --msdun call treo"
     PAND_ENABLED=1
     PAND_OPTIONS="--listen --role NAP"
     SDPTOOL_OPTIONS="add --channel=1 SP"

 (Note, that's not the whole file, it's just the variables that need to be set.)

 2. If you want to surf the web on the Palm through your computer,
create the file /etc/init.d/btinternet with the following contents:

    #!/bin/sh
    # enable IP forwarding
    echo 1 > /proc/sys/net/ipv4/ip_forward
    # enable masquerading onto eth0
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

 (Assuming eth0 is your computer's connection to the internet.)

 3. Create the file /etc/ppp/peers/treo with the following contents:

    proxyarp
    115200
    172.16.10.1:172.16.10.2
    local
    ms-dns IP.ADDR.OF.DNS.SERVER
    noauth
    debug
    ktune

 Note: the "IP.ADDR.OF.DNS.SERVER" needs to be the ip address of the
DNS server your computer's using. Use "nslookup www.google.com" and
copy the ip address in the line starting with "Server:".

 4. Edit /etc/bluetooth/hcid.conf and set the following values:

        security auto;
        passkey "WHATEVER PASSKEY YOU WANT";

 Obviously, you set a PIN number there for pairing.

5. Edit /etc/bluetooth/rfcomm.conf and set the following values:

       # Automatically bind the device at startup
        bind yes;
        # The Bluetooth address of your Treo (find with hcitool scan
when Treo is discoverable)
        device DE:AD:BE:EF:D0:0D;
       # RFCOMM channel for the connection
        channel 1;
       # Description of the connection
        comment "Palm link";

6. Restart bluetooth services (/etc/init.d/bluetooth stop;
/etc/init.d/bluetooth start), run the btinternet script above as root.

7. Now we're on the Treo. Pair the Treo with the computer using the
PIN you set above. (Bluetooth app, "Setup Devices", "Nearby Devices",
pick your computer, enter the PIN when prompted.)

8. Go to "Preferences", choose "Connection", and name it something
like "BT PAN conn". "Connect to: Local Network; Via: Bluetooth;
Device: your-machine-name". Details - Speed: 115,200; Flow Ctl:
Automatic."

9. Prefs -> Network. Create a new service, "BT PAN nw", set the
Connection to the one you just created in step 8. Username: your user
name on the machine, Password: prompt. Details: set the idle timeout
to whatever you like. Choose "Advanced" from "Details", and set "IP
Address" to "Automatic", unset "Query DNS", and put the DNS server you
found above in the "Primary DNS" field.

 At this point, you *should* be able to get a network connection via
PAN, and surf the net through your Palm. Using the normal commands to
do network hotsyncs and things *should* work. If not, we also
configured DUN (PPP over emulated serial) above. In my experience,
it's been a bit slower/less reliable than PAN, but it also works.
Here's how to set *that* up:

10. Go to "Preferences", choose "Connection", and name it something
like "BT DUN conn". "Connect to: PC; Via: Bluetooth; Device:
your-machine-name". Details - Speed: 115,200; Flow Ctl: Automatic."

11. Prefs -> Network. Create a new service, "BT DUN nw", set the
Connection to the one you just created in step 10. Username: your user
name on the machine, Password: prompt. Details: set the idle timeout
to whatever you like. Choose "Advanced" from "Details", and set "IP
Address" to "Automatic", set "Query DNS" to active (checkbox set). No
script is needed.

 This has worked for me on two different machines with two different
Bluetooth dongles, from Ubuntu 6.10 onward. If it works for you,
donate the money to the Free Software Foundation, or the Debian
project.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
