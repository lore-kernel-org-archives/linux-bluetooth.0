Return-Path: <aklish1@urbana.css.mot.com>
Date: Mon, 13 Sep 2004 18:58:28 -0500 (CDT)
From: Aaron Klish <aklish1@urbana.css.mot.com>
To: Marcel Holtmann <marcel@holtmann.org>
cc: bluez-devel@lists.sourceforge.net
Subject: freeing skbuff in l2cap_chan_send
In-Reply-To: <1094213861.6052.12.camel@notepaq>
Message-ID: <Pine.LNX.4.44.0409131849250.8777-100000@lemur.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

In l2cap_chan_send (l2cap.c), it appears as though the 
initial skbuff allocated to store data
passed in the msg parameter is not freed
if the buffer must be fragmented to send
to HCI.

The skbuff and its associated fragment list
is passed to hci by calling hci_send_acl.

This in turn places all the individual fragments
on a tx queue.  

The individual fragment skbuffs are freed when they are written
to the tty device (I am looking at the case where HCI uart is used).

However, the original l2cap skbuff allocated to store the
entire l2cap frame never appears to be freed.

I am looking at mh17 on a 2.4.20 kernel.

Is this a bug or am I missing something here?

Thanks.

Aaron

-- 
------------
Aaron Klish
Bluetooth Software Engineer
Motorola PCS
PH# (217) 384-8598
FX# (217) 384-8550

[X]  Motorola General Business Information
[ ]  Motorola Internal Use Only
[ ]  Motorola Confidential Proprietary
