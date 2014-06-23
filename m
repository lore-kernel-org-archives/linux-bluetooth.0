Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v5 0/4] bt_att initial implementation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403123143-17543-1-git-send-email-armansito@chromium.org>
Date: Mon, 23 Jun 2014 10:38:20 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4DFB3E01-48C3-4F80-8040-6165B4456ABE@holtmann.org>
References: <1403123143-17543-1-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> v5:
>  - Removed the PDU signing related functions for now. We"ll revisit them once
>  we start implementing/testing the signed write command.
>  - Minor cosmetic changes.

forget my previous comment, I mixed up v4 with v5 :(

> Arman Uguray (4):
>  src/shared/att: Introduce struct bt_att.
>  src/shared/att: Implement basic boilerplate.
>  src/shared/att: Implement write handler and bt_att_send.
>  src/shared/att: Handle incoming response PDUs

A prefix of shared: or shared/att: is enough. The src/ part is too much.

> 
> Makefile.am            |   3 +-
> src/shared/att-types.h | 222 +++++++++++++
> src/shared/att.c       | 840 +++++++++++++++++++++++++++++++++++++++++++++++++
> src/shared/att.h       |  69 ++++
> 4 files changed, 1133 insertions(+), 1 deletion(-)
> create mode 100644 src/shared/att-types.h
> create mode 100644 src/shared/att.c
> create mode 100644 src/shared/att.h

However, you really need to use a proper compiler that gives you a decent amount of warnings.

  CC       src/shared/bluetoothd-att.o
src/shared/att.c: In function ‘encode_pdu’:
src/shared/att.c:194:2: error: label ‘dafault’ defined but not used [-Werror=unused-label]
  dafault:
  ^
src/shared/att.c: In function ‘handle_error_rsp’:
src/shared/att.c:447:8: error: unused variable ‘result’ [-Werror=unused-variable]
  bool result;
        ^
src/shared/att.c: In function ‘handle_mtu_rsp’:
src/shared/att.c:464:8: error: unused variable ‘result’ [-Werror=unused-variable]
  bool result;
        ^
src/shared/att.c: In function ‘bt_att_set_mtu’:
src/shared/att.c:689:11: error: pointer targets in assignment differ in signedness [-Werror=pointer-sign]
  att->buf = buf;
           ^

I fixed them all up for you since they were dead simple fixes, but please be a bit more careful for the next set of patches.

Regards

Marcel

