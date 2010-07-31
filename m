Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 31 Jul 2010 14:27:23 +0300
Message-ID: <AANLkTim-Pa9PYtEsgL+2_=fYbvei57S6+EHQroRt6XfS@mail.gmail.com>
Subject: 3 concurrent SCO connection
From: Ahmed Ragab <elmasri.ahmed@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

As per the the Bluetooth documentation on the sig group each Bluetooth dongle
Is allowed to make up to 3 sco connections. in order to do that we have to
Bind the same dongle (since we have multiple dongles ) to an rfcomm
connection 3 times which is not possible
Since it will give address already in use error. so how can i make the
same dongle make 3 rfcomm connections
And 3 sco connection or is there a limitation on the number of rfcomm
connections if we want to make 3 sco
Connection.

Regards

elmasri
