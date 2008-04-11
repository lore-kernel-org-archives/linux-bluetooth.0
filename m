Return-Path: <cyrus@holtmann.org>
Message-ID: <194c6ea30804110133x276fd249p245cb6cbfd699f48@mail.gmail.com>
Date: Fri, 11 Apr 2008 16:33:06 +0800
From: "dong yan" <semiydsemiyd@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] bluez3.30 audio/serial plugin issue
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

Hi All:

    i just upgraded my bluez from 3.26 to 3.30...It's said that all
audio/serial...services are moved into plugin libraries...
    It seems i got a problem while loading these new plugins,here's the log:

hcid[173]: Bluetooth HCI daemon
hcid[173]: Enabling debug information
hcid[173]: HCI dev 0 registered
hcid[173]: Starting SDP server
hcid[173]: Adding rec : 0x4d8c0
hcid[173]: with handle : 0x1
hcid[173]: Adding rec : 0x4d980
hcid[173]: with handle : 0x0
hcid[173]: Service classes 0x00
hcid[173]: Creation of inotify context failed

hcid[173]: Loading plugins /bluetooth//lib/bluetooth/plugins
hcid[173]: Can't load plugin:
/bluetooth//lib/bluetooth/plugins/libaudio.so: invalid mode for
dlopen(): Invalid argument
hcid[173]: Can't load plugin:
/bluetooth//lib/bluetooth/plugins/libnetwork.so: invalid mode for
dlopen(): Invalid argument
hcid[173]: Can't load plugin:
/bluetooth//lib/bluetooth/plugins/libinput.so: invalid mode for
dlopen(): Invalid argument
hcid[173]: Can't load plugin:
/bluetooth//lib/bluetooth/plugins/libserial.so: invalid mode for
dlopen(): Invalid argument

hcid[173]: Registering service object: ident=serial, name=Serial
service (/org/bluez/service_serial)
hcid[173]: Registering service object: ident=audio, name=Audio service
(/org/bluez/service_audio)
hcid[173]: Registering service object: ident=input, name=Input service
(/org/bluez/service_input)
hcid[173]: Registering service object: ident=echo, name=Echo service
(/org/bluez/service_echo)
hcid[173]: Registering service object: ident=network, name=Network
service (/org/bluez/service_network)
hcid[173]: HCI dev 0 up
hcid[173]: Device hci0 has been added
hcid[173]: Starting security manager 0
hcid[173]: Device hci0 has been activated
hcid[173]: child 179 exited
hcid[173]: /org/bluez: org.bluez.Security.RegisterDefaultPasskeyAgent()
hcid[173]: name_listener_add(:1.1)
hcid[173]: Default passkey agent (:1.1, /org/bluez/passkey_agent_178) registered
hcid[173]: child 191 exited




Anybody help me pls?



Thanks in advance

semiyd

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
