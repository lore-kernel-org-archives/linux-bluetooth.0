Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'Max Krasnyansky'" <maxk@qualcomm.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Tue, 13 May 2003 06:30:58 -0700
Message-ID: <000b01c31953$e3a50a90$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1052584255.1133.13.camel@pegasus.local>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

How do I get those 5 patches from the bt-2.4 repository? Or better yet:
Where is the bt-2.4 repository?

> Daryl, so it is now up to you to do your tests with Cetecom 
> again and see what we pass and what we fail. The RFCOMM layer 
> should now perform perfect, but the L2CAP config stuff will 
> still fail. You can use 2.4.18-mh4 and apply these 5 patches 
> from the bt-2.4 repository to it:
> 
> ChangeSet@1.1162, 2003-05-09 21:11:49-07:00
>   [Bluetooth] RFCOMM must wait for MSC exchange to complete 
> before sending the data.
> 
> ChangeSet@1.1161, 2003-05-09 16:41:45-07:00
>   [Bluetooth] Detect and log error condition when first L2CAP 
> fragment is too long.
> 
> ChangeSet@1.1160, 2003-05-09 11:55:22-07:00
>   [Bluetooth] L2CAP config req/rsp handling fixes. 
> 
> ChangeSet@1.1126.3.2, 2003-05-09 03:22:06+02:00
>   [Bluetooth] Handle priority bits in parameter negotiation
> 
> ChangeSet@1.1126.3.1, 2003-05-09 02:07:07+02:00
>   [Bluetooth] Send the correct values in RPN response
> 
> Max, please go ahead and forward them to Marcelo and Linus. 
> If you have some extra time, please update my repositories 
> with the new stuff.
> 
> I will make some new -mh patches on monday or tuesday.

-Daryl.
