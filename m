Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200407101216.11706.cijoml@volny.cz>
Subject: [Bluez-users] bluetooth.init enhance
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 10 Jul 2004 12:16:11 +0200

Hi Marcel,

maybe you should tweak this script little bit:

add this into HIDD start section to allow others to use hidd and bthid at the 
same time, if they have bthid from CVS (I know you want remove it at all, but 
now in 2.4 we don't have any other way to use hid devices)

                case `uname -r` in
                        1.*)
                                echo "This kernel does not support BlueZ"
                                exit 255
                        ;;

                        2.[01235].*)
                                echo "This kernel does not support BlueZ"
                                exit 255
                        ;;
                        2.4.*)
                                if [ -x /opt/bluetooth/sbin/bthid ] ; then
                                /opt/bluetooth/sbin/bthid -d
                                echo -n " hidd"
                                fi
                        ;;
                        2.[6].*)
                                if [ -x "$HIDD" ] ; then
                                "$HIDD" --server
                                echo -n " hidd"
                                fi
                        ;;
                        *)
                                # Huh?
                                echo "Unrecognized kernel version"
                                exit 255
                        ;;
                esac

Michal


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
