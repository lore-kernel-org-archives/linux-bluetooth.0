Return-Path: <cyrus@holtmann.org>
Message-ID: <003a01c8d0f3$733ce4a0$6e01a8c0@Raymondpc>
From: "skyflame" <skyflame@21cn.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <44771.82692.qm@web57911.mail.re3.yahoo.com>
	<084501c8d0dc$9e41e400$0132a8c0@Raymondpc>
Date: Wed, 18 Jun 2008 11:28:59 +0800
MIME-Version: 1.0
Subject: [Bluez-devel] When Compiling Bluez-utilits ,
	--enable-all don't including everything ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi
    I am try to build the audio related bin in bluez-utilits.
    And I  am use ./configure --enable-all  , I found even if i build and 
install all the package it depends on, the audio dir still do not get build.

    Then I check the configure script, and found that only if you 
using --enable-audio , then the audio with get built.

    Is that designed to do so ?

Raymond 


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
