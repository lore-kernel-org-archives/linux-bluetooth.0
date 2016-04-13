Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: ./test/example-* mixed python versions?
Message-Id: <B5DD93FB-7B6D-4D84-8F50-414D291E0F24@gmail.com>
Date: Wed, 13 Apr 2016 09:13:07 -0700
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Playing with the latest 5.39, I just noticed that test/example-advertisement runs /usr/bin/python (e.g. python2), but example-gatt-server runs as /usr/bin/env python3.

That’s not be design is it? Seems like it would be better to be in one boat or the other (python3 is my personal preference). example-gatt-client is python3 as well, while all of the other py files in the test directory appear to be python2.