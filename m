Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 9 Jun 2011 16:09:27 +0200
Message-ID: <BANLkTimO9hqs-_4gyiY3YBOutBd8yhsuXQ@mail.gmail.com>
Subject: Health Thermomether Profile
From: Santiago Carot <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I was thinking in to get my hands on this stuff. First of all, I would
like to know if there are people working in this profile to join and
callaborate with them in the development tasks (if it would be
possible), if not, I would like to start with the development of this
profile as soon as we agree a proper desgin, API and so with all of
you.

Next I'm going to explain some light ideas that round my head:

At first I was thinking to attack the attribute D-Bus API due that
health thermomether profile is placed over GATT, but I don't see how
it fits into BlueZ architecture because it will force us to use the
attribute D-Bus API to provide another Thermomether API through D-Bus.
It seems me quite ugly.

On the other hand, lastest Anderson's e-mails about GATT make me think
other designs avoiding attribute D-Bus API by using GATT direclty to
implement the Thermomether client profile. In this way we can make a
bluetooth plugin wich exposes the client part through D-Bus API to
manage Thermomether devices by hiding GATT profile to applications
that only want to operate over this kind of devices. I think that it's
a pretty design wich fits better in BlueZ.

These are only rough ideas so I really appreciate comments and
suggestion from your side before starting.

Regards.
