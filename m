Return-Path: <shackan@gmail.com>
Message-ID: <9307f5f20606100551p523fc123tcad46e29032c5ecc@mail.gmail.com>
Date: Sat, 10 Jun 2006 14:51:52 +0200
From: "P. Durante" <shackan@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: [D-Bus] api naming convention
Cc: "Marcel Holtmann" <marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,
what about renaming interfaces and object paths to something more
generic, like 'org.bluetooth' and '/org/bluetooth' ?
since the api is supposed to be crossplatform I think it's a good idea
to get rid of any 'bluez' references before people start writing
programs depending on the current api.

regards
