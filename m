Return-Path: <cyrus@holtmann.org>
Message-ID: <52498C87.7000007@linux.intel.com>
Date: Mon, 30 Sep 2013 16:36:55 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/3] android: Add skeleton of BlueZ Android daemon
References: <1380024798-32017-1-git-send-email-frederic.danis@linux.intel.com> <1380024798-32017-2-git-send-email-frederic.danis@linux.intel.com> <2A24E0BD-2EFF-4811-833E-A850B1469054@holtmann.org>
In-Reply-To: <2A24E0BD-2EFF-4811-833E-A850B1469054@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 27/09/2013 04:05, Marcel Holtmann wrote:
>> Define local mapping to glib path, otherwise this has to be inside central
>> >place in the build repository.
>> >
>> >Retrieve Bluetooth version from configure.ac.
>> >---
>> >.gitignore         |    2 +
>> >Makefile.android   |    5 +++
> I rather keep the changes to a global Makefile separate from the android/ stuff.
>
>> >android/Android.mk |   24 ++++++++++++
>> >android/main.c     |  110 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >4 files changed, 141 insertions(+)
>> >create mode 100644 android/main.c
> It is perfectly fine to split this into two patches. Add the *.c file(s) first and in a second patch add the build changes.
>

Ok, so I will send .gitignore, Makefile.android and Android.mk in a 
second patch.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation
