Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Feb 2009 22:09:07 +0900
From: Chan-Yeol Park <chanyeol.park@samsung.com>
Subject: Issues in PANU
In-reply-to: <1235556025.24169.17.camel@localhost.localdomain>
To: 'Marcel Holtmann' <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-id: <002401c99813$685521a0$38ff64e0$%park@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <498EB082.7040708@xyzw.org>
 <1234113019.5355.18.camel@californication> <498F7C4E.4040305@xyzw.org>
 <1234183143.4705.11.camel@californication> <49A2A2D4.2020904@xyzw.org>
 <1235556025.24169.17.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Dear all

I have been working with PANU profile contained in BlueZ 4.30.

Whenever I try to connect NAP,I see the following message,
"
pan1 connected
pan1 disconnected."

As you may know, the first line message is located in bnep_connect_cb(). and
the second message is in bnecp_watchdog_cb().

As I inspect the condition value "GIOCondition cond" in bnep_watchdog_cb(),
there is only "G_IO_ERR", and the others bits are all clean. 
And I try to analyze error packet, but I couldn't do that.

I don't know why this problem happens.

If you're already experienced this, it'll be very thankful to give me a
piece of advice?


And I would like to ask
 "Does BlueZ support both PANU and NAP officially?"
As I see on the BlueZ wiki, it supports only PANU.


Have a nice day!

Regards 
Chanyeol,Park
