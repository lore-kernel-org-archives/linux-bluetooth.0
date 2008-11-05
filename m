Return-Path: <cyrus@holtmann.org>
Message-ID: <b11bec220811050837i4a4a095cqd9c2d27d5bbe3022@mail.gmail.com>
Date: Wed, 5 Nov 2008 10:37:26 -0600
From: "Daniel Roesler" <diafygi@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Default PIN for bluez-gnome wizard
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Howdy all,

I was wondering if there was a reason for using random numbers between
1000 and 9999 as the fallback pincode to try when attempting to
connect to a bluetooth device via the wizard?

http://git.kernel.org/?p=bluetooth/bluez-gnome.git;a=blob_plain;f=wizard/main.c;hb=HEAD
------LINE 548-------
target_pincode = g_strdup_printf("%d", g_random_int_range(1000, 9999));
--------------------------

Many devices use "0000" as their default, and I've noticed that "0000"
is continually being added to the pincode_callback function for
special devices. Why not set "0000" as the default to catch most of
the devices that aren't able to customize their own pins?

Avast!
Daniel Roesler
diafygi@gmail.com
