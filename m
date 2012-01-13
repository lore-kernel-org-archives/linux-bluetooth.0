Return-Path: <cyrus@holtmann.org>
Message-ID: <1326460244.2112.48.camel@novo.hadess.net>
Subject: 4.98 fails to build with newer gcc
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 13 Jan 2012 13:10:44 +0000
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A few warnings:

sbc/sbc.c:766:34: warning: always_inline function might not be inlinable [-Wattributes]
sbc/sbc.c:558:34: warning: always_inline function might not be inlinable [-Wattributes]
sbc/sbc.c:163:31: warning: always_inline function might not be inlinable [-Wattributes]

and an error

sbc/sbc_primitives_mmx.c: In function 'sbc_calc_scalefactors_mmx':
sbc/sbc_primitives_mmx.c:294:4: warning: asm operand 2 probably doesn't match constraints [enabled by default]
sbc/sbc_primitives_mmx.c:294:4: error: impossible constraint in 'asm'

Full build log:
http://koji.fedoraproject.org/koji/getfile?taskID=3657376&name=build.log
Using gcc 4.7.0 as mentioned in root log:
http://koji.fedoraproject.org/koji/getfile?taskID=3657376&name=root.log

The same build works correctly with gcc 4.6.1 on Fedora 16.

Any ideas?

