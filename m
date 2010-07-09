Return-Path: <cyrus@holtmann.org>
From: <ext-jablonski.radoslaw@nokia.com>
To: <linux-bluetooth@vger.kernel.org>
Date: Fri, 9 Jul 2010 10:30:09 +0200
Subject: [PATCH] Fixed empty 'N:' parameter handling for VCARDs
Message-ID: <090FE800A758CA439B2752C082AC3DEF0378CDB08F@NOK-EUMSG-06.mgdnok.nokia.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!
I've created patch problems with history listing with BH-903.. 
After fix everything works as described in PBAP spec and problem no longer occurs.
	
Patch is available on my gitorius master branch clone for obexd-packaging: 
git://gitorious.org/~jradosla/maemo-bluetooth/jradoslas-obexd-packaging.git 
It is located in:  debian/patches/006-Fixed-empty-N-parameter-handling-for-VCARDs.patch

BR,
Radek
