Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'Max Krasnyansky'" <maxk@qualcomm.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Sat, 10 May 2003 20:57:27 -0700
Message-ID: <000201c31771$70577930$6400a8c0@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1052565910.1288.187.camel@pegasus.local>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

> Daryl, can you please check with Cetecom what is really 
> needed to pass this test. From my understanding we do all 
> right, because we notifier the application (ok, in this case 
> the complete Linux system) with an error message in the syslog.
> 
> How must the testing application react on these errors. Is it 
> enough to put an error on the screen, or must it close the 
> L2CAP connection. I think we should write a test application 
> which reads the syslog and deals with the L2CAP error 
> messages in some way.

I think it is enough to put an error message on the screen. If necessary we
could make the application look at syslog - which would definitely
demonstrate the ability for the stack to notify the app.

I'll verify this on Monday.

-Daryl.
