Return-Path: <cyrus@holtmann.org>
Message-ID: <e91dafd20810080800o30fe2fb0v7a537715e14c44fa@mail.gmail.com>
Date: Wed, 8 Oct 2008 17:00:02 +0200
From: mcINEK <mcinek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [ BUG ] acl sysfs entry remains after connection error
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

I've found a bug in bluetooth stack.

I use bluetooth on ARM Linux machine to simultaneously send pictures
to 2 or 3 devices.
In a L2CAP connection stage (socket L2CAP 'connect') sometimes I get a
'Connection timeout error',
which is not a disaster because I can try to connect again. However
very often I get a kernel error,
which tells me that there is a duplicate entry in sysfs (acl...).

I've checked, and indeed acl connection entries are not removed from
sysfs after a connection fail.

How can I fix this?

PS. I've got latest 2.6.26 kernel.

Regards,
Marcin Undak
