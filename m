Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030516103557.0d59b470@unixmail.qualcomm.com>
Date: Fri, 16 May 2003 10:38:35 -0700
To: "Daryl Van Vorst" <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000201c31bb9$78b1be00$1a01010a@baked>
References: <5.1.0.14.2.20030515174022.0d4950a0@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 07:43 AM 5/16/2003, Daryl Van Vorst wrote:
>> How about support for L2CAP_LM_RELAIBLE ?
>> The error returned by recvmsg()/sendmsg()/read()/etc is ECOMM.
>
>Wasn't sure if you wanted me to do that stuff.
>Sure, I can take a swing at it.

btw We want to get all your changes that are useful for qualification.
I'm talking about changes to l2test/rctest/etc that you had to make to support 
particular tests.

Max
