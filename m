Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Stanislav Brabec <sbrabec@suse.cz>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 30 Apr 2007 17:16:41 +0200
Message-Id: <1177946201.5443.59.camel@hammer.suse.cz>
Mime-Version: 1.0
Subject: [Bluez-devel] bluez-gnome: No GUI way to switch from "off" mode
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hallo.

I am just curious, whether no chance to enable Bluetooth from the GNOME
Bluetooth is deliberate or not. I guess, that it is not deliberate.

How to reproduce:
1. apitest SetMode off
2. Run bluetooth-properties.
3. Mode selection is completely shaded out and there is no way to enable
   Bluetooth.

Proposed change:
- Convert "Mode of operation" radio buttons to checkboxes.
- "Other devices can connect":
  Will never be shaded out.
  If it is off: Mode is off.
  If it is on, than "Visible and connectable for other devices" is
    unshaded.
- "Visible and connectable for other devices":
  If it is unshaded and off: Mode is connectable
  If it is unshaded and on: Mode is discoverable and "Make adapter
    invisible after" is unshaded.

Is it more acceptable behavior?

Reference:
Bluetooth in GNOME does not work in default installation
https://bugzilla.novell.com/show_bug.cgi?id=3D226137

-- =

Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarsk=E1 1060/12                            tel: +420 284 028 966
190 00 Praha 9                                fax: +420 284 028 951
Czech Republic                                http://www.suse.cz/


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
