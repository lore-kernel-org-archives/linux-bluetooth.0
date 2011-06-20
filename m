Return-Path: <cyrus@holtmann.org>
Subject: Build failure for bluez-hcidump
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Mon, 20 Jun 2011 09:56:11 +0100
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1308560171.6042.3.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

bluez-hcidump 2.1 fails to build on Fedora 16:

src/hcidump.c: In function 'process_frames':
src/hcidump.c:313:5: warning: implicit declaration of function 'hton64' [-Wimplicit-function-declaration]
src/hcidump.c: In function 'read_dump':
src/hcidump.c:430:4: warning: implicit declaration of function 'ntoh64' [-Wimplicit-function-declaration]
  CCLD   src/hcidump
src/hcidump.o: In function `process_frames':
/builddir/build/BUILD/bluez-hcidump-2.1/src/hcidump.c:313: undefined reference to `hton64'
src/hcidump.o: In function `read_dump':
/builddir/build/BUILD/bluez-hcidump-2.1/src/hcidump.c:436: undefined reference to `ntoh64'
/builddir/build/BUILD/bluez-hcidump-2.1/src/hcidump.c:430: undefined reference to `ntoh64'

Both i686 and x86-64 fails to build with the same error.

http://koji.fedoraproject.org/koji/getfile?taskID=3143039&name=build.log
shows the full build log.

