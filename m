Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 26 Jul 2009 18:33:42 +0100
Message-ID: <4d6ba3de0907261033l42a53199nbaf0d8220657561e@mail.gmail.com>
Subject: [patch] Fix pairing of PS3 BD Remote
From: Michael Thompson <michaelnt@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
    The following patch to bluez-gnome allows the PS3 BD remote to be
paired using the wizard. Once paired the remote can then be used as a
normal input device.

Essentially this device wasn't identified correctly as a remote. Once
identified it should be treated in the same was as a Mouse. I modified
the code to treat a mouse, keyboard or remote in the same way.

Regads, Michael

--- bluez-gnome-1.8.orig/wizard/main.c
+++ bluez-gnome-1.8/wizard/main.c
@@ -149,8 +149,7 @@
                if (page > 0)
                        gtk_assistant_set_current_page(assistant, page + 1);

-               if (target_type == BLUETOOTH_TYPE_KEYBOARD ||
-                                       target_type == BLUETOOTH_TYPE_MOUSE) {
+               if ((target_type & BLUETOOTH_TYPE_INPUT) > 0){
                        bluetooth_client_set_trusted(client, path, TRUE);
                        bluetooth_client_connect_input(client, path,
                                                connect_callback, assistant);
@@ -205,7 +204,7 @@

                g_object_ref(agent);

-               if (target_type == BLUETOOTH_TYPE_MOUSE)
+               if ((target_type & BLUETOOTH_TYPE_INPUT) > 0)
                        path = NULL;

                bluetooth_client_create_device(client, target_address,

--- bluez-gnome-1.8.orig/common/bluetooth-client.c
+++ bluez-gnome-1.8/common/bluetooth-client.c
@@ -104,6 +104,8 @@
                return N_("Joypad");
        case BLUETOOTH_TYPE_TABLET:
                return N_("Tablet");
+       case BLUETOOTH_TYPE_REMOTE:
+               return N_("Remote");
        default:
                return N_("Unknown");
        }
@@ -143,6 +145,8 @@
                        case 0x01:
                        case 0x02:
                                return BLUETOOTH_TYPE_JOYPAD;
+                       case 0x03:
+                               return BLUETOOTH_TYPE_REMOTE;
                        }
                        break;
                case 0x01:
