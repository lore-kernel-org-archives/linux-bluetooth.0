Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 13 Dec 2010 12:10:12 +0100
Message-ID: <AANLkTin4xG5KUEpn6QaZA0V6y3cDvxpWhwRJhMrE_8QO@mail.gmail.com>
Subject: How to implement multiple instances of obexd service?
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to fully implement Message Access Profile, support for more
than one so-called instance is needed (MAP specification, chapter
3.1.8). According to specs, separate e-mail accounts on MSE should be
represented by separate MAS instances. This requires one SDP record
per instance and those differ by MASInstanceID and ServiceName.

As I understand this also implies that each and every instance needs
its own separate RFCOMM channel?

What would be the preffered way to deal with this ugliness in obexd
code? If separate channels are needed how to keep this in compliance
with bluez doc/assigned-numbers.txt? And what about assigned bitmask values for
services in src/obex.h?

-- 
Slawomir Bochenski
