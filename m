Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <12a241ad05052907591c593c6@mail.gmail.com>
From: Bruno Abinader <brunoabinader@gmail.com>
To: Bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] bluez-utils-2.17 -- Error compiling dbus.o
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
Date: Sun, 29 May 2005 10:59:13 -0400

Hi everybody, i recently updated my dbus package and now i'm having
some problems trying to compile hcid/dbus.o file, the error is the
follow:

gcc -I/usr/include -DDBUS_API_SUBJECT_TO_CHANGE
-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -DENABLE_DBUS
-DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -o hcid main.o security.o
storage.o lib.o parser.o lexer.o kword.o glib-ectomy.o dbus.o=20
-L/usr/lib /usr/lib/libdbus-1.so /usr/lib/libbluetooth.so
dbus.o(.text+0x7a): In function `hcid_dbus_request_pin':
: undefined reference to `dbus_message_append_iter_init'
dbus.o(.text+0x8b): In function `hcid_dbus_request_pin':
: undefined reference to `dbus_message_iter_append_boolean'
dbus.o(.text+0x97): In function `hcid_dbus_request_pin':
: undefined reference to `dbus_message_iter_append_byte_array'
dbus.o(.text+0x381): In function `reply_handler_function':
: undefined reference to `dbus_pending_call_get_reply'
dbus.o(.text+0x3dd): In function `reply_handler_function':
: undefined reference to `dbus_message_iter_get_string'
collect2: ld returned 1 exit status
make[2]: ** [hcid] Erro 1
make[2]: Saindo do diret=F3rio `/home/bruno/src/bluez-utils-2.17/hcid'
make[1]: ** [all-recursive] Erro 1
make[1]: Saindo do diret=F3rio `/home/bruno/src/bluez-utils-2.17'
make: ** [all] Erro 2

Any help would be appreciated!

Thanks in advance,

--=20
Bruno de Oliveira Abinader
GVoIP - INdT/UFAM


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
