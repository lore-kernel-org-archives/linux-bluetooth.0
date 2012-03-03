Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 3 Mar 2012 18:15:51 +0100
Message-ID: <CAOcK=CNO-rLWCrNEyz+qU0YN-ZGX6KydUTN4djAc-dsP17QtGg@mail.gmail.com>
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
From: Markus Rathgeb <maggu2810@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!

The patch "http://www.spinics.net/lists/linux-bluetooth/msg20220.html"
is using the typeof keyword.
I also found the statement:
"I was uncomfortable to depend on "typeof" for that initially, but the
macro already uses that for the struct member."

IMHO typeof is not part of the C++ standard, and isn't available when
we use -std=c++0x.
g++ should support __typeof__ even with -std=c++0x.

So perhaps we could change the C++ "workaround" to use __typeof__
instead of typeof to support also programs that are using c++0x
standard.
