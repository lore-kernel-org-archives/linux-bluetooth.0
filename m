Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 6 Apr 2011 12:04:49 +0200
Message-ID: <BANLkTikdXHstUxQ52RM6OMSnqfLWYJVMvg@mail.gmail.com>
Subject: Re: [PATCH 3/3] Support hardcoded Nintendo Wii Remote pins
From: Daniele Forsi <dforsi@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

David Herrmann wrote:

> The Nintendo Wii Remote requires the destination bluetooth address
> as pincode.

according to my my tests they require the source address, ie the host
adapter's address

> +		/* Nintendo Wii Remote uses destination address as PIN */

better to document in that comment if it works when pressing the red
button or the 1+2 buttons

I tested your 3 patches against bluez git 4.91-32-gd7f412e and
gnome-bluetooth 2.32 but they didn't work for me for 2 reasons:
1) can't get vid/pid so when the remote is unknown the
read_device_id() call in your code fails to get vid/pid and the
specific pin is never tried; the same happens after a failed pairing
when the /var/lib/bluetooth/*/did file contains a line this:
00:1F:C5:25:36:87 FFFF 0000 0000 0000
2) the source vs destination address I mentioned above

It works for me if I manually edit that line with the values read from
another wiimote's line:
00:1F:C5:25:36:87 0002 057E 0306 0600
and if I change dba to sba here
>			memcpy(pinbuf, dba, 6);

how can I help you to debug these issues?

BTW pairing also works when I use the test code mentioned in
https://bugzilla.gnome.org/show_bug.cgi?id=603845#c6
-- 
Daniele Forsi
