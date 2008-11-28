Return-Path: <cyrus@holtmann.org>
Message-ID: <492FC4A3.4020601@koala.ie>
Date: Fri, 28 Nov 2008 10:14:59 +0000
From: Simon Kenyon <simon@koala.ie>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Sony BD Remote (the saga continues)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

so i decided to start working my way through the code and found references to uinput in input/device.c
this gave me another keyword to use in google and lo and behold this popped up:

Fri Oct 17 2008 - Bastien Nocera <bnocera@redhat.com <mailto:bnocera@redhat.com>> - 4.14-2
- Add script to autoload uinput on startup, so the PS3 remote
  works out-of-the-box


sure enough i did not have this module in my kernel.
just building now in hope that this might be the issue

not being a fedora user i never thought to look there to see if there was documentation ;-(
--
simon

