Return-Path: <cyrus@holtmann.org>
Message-id: <B81BBF97380548409643B2DD0175BDED@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
References: <CAB7rCTg4YLsE7uNbR8mRH_cubtMmBnTZUnJ3U4vL_AsyjA7xzA@mail.gmail.com>
 <20120319230436.GA27304@x220> <20120320173546.GA6307@samus>
 <20120321124517.GB8888@x220>
In-reply-to: <20120321124517.GB8888@x220>
Subject: Query on attribute api service object path
Date: Wed, 21 Mar 2012 18:41:34 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have a doubt in attribute-api.txt.
In Device service hierarchy object path is 
"[prefix]/{hci0}/{device0}/{service0, service1, ...}.
which is device path + service"x".
When I checked the code "x" is "prim->start" which is service start handle.
But how user will get this handle to create object path?
Only uuids are passed to user in UUIDs signal afaik.

Thanks
Jaganath 

