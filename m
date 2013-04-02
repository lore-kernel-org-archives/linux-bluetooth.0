Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Apr 2013 21:55:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Duffy <brduffy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluez 5 dbus api ??
Message-ID: <20130402185518.GA28885@x220.P-661HNU-F1>
References: <CAHrDPkoGi5EoCavs6dG0o+qTqMxBhD503+BGoke+Tth6hQJphg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHrDPkoGi5EoCavs6dG0o+qTqMxBhD503+BGoke+Tth6hQJphg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Tue, Apr 02, 2013, Brian Duffy wrote:
> I'm new to dbus programming.

For generic D-Bus help you're probably better off looking at non-BlueZ
related D-Bus tutorials and documentation (use e.g. google to find
those).

> Where is the best place to get documentation/examples for bluez dbus
> programming?

The API reference can be found in doc/*-api.txt.

There are python based test scripts using the API in test/* and a
C-based text mode client under client/*

If you've done any BlueZ 4 work previously there's also a porting guide
here: http://www.bluez.org/bluez-5-api-introduction-and-porting-guide/

Johan
