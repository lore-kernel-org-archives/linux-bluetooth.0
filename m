Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+uOhx5kPJd8efy+AOsMURN61buitD5v==n7Xfanr9RuNUywxw@mail.gmail.com>
References: <CA+uOhx5kPJd8efy+AOsMURN61buitD5v==n7Xfanr9RuNUywxw@mail.gmail.com>
Date: Thu, 5 Jan 2012 15:14:39 +0100
Message-ID: <CAN_we7OghtjudrzU8zvm22+ExagfCYGmi3aTdPJ2_OT8WWhM8w@mail.gmail.com>
Subject: Re: Device-initiated HID connections: How to pair? (PS Move)
From: Daniele Forsi <dforsi@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2012/1/5 Thomas Perl:

> I'm working on getting the PS Move Controller to work with Linux[1].

> The GUI pairing in GNOME
> 3 doesn't work, no matter what PIN mode (automatic, 0000, do not pair)
> I select.

if the other PS3 controllers work, it should work if there is an entry
for your it in the PIN database in
/usr/share/gnome-bluetooth/pin-code-database.xml
if it is missing then adapt one of the other PS3 entries and please
inform the GNOME Bluetooth developers so it can be added to the next
release (or tell it to me and I will take care of this)

> ii  gnome-bluetooth           3.2.1-1

in version 3.2 the PIN dialog was slightly broken and in some cases
you wouldn't be able to choose the option to not pair; this is fixed
in version 3.3.3, which is the current git HEAD

-- 
Daniele Forsi
