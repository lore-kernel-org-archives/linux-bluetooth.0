Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: =?UTF-8?B?S2VuZy1Zw7wgTGlu?= <kengyu@ubuntu.com>
Date: Tue, 27 Sep 2011 16:25:49 +0800
Message-ID: <CADXHx7Z=9EFEweZ+LouXWdRePu6OBrj36uGA78=BMKjo0oMEJQ@mail.gmail.com>
Subject: Bug: bluetooth not working after suspend/resume
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016e6d59e52424ca804ade808d2
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e6d59e52424ca804ade808d2
Content-Type: text/plain; charset=UTF-8

Hi all:
  Since kernel.org/bugzilla is dead for a while, I sent the bug report
here in hope to get more insight.

  This is a long-lasting bug and happens across several distros with
different combinations of bluez/kernel verisions but shares much the
same symptom that bluetooth is not working after the resume. As seen
in the bug report below, it happens on a variety of different laptops
too.

  Redhat:
    https://bugzilla.redhat.com/show_bug.cgi?id=727106

  Debian:
    http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=614929

  Ubuntu:
    https://launchpad.net/bugs/824144
    https://launchpad.net/bugs/824633
    https://launchpad.net/bugs/823467
    https://launchpad.net/bugs/822705

  Personally I did some investigation on the issue and found that
bluetoothd does not receive the HCI commands of read_bd_addr,
read_local_version, read_local_features, nor read_local_name. So in
bluez.plugins/hciops.c:device_devup_setup(), init_adapter() is not
called at resume.

  It can be further confirmed by the attached patch of bluez. It is
ugly but can work around the bug as reported in some of the bug
trackers above.

  I am looking for any advice to get it move on,  for the debugging
and the fixing.

  Thanks,
-kengyu

--0016e6d59e52424ca804ade808d2
Content-Type: text/x-patch; charset=US-ASCII; name="06-Fix-disabled-after-resume.patch"
Content-Disposition: attachment;
	filename="06-Fix-disabled-after-resume.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gt2ld27g0

LS0tIGEvcGx1Z2lucy9oY2lvcHMuYworKysgYi9wbHVnaW5zL2hjaW9wcy5jCkBAIC0yNTEyLDgg
KzI1MTIsOCBAQAogCWhjaV9zZW5kX2NtZChkZXYtPnNrLCBPR0ZfSE9TVF9DVEwsIE9DRl9SRUFE
X1NUT1JFRF9MSU5LX0tFWSwKIAkJCQkJUkVBRF9TVE9SRURfTElOS19LRVlfQ1BfU0laRSwgJmNw
KTsKIAotCWlmICghZGV2LT5wZW5kaW5nKQotCQlpbml0X2FkYXB0ZXIoaW5kZXgpOworCURCRygi
ZGV2LT5wZW5kaW5nPSVkIiwgZGV2LT5wZW5kaW5nKTsKKwlpbml0X2FkYXB0ZXIoaW5kZXgpOwog
fQogCiBzdGF0aWMgdm9pZCBpbml0X3BlbmRpbmcoaW50IGluZGV4KQo=
--0016e6d59e52424ca804ade808d2--
